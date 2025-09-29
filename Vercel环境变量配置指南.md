# 🔧 Vercel环境变量配置指南

## 🚨 问题解决

### 错误信息
```
Environment Variable "MONGODB_USERNAME" references Secret "mongodb_username", which does not exist.
```

### 问题原因
`vercel.json` 文件中使用了错误的环境变量引用语法 `@mongodb_username`，这是Vercel的旧版本语法。

### ✅ 解决方案

## 🌐 方法一：通过Vercel网站配置环境变量（推荐）

### 步骤1：登录Vercel控制台
1. 访问 https://vercel.com
2. 登录您的账号
3. 找到您的项目：`leshan-furniture-batch-calculation`

### 步骤2：配置环境变量
1. 点击项目进入详情页
2. 点击 **"Settings"** 标签
3. 在左侧菜单选择 **"Environment Variables"**
4. 添加以下环境变量：

| 变量名 | 值 | 环境 |
|--------|-----|------|
| `MONGODB_USERNAME` | `terry07590759` | Production, Preview, Development |
| `MONGODB_PASSWORD` | `Na0E6iNR4p3gGNg1` | Production, Preview, Development |
| `MONGODB_CLUSTER` | `cluster0.zqsy7.mongodb.net` | Production, Preview, Development |
| `MONGODB_DATABASE` | `Leshan20250911` | Production, Preview, Development |
| `MONGODB_COLLECTION` | `price_template` | Production, Preview, Development |
| `NODE_ENV` | `production` | Production, Preview, Development |

### 步骤3：重新部署
1. 环境变量配置完成后
2. 点击 **"Deployments"** 标签
3. 点击最新部署右侧的 **"..."** 菜单
4. 选择 **"Redeploy"**
5. 等待重新部署完成

## 💻 方法二：使用Vercel CLI配置

### 安装Vercel CLI
```bash
npm install -g vercel
```

### 登录Vercel
```bash
vercel login
```

### 配置环境变量
```bash
# 进入项目目录
cd "/Users/terry/Documents/AI/cursor/云数据库定制报价20250911/柜体投影面积计算系统"

# 添加环境变量
vercel env add MONGODB_USERNAME
# 输入: terry07590759

vercel env add MONGODB_PASSWORD
# 输入: Na0E6iNR4p3gGNg1

vercel env add MONGODB_CLUSTER
# 输入: cluster0.zqsy7.mongodb.net

vercel env add MONGODB_DATABASE
# 输入: Leshan20250911

vercel env add MONGODB_COLLECTION
# 输入: price_template

vercel env add NODE_ENV
# 输入: production
```

### 重新部署
```bash
vercel --prod
```

## 📋 修复后的vercel.json配置

修复后的 `vercel.json` 文件已移除环境变量引用：

```json
{
  "version": 2,
  "builds": [
    {
      "src": "api.js",
      "use": "@vercel/node"
    },
    {
      "src": "测试页面.html",
      "use": "@vercel/static"
    },
    {
      "src": "批量计算系统.html",
      "use": "@vercel/static"
    },
    {
      "src": "index.html",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/api.js"
    },
    {
      "src": "/test",
      "dest": "/测试页面.html"
    },
    {
      "src": "/batch",
      "dest": "/批量计算系统.html"
    },
    {
      "src": "/(.*)",
      "dest": "/测试页面.html"
    }
  ]
}
```

## 🔍 验证配置

### 检查环境变量
1. 在Vercel控制台的 **"Environment Variables"** 页面
2. 确认所有变量都已正确添加
3. 检查变量值是否正确

### 测试部署
1. 访问您的Vercel域名
2. 测试API接口：`https://your-app.vercel.app/api/health`
3. 测试批量计算：`https://your-app.vercel.app/test`

## 🎯 部署步骤总结

### 完整部署流程
1. ✅ **修复vercel.json** - 移除错误的环境变量引用
2. ✅ **提交到GitHub** - 推送修复后的文件
3. ✅ **配置环境变量** - 在Vercel控制台添加环境变量
4. ✅ **重新部署** - 触发新的部署
5. ✅ **验证功能** - 测试所有功能是否正常

### 环境变量清单
确保以下环境变量都已正确配置：

```env
MONGODB_USERNAME=terry07590759
MONGODB_PASSWORD=Na0E6iNR4p3gGNg1
MONGODB_CLUSTER=cluster0.zqsy7.mongodb.net
MONGODB_DATABASE=Leshan20250911
MONGODB_COLLECTION=price_template
NODE_ENV=production
```

## 🆘 故障排除

### 常见问题
1. **环境变量未生效**: 需要重新部署项目
2. **API无法连接**: 检查MongoDB连接字符串
3. **页面无法加载**: 检查路由配置

### 调试步骤
1. 检查Vercel部署日志
2. 验证环境变量配置
3. 测试API接口连通性

---

**🔧 按照上述步骤配置环境变量，您的乐山家具定制系统就能在Vercel上正常运行了！**
