#!/bin/bash

# 乐山家具定制 - EdgeOne部署脚本

echo "🚀 乐山家具定制批量计算系统 - EdgeOne部署"
echo "============================================="
echo ""

# 检查当前目录
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "📂 项目目录: $CURRENT_DIR"
echo ""

# 检查必要文件
echo "🔍 检查必要文件..."
required_files=("api.js" "package.json" "edgeone.json" "batch.html")
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ 缺少文件: $file"
        exit 1
    fi
done

echo ""

# 检查EdgeOne CLI
echo "🔍 检查EdgeOne CLI..."
if command -v edgeone &> /dev/null; then
    echo "✅ EdgeOne CLI已安装"
    edgeone --version
else
    echo "📦 安装EdgeOne CLI..."
    npm install -g edgeone
    if [ $? -eq 0 ]; then
        echo "✅ EdgeOne CLI安装成功"
    else
        echo "❌ EdgeOne CLI安装失败"
        echo "请手动安装: npm install -g edgeone"
        exit 1
    fi
fi

echo ""

# 检查登录状态
echo "🔍 检查EdgeOne登录状态..."
if edgeone whoami &> /dev/null; then
    echo "✅ 已登录EdgeOne"
    edgeone whoami
else
    echo "🔐 需要登录EdgeOne..."
    edgeone login
    if [ $? -eq 0 ]; then
        echo "✅ 登录成功"
    else
        echo "❌ 登录失败"
        exit 1
    fi
fi

echo ""

# 显示环境变量配置
echo "🔧 环境变量配置"
echo "请确保在EdgeOne中配置以下环境变量："
echo ""
echo "MONGODB_USERNAME=terry07590759"
echo "MONGODB_PASSWORD=Na0E6iNR4p3gGNg1"
echo "MONGODB_CLUSTER=cluster0.zqsy7.mongodb.net"
echo "MONGODB_DATABASE=Leshan20250911"
echo "MONGODB_COLLECTION=price_template"
echo "NODE_ENV=production"
echo ""

# 部署选项
echo "🎯 部署选项："
echo "1. 立即部署到EdgeOne"
echo "2. 配置环境变量"
echo "3. 显示部署命令"
echo "4. 退出"
echo ""

read -p "请选择操作 (1-4): " choice

case $choice in
    1)
        echo "🚀 开始部署到EdgeOne..."
        echo ""
        
        # 部署项目
        edgeone deploy
        
        if [ $? -eq 0 ]; then
            echo ""
            echo "✅ 部署成功！"
            echo "🌐 您的应用已部署到EdgeOne"
            echo ""
            echo "📋 后续步骤："
            echo "1. 配置环境变量"
            echo "2. 测试应用功能"
            echo "3. 设置自定义域名（可选）"
        else
            echo "❌ 部署失败"
            echo "请检查错误信息并重试"
        fi
        ;;
    2)
        echo "🔧 配置环境变量..."
        echo ""
        
        # 设置环境变量
        edgeone env add MONGODB_USERNAME terry07590759
        edgeone env add MONGODB_PASSWORD Na0E6iNR4p3gGNg1
        edgeone env add MONGODB_CLUSTER cluster0.zqsy7.mongodb.net
        edgeone env add MONGODB_DATABASE Leshan20250911
        edgeone env add MONGODB_COLLECTION price_template
        edgeone env add NODE_ENV production
        
        echo ""
        echo "✅ 环境变量配置完成"
        ;;
    3)
        echo "📋 EdgeOne部署命令："
        echo ""
        echo "# 安装EdgeOne CLI"
        echo "npm install -g edgeone"
        echo ""
        echo "# 登录EdgeOne"
        echo "edgeone login"
        echo ""
        echo "# 部署项目"
        echo "edgeone deploy"
        echo ""
        echo "# 配置环境变量"
        echo "edgeone env add MONGODB_USERNAME terry07590759"
        echo "edgeone env add MONGODB_PASSWORD Na0E6iNR4p3gGNg1"
        echo "edgeone env add MONGODB_CLUSTER cluster0.zqsy7.mongodb.net"
        echo "edgeone env add MONGODB_DATABASE Leshan20250911"
        echo "edgeone env add MONGODB_COLLECTION price_template"
        echo "edgeone env add NODE_ENV production"
        echo ""
        echo "# 查看部署状态"
        echo "edgeone status"
        echo ""
        echo "# 查看日志"
        echo "edgeone logs"
        ;;
    4)
        echo "👋 退出部署脚本"
        exit 0
        ;;
    *)
        echo "❌ 无效选择"
        exit 1
        ;;
esac

echo ""
echo "🎯 部署后访问："
echo "• 主页面: https://your-app.edgeone.app"
echo "• API接口: https://your-app.edgeone.app/api/prices"
echo "• 健康检查: https://your-app.edgeone.app/api/health"
echo ""
echo "🔧 EdgeOne控制台: https://console.edgeone.com"
echo ""
echo "📞 技术支持: 乐山家具定制团队"
echo "🏠 品牌: 乐山家具定制"
