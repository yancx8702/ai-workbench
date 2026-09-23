#!/bin/bash
# GitHub Pages 自动启用脚本
set -e

REPO="yancx8702/ai-workbench"
BRANCH="gh-pages"

echo "🚀 GitHub Pages 自动启用脚本"
echo "=========================="
echo ""

# 检查是否有 token
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ 未找到 GITHUB_TOKEN 环境变量"
    echo ""
    echo "请先生成 Personal Access Token："
    echo "1. 打开: https://github.com/settings/tokens/new"
    echo "2. Note: ai-workbench-pages"
    echo "3. Expiration: 1 year"
    echo "4. Select scopes: repo (full control)"
    echo "5. 点击 Generate token"
    echo "6. 复制 token 并运行:"
    echo "   export GITHUB_TOKEN=ghp_xxxxxxxx"
    echo "   bash ~/pi/workbench-deploy/enable-pages.sh"
    exit 1
fi

echo "✅ 已找到 GitHub Token"
echo ""

# 启用 Pages
echo "📄 正在启用 GitHub Pages..."
RESPONSE=$(curl -s -X POST "https://api.github.com/repos/$REPO/pages" \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "{\"branch\": \"$BRANCH\"}")

echo "$RESPONSE" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    if 'message' in d:
        print(f'❌ 错误: {d[\"message\"]}')
    else:
        url = d.get('html_url', 'https://yancx8702.github.io/ai-workbench/')
        print(f'✅ GitHub Pages 已启用!')
        print(f'🌐 访问地址: {url}')
except Exception as e:
    print(f'响应: {d}')
"

echo ""
echo "如果 30 秒后还没有显示，请刷新页面查看状态。"
