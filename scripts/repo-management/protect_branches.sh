#!/bin/bash


if [ -f .env ]; then
  echo ".envファイルから設定を読み込みます"
  export $(grep -v '^#' .env | xargs)
else
  echo "警告: .envファイルが見つかりません"
fi

if [ -z "$GITHUB_USERNAME" ]; then
  echo "エラー: GITHUB_USERNAME が設定されていません"
  echo "以下のいずれかの方法で設定してください:"
  echo "1. .envファイルに GITHUB_USERNAME=YourUsername を追加"
  echo "2. 実行時に GITHUB_USERNAME=YourUsername ./protect_branches.sh を使用"
  exit 1
fi

USER="$GITHUB_USERNAME"
echo "GitHub ユーザー: $USER のリポジトリを処理します"

# リポジトリのリストを取得
repos=$(gh repo list $USER --json name -q '.[].name')

# 各リポジトリの処理
for repo in $repos; do
  echo "リポジトリを処理中: $repo"
  
  # デフォルトブランチ名を取得
  default_branch=$(gh api repos/$USER/$repo --jq '.default_branch')
  echo "デフォルトブランチ: $default_branch"
  
  # よく使われるブランチ名の配列（デフォルトブランチは必ず含める）
  branches=("$default_branch")
  
  # もしデフォルトブランチがmainでもmasterでもない場合、両方を追加
  if [ "$default_branch" != "main" ] && [ "$default_branch" != "master" ]; then
    branches+=("main" "master")
  # デフォルトブランチがmainの場合、masterも追加
  elif [ "$default_branch" = "main" ]; then
    branches+=("master")
  # デフォルトブランチがmasterの場合、mainも追加
  elif [ "$default_branch" = "master" ]; then
    branches+=("main")
  fi
  
  # 各ブランチに保護ルールを適用
  for branch in "${branches[@]}"; do
    echo "ブランチを保護中: $branch"
    
    # ブランチが存在するか確認（APIエラーを回避するため）
    branch_exists=$(gh api repos/$USER/$repo/branches/$branch --silent || echo "not_exists")
    
    if [ "$branch_exists" != "not_exists" ]; then
      # ブランチ保護ルールを設定
      gh api -X PUT \
        /repos/$USER/$repo/branches/$branch/protection \
        -f required_pull_request_reviews.required_approving_review_count=1 \
        -f required_pull_request_reviews.dismiss_stale_reviews=true \
        -f enforce_admins=false
      
      echo "✅ $repo の $branch ブランチを保護しました"
    else
      echo "⚠️ $repo に $branch ブランチが存在しないためスキップします"
    fi
  done
  
  echo "----------------------------"
done

echo "完了しました！"