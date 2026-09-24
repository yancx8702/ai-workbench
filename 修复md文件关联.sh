#!/bin/bash
# 修复 .md 文件默认打开方式

echo "🔧 修复 .md 文件默认打开方式"
echo "=========================="
echo ""

# 清除 LaunchServices 缓存
echo "1. 清除 LaunchServices 缓存..."
rm -f ~/Library/Caches/com.apple.LaunchServices-010.csdat
rm -f ~/Library/Caches/com.apple.LaunchServices-010.csdv
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -u 2>/dev/null
echo "   ✅ 缓存已清除"
echo ""

# 提示用户手动操作
echo "2. 请手动设置 .md 文件的默认打开方式："
echo ""
echo "   ① 打开 Finder，找到以下文件："
echo "      ~/pi/workbench-deploy/部署指南.md"
echo ""
echo "   ② 右键点击文件 → 显示简介"
echo ""
echo "   ③ 在'打开方式'部分，点击下拉菜单选择 'TextEdit'"
echo ""
echo "   ④ 点击下方的 '全部更改...' 按钮"
echo ""
echo "   ⑤ 在弹出的对话框中点击 '继续'"
echo ""
echo "✅ 完成后，所有 .md 文件都会用 TextEdit 打开"
echo ""
echo "💡 提示：如果 TextEdit 不在列表中，选择'其他...'，"
echo "   然后在应用程序文件夹中找到 TextEdit.app"
