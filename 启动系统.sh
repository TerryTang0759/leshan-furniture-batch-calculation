#!/bin/bash

# 乐山家具定制 - 柜体投影面积计算系统启动脚本

echo "🏠 乐山家具定制 - 柜体投影面积计算系统"
echo "=========================================="
echo ""

# 获取当前目录
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 检查index.html是否存在
if [ ! -f "$CURRENT_DIR/index.html" ]; then
    echo "❌ 错误：找不到index.html文件"
    echo "   请确保在正确的目录中运行此脚本"
    exit 1
fi

echo "✅ 找到系统文件"
echo "📂 系统目录: $CURRENT_DIR"
echo ""

# 获取系统信息
echo "🔍 系统信息:"
echo "   文件大小: $(ls -lh "$CURRENT_DIR/index.html" | awk '{print $5}')"
echo "   创建时间: $(stat -f "%Sm" "$CURRENT_DIR/index.html")"
echo ""

# 尝试在默认浏览器中打开
echo "🚀 正在启动系统..."

# macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$CURRENT_DIR/index.html"
    echo "✅ 已在默认浏览器中打开系统"
    echo ""
    echo "🌐 访问地址: file://$CURRENT_DIR/index.html"
    echo ""
    echo "💡 使用说明:"
    echo "   1. 输入柜体宽度和高度（cm）"
    echo "   2. 输入拆板总价（元）"
    echo "   3. 点击计算按钮获得投影面积单价"
    echo ""
    echo "📱 系统特色:"
    echo "   • 精确到元的价格计算"
    echo "   • 响应式设计，支持移动端"
    echo "   • 实时计算和历史记录"
    echo "   • 键盘快捷键支持"
    echo ""
    echo "🎯 计算公式:"
    echo "   投影面积单价 = 拆板总价 ÷ (柜体宽度 × 柜体高度)"
    echo ""
    echo "✨ 系统已启动，祝您使用愉快！"
    
# Linux
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "$CURRENT_DIR/index.html"
    echo "✅ 已在默认浏览器中打开系统"
    
# Windows (Git Bash)
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    start "$CURRENT_DIR/index.html"
    echo "✅ 已在默认浏览器中打开系统"
    
else
    echo "⚠️  无法自动打开浏览器，请手动打开以下文件："
    echo "   $CURRENT_DIR/index.html"
fi

echo ""
echo "📞 技术支持: 乐山家具定制团队"
echo "🏠 品牌: 乐山家具定制"
