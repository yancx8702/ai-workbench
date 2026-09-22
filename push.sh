#!/bin/bash
# AI 工作台 - 推送到 GitHub，Cloudflare Pages 自动部署
set -e

REPO_URL="git@github.com:yancx8702/ai-workbench.git"
DEPLOY_DIR="$HOME/pi/workbench-deploy"
WORKDIR="$HOME/Desktop/AI工作台"
TODAY=$(date +%Y-%m-%d)

echo "🚀 开始部署 AI 工作台..."

# 检查源文件是否存在
if [ ! -f "$WORKDIR/workbench.html" ]; then
    echo "❌ 未找到 workbench.html，请先运行 main.py"
    exit 1
fi

if [ ! -f "$WORKDIR/ai-data-${TODAY}.json" ]; then
    echo "⚠️  未找到今日 JSON 数据，尝试使用最新文件..."
    LATEST_JSON=$(ls -t "$WORKDIR"/ai-data-*.json 2>/dev/null | head -1)
    if [ -z "$LATEST_JSON" ]; then
        echo "❌ 没有找到任何 ai-data JSON 文件"
        exit 1
    fi
    TODAY=$(basename "$LATEST_JSON" .json | sed 's/ai-data-//')
fi

echo "📦 今日日期: $TODAY"

# 初始化/清理部署目录
rm -rf "$DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"
cd "$DEPLOY_DIR"

# 复制必要文件
cp "$WORKDIR/workbench.html" ./workbench.html
cp "$WORKDIR/ai-data-${TODAY}.json" ./ai-data-${TODAY}.json
cp "$WORKDIR/AI日报-${TODAY}.html" ./AI日报-${TODAY}.html 2>/dev/null || true

# 添加 README
cat > README.md << 'EOF'
# AI 工作台

由 AI News Agent 每日自动更新的 AI 资讯工作台。

## 架构

- **数据采集**: `~/AI-News-Agent/main.py`（每天 8:00 cron 自动抓取）
- **数据格式**: `ai-data-{date}.json` + 内嵌式 HTML
- **部署**: Cloudflare Pages（从 GitHub 自动部署）

## 手动触发更新

```bash
cd ~/AI-News-Agent
python3 main.py --quiet
cd ~/pi && bash deploy/push.sh
```
EOF

# Git 初始化并提交
git init -q
git config user.email "yancx@local"
git config user.name "yancx"
git add .
git commit -q -m "docs: deploy workbench $(date +%Y-%m-%d)" || echo "💾 无变更，跳过提交"

# 添加远程并推送
git remote add origin "$REPO_URL" 2>/dev/null || true
git push -u origin main --force 2>&1

echo "✅ 已推送到 GitHub: $REPO_URL"
echo "🌐 Cloudflare Pages 将自动部署"
