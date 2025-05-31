# 🛠️ GitHub Tools

A collection of useful tools and scripts for managing and automating GitHub workflows.

## 🚀 Introduction

GitHub Tools is an open-source collection of scripts and utilities designed to simplify and automate common GitHub tasks. Whether you're managing multiple repositories, enforcing branch protection rules, or automating repetitive tasks, this toolkit aims to make your GitHub workflow more efficient.

## 🧰 Features

- **🔒 Repository Protection**: Automatically apply branch protection rules across all your repositories (prevents direct pushes but allows PRs without approval)
- **More tools coming soon!**

## 📋 Requirements

- [GitHub CLI](https://cli.github.com/) installed and authenticated
- Bash shell environment
- Git

## 🔧 Installation

```bash
# Clone the repository
git clone https://github.com/HasutoSasaki/github-tools.git
cd github-tools

# Copy the example environment file and edit with your settings
cp .env.example .env
nano .env  # Edit with your preferred text editor
```

## 📚 Available Tools

### 🔒 Branch Protection Script

Automatically applies branch protection rules to all public repositories owned by a specified GitHub user. The script prevents direct pushes to protected branches but allows PRs to be merged without requiring approvals, making it ideal for solo developers.

```bash
# Run with environment variables from .env file
cd scripts/repo-management
./protect_branches.sh

# Or run with environment variables specified inline
GITHUB_USERNAME=yourusername ./protect_branches.sh
```

> **Note**: Due to GitHub's limitations, branch protection rules are only applied to public repositories unless you have a GitHub Team or Enterprise plan.

## 🔑 Environment Configuration

Create a `.env` file in the root directory with the following variables:

```
GITHUB_USERNAME=yourusername
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 🙏 Acknowledgments

- GitHub CLI team for their excellent command-line tool
