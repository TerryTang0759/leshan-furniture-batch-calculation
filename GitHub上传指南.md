# 🚀 GitHub上传指南

## 📋 当前状态
- ✅ Git仓库已初始化
- ✅ 所有文件已添加到Git
- ✅ 首次提交已完成
- ✅ 准备上传到GitHub

## 🌐 手动创建GitHub仓库

### 步骤1：登录GitHub
1. 访问 https://github.com
2. 登录您的GitHub账号

### 步骤2：创建新仓库
1. 点击右上角的 "+" 号
2. 选择 "New repository"
3. 填写仓库信息：
   - **Repository name**: `leshan-furniture-batch-calculation`
   - **Description**: `乐山家具定制批量投影面积计算系统 - 统一尺寸批量计算所有材质投影面积单价`
   - **Visibility**: 选择 `Public` 或 `Private`
   - **不要**勾选 "Add a README file"
   - **不要**勾选 "Add .gitignore"
   - **不要**勾选 "Choose a license"
4. 点击 "Create repository"

### 步骤3：连接本地仓库
复制GitHub提供的命令，类似：
```bash
git remote add origin https://github.com/YOUR_USERNAME/leshan-furniture-batch-calculation.git
git branch -M main
git push -u origin main
```

### 步骤4：执行上传命令
在终端中执行上述命令：

```bash
cd "/Users/terry/Documents/AI/cursor/云数据库定制报价20250911/柜体投影面积计算系统"

# 添加远程仓库（替换YOUR_USERNAME为您的GitHub用户名）
git remote add origin https://github.com/YOUR_USERNAME/leshan-furniture-batch-calculation.git

# 设置主分支
git branch -M main

# 推送到GitHub
git push -u origin main
```

## 🔧 使用GitHub CLI（推荐）

如果您想使用GitHub CLI，请先登录：

```bash
gh auth login
```

然后创建仓库：
```bash
gh repo create leshan-furniture-batch-calculation --public --description "乐山家具定制批量投影面积计算系统 - 统一尺寸批量计算所有材质投影面积单价" --source=. --remote=origin --push
```

## 📁 仓库内容

上传后的仓库将包含：

### 核心文件
- `api.js` - API服务器
- `index.html` - 单个柜体计算系统
- `批量计算系统.html` - 完整批量计算界面
- `测试页面.html` - 简化测试页面

### 配置文件
- `package.json` - 项目配置和依赖
- `package-lock.json` - 依赖锁定文件
- `.gitignore` - Git忽略文件

### 启动脚本
- `启动批量计算系统.sh` - 批量系统启动脚本
- `启动系统.sh` - 单个系统启动脚本

### 文档
- `README.md` - 项目说明文档
- `使用说明.md` - 详细使用说明
- `计算逻辑说明.md` - 计算逻辑详细说明

## 🌟 仓库特色

### 功能亮点
- ✅ **批量计算**: 一次输入，计算所有材质
- ✅ **MongoDB集成**: 从数据库获取最新价格
- ✅ **计算透明**: 详细展示计算过程
- ✅ **响应式设计**: 支持各种设备
- ✅ **完整文档**: 详细的使用和逻辑说明

### 技术栈
- **前端**: HTML5 + CSS3 + JavaScript
- **后端**: Node.js + Express.js
- **数据库**: MongoDB Atlas
- **部署**: 支持本地和云端部署

## 🎯 后续步骤

上传完成后，您可以：

1. **添加部署说明**: 在README中添加部署指南
2. **设置GitHub Pages**: 部署静态页面
3. **添加CI/CD**: 自动化部署流程
4. **创建Issues**: 记录功能需求和问题
5. **添加标签**: 方便分类管理

## 📞 技术支持

如有问题，请检查：
- Git配置是否正确
- GitHub账号权限
- 网络连接状态
- 仓库名称是否冲突

---

**乐山家具定制** - 让投影面积计算系统开源共享！
