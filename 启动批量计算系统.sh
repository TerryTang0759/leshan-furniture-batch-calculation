#!/bin/bash

# 乐山家具定制 - 批量投影面积计算系统启动脚本

echo "🏠 乐山家具定制 - 批量投影面积计算系统"
echo "=========================================="
echo ""

# 获取当前目录
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 检查Node.js是否安装
if ! command -v node &> /dev/null
then
    echo "❌ 错误：未检测到Node.js，请先安装Node.js"
    echo "   下载地址：https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js版本: $(node --version)"
echo ""

# 检查必要文件
if [ ! -f "$CURRENT_DIR/批量计算系统.html" ]; then
    echo "❌ 错误：找不到批量计算系统.html文件"
    exit 1
fi

if [ ! -f "$CURRENT_DIR/api.js" ]; then
    echo "❌ 错误：找不到api.js文件"
    exit 1
fi

echo "✅ 系统文件检查完成"
echo ""

# 检查依赖
echo "📦 检查Node.js依赖..."

# 检查是否需要安装依赖
if [ ! -d "$CURRENT_DIR/node_modules" ]; then
    echo "📦 正在安装npm依赖..."
    npm install express mongodb cors
    
    if [ $? -ne 0 ]; then
        echo "❌ npm依赖安装失败"
        exit 1
    fi
    echo "✅ 依赖安装完成"
else
    echo "✅ 依赖已安装"
fi

echo ""

# 显示系统信息
echo "🔍 系统信息:"
echo "   系统目录: $CURRENT_DIR"
echo "   批量计算页面: $CURRENT_DIR/批量计算系统.html"
echo "   API服务器: $CURRENT_DIR/api.js"
echo ""

# 启动API服务器
echo "🚀 正在启动批量计算系统API服务器..."
echo ""

# 在后台启动API服务器
nohup node api.js > api.log 2>&1 &
API_PID=$!

# 等待服务器启动
sleep 3

# 检查服务器是否启动成功
if ps -p $API_PID > /dev/null; then
    echo "✅ API服务器启动成功 (PID: $API_PID)"
    echo ""
    
    # 获取服务器端口
    PORT=$(grep -o "http://0.0.0.0:[0-9]*" api.log | head -1 | grep -o "[0-9]*")
    if [ -z "$PORT" ]; then
        PORT="3001"
    fi
    
    echo "🌐 访问地址:"
    echo "   批量计算系统: http://localhost:$PORT/"
    echo "   API接口: http://localhost:$PORT/api/prices"
    echo "   健康检查: http://localhost:$PORT/api/health"
    echo ""
    
    # 尝试在默认浏览器中打开
    echo "🚀 正在打开批量计算系统..."
    
    # macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open "http://localhost:$PORT/"
        echo "✅ 已在默认浏览器中打开系统"
    # Linux
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        xdg-open "http://localhost:$PORT/"
        echo "✅ 已在默认浏览器中打开系统"
    # Windows (Git Bash)
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        start "http://localhost:$PORT/"
        echo "✅ 已在默认浏览器中打开系统"
    else
        echo "⚠️  请手动在浏览器中打开: http://localhost:$PORT/"
    fi
    
    echo ""
    echo "💡 使用说明:"
    echo "   1. 输入标准柜体尺寸（高×宽×深）"
    echo "   2. 系统自动计算隔板数量"
    echo "   3. 点击'开始批量计算'"
    echo "   4. 查看所有材质的投影面积单价对比"
    echo ""
    echo "📱 系统特色:"
    echo "   • 从MongoDB自动加载材质数据"
    echo "   • 统一尺寸批量计算"
    echo "   • 自动隔板数量计算"
    echo "   • 价格排序和统计分析"
    echo ""
    echo "🎯 计算公式:"
    echo "   横隔板数 = ⌊高度/400⌋ + 1"
    echo "   纵隔板数 = ⌊宽度/1000⌋ + 1"
    echo "   投影面积单价 = 拆板总价 ÷ (宽×高)"
    echo ""
    echo "📊 日志文件: api.log"
    echo "🛑 停止服务: kill $API_PID"
    echo ""
    echo "✨ 批量计算系统已启动，祝您使用愉快！"
    
else
    echo "❌ API服务器启动失败"
    echo "📋 错误日志:"
    cat api.log
    exit 1
fi

echo ""
echo "📞 技术支持: 乐山家具定制团队"
echo "🏠 品牌: 乐山家具定制"
