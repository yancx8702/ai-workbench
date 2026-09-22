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
