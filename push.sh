#!/usr/bin/env bash
set -e

DEPLOY_DIR="$HOME/pi/workbench-deploy"
OUTPUT_DIR="$HOME/Desktop/AI工作台"

cd "$DEPLOY_DIR"

# 将 push.sh 纳入版本控制（幂等）
git add push.sh 2>/dev/null || true

# 找到最新的日期文件
LATEST_JSON=$(ls -t "$OUTPUT_DIR"/ai-data-*.json 2>/dev/null | head -1)
if [ -z "$LATEST_JSON" ]; then
    echo "⚠️  未找到新的 ai-data JSON 文件，跳过部署"
    exit 0
fi

DATE=$(basename "$LATEST_JSON" | sed 's/ai-data-//;s/\.json//')
echo "📦 部署 $(date +%Y-%m-%d) 的 AI 日报..."

# 复制数据文件
cp "$OUTPUT_DIR/ai-data-${DATE}.json"     "$DEPLOY_DIR/"
cp "$OUTPUT_DIR/AI日报-${DATE}.html"      "$DEPLOY_DIR/"
cp "$OUTPUT_DIR/workbench.html"           "$DEPLOY_DIR/"

echo "💾 文件已复制到部署目录"

# ---- main 分支 ----
git add ai-data-${DATE}.json AI日报-${DATE}.html workbench.html push.sh
git commit -m "更新: AI日报 ${DATE}" || echo "main 分支无变更"
git push origin main

# ---- gh-pages 分支 ----
git checkout -f gh-pages
git merge main --no-edit || true
git push origin gh-pages
git checkout -f main

echo "✅ 部署完成！访问: https://yancx8702.github.io/ai-workbench/workbench.html"
