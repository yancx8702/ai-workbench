#!/bin/bash
# GitHub Pages 自动启用脚本

echo "🚀 GitHub Pages 自动启用脚本"
echo "=========================="
echo ""

# 检查 gh CLI
if ! command -v gh &> /dev/null; then
    echo "❌ 未找到 GitHub CLI (gh)"
    echo ""
    echo "请先安装 GitHub CLI:"
    echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/cli/cli/main/install.sh)\""
    echo ""
    echo "安装后运行:"
    echo "gh auth login"
    echo "bash ~/pi/workbench-deploy/启用-GitHub-Pages.sh"
    exit 1
fi

# 检查是否已登录
if ! gh auth status &> /dev/null; then
    echo "❌ 未登录 GitHub"
    echo ""
    echo "请先登录:"
    echo "gh auth login"
    exit 1
fi

echo "✅ 已登录 GitHub"
echo ""

# 启用 Pages
echo "📄 正在启用 GitHub Pages..."
gh api -X POST "repos/yancx8702/ai-workbench/pages" \
    --field branch=gh-pages

echo ""
echo "✅ GitHub Pages 已启用!"
echo "🌐 访问地址: https://yancx8702.github.io/ai-workbench/"
echo ""
echo "等待 1-2 分钟后刷新页面查看效果。"
