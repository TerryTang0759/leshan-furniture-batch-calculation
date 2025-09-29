#!/bin/bash

# 乐山家具定制 - GitHub文件上传脚本

echo "📁 乐山家具定制批量计算系统 - GitHub文件上传"
echo "============================================="
echo ""

# 当前目录
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "📂 项目目录: $CURRENT_DIR"
echo ""

# 检查Git状态
echo "🔍 检查Git状态..."
git status --porcelain
if [ $? -eq 0 ]; then
    echo "✅ Git仓库状态正常"
else
    echo "❌ Git仓库有问题"
fi

echo ""

# 显示需要上传的文件
echo "📋 需要上传的重要文件："
echo ""
echo "核心文件："
echo "  ✅ api.js - API服务器"
echo "  ✅ package.json - 项目配置"
echo "  ✅ vercel.json - Vercel部署配置"
echo "  ✅ 测试页面.html - 主页面"
echo "  ✅ 批量计算系统.html - 完整系统"
echo "  ✅ index.html - 单个计算系统"
echo ""
echo "配置文件："
echo "  ✅ .gitignore - Git忽略文件"
echo "  ✅ vercel部署脚本.sh - 部署脚本"
echo "  ✅ 启动批量计算系统.sh - 启动脚本"
echo ""
echo "文档文件："
echo "  ✅ README.md - 项目说明"
echo "  ✅ 使用说明.md - 使用指南"
echo "  ✅ 计算逻辑说明.md - 计算逻辑"
echo "  ✅ Vercel部署完整指南.md - 部署指南"
echo "  ✅ GitHub文件上传指南.md - 上传指南"
echo ""

# 显示上传选项
echo "🎯 上传选项："
echo "1. 通过GitHub网站直接上传（推荐）"
echo "2. 使用GitHub Desktop"
echo "3. 尝试Git推送"
echo "4. 创建ZIP文件"
echo ""

read -p "请选择上传方式 (1-4): " choice

case $choice in
    1)
        echo "🌐 通过GitHub网站上传："
        echo ""
        echo "步骤："
        echo "1. 访问: https://github.com/TerryTang0759/leshan-furniture-batch-calculation"
        echo "2. 点击 'Add file' → 'Upload files'"
        echo "3. 拖拽文件或选择文件"
        echo "4. 填写提交信息: 'feat: 添加Vercel部署配置和指南'"
        echo "5. 点击 'Commit changes'"
        echo ""
        echo "🔗 GitHub仓库: https://github.com/TerryTang0759/leshan-furniture-batch-calculation"
        echo ""
        ;;
    2)
        echo "💻 使用GitHub Desktop："
        echo ""
        echo "步骤："
        echo "1. 下载GitHub Desktop: https://desktop.github.com/"
        echo "2. 克隆仓库: TerryTang0759/leshan-furniture-batch-calculation"
        echo "3. 复制文件到克隆的目录"
        echo "4. 在GitHub Desktop中提交并推送"
        echo ""
        ;;
    3)
        echo "🔧 尝试Git推送："
        echo ""
        echo "执行命令："
        echo "git push origin main"
        echo ""
        
        read -p "是否立即执行推送? (y/n): " confirm
        if [ "$confirm" = "y" ]; then
            git push origin main
            if [ $? -eq 0 ]; then
                echo "✅ 推送成功！"
            else
                echo "❌ 推送失败，请检查网络连接"
                echo "建议使用GitHub网站直接上传"
            fi
        fi
        echo ""
        ;;
    4)
        echo "📦 创建ZIP文件："
        echo ""
        echo "步骤："
        echo "1. 在Finder中选择所有文件"
        echo "2. 右键选择 '压缩X个项目'"
        echo "3. 重命名为: leshan-furniture-batch-calculation.zip"
        echo "4. 上传ZIP文件到GitHub"
        echo ""
        ;;
    *)
        echo "❌ 无效选择"
        exit 1
        ;;
esac

echo ""
echo "🎯 上传后验证："
echo "1. 访问GitHub仓库页面"
echo "2. 确认所有文件都已上传"
echo "3. 检查文件内容是否正确"
echo ""
echo "🔍 仓库地址: https://github.com/TerryTang0759/leshan-furniture-batch-calculation"
echo ""
echo "📞 技术支持: 乐山家具定制团队"
echo "🏠 品牌: 乐山家具定制"
