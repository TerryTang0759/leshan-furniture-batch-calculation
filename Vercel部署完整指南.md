# 🚀 Vercel部署完整指南

## 📋 当前状态
- ✅ GitHub仓库已创建: `TerryTang0759/leshan-furniture-batch-calculation`
- ✅ 所有文件已提交并推送
- ✅ Vercel配置文件已准备
- ✅ 环境变量配置已准备

## 🌐 方法一：通过Vercel网站部署（最简单）

### 步骤1：访问Vercel
1. 打开浏览器，访问 https://vercel.com
2. 点击右上角的 "Sign up" 或 "Log in"

### 步骤2：登录
1. 选择 "Continue with GitHub"
2. 授权Vercel访问您的GitHub账号
3. 完成登录

### 步骤3：导入项目
1. 在Vercel控制台点击 **"New Project"**
2. 在项目列表中找到：`TerryTang0759/leshan-furniture-batch-calculation`
3. 点击 **"Import"** 按钮

### 步骤4：配置项目
```
Project Name: leshan-furniture-batch-calculation
Framework Preset: Other
Root Directory: ./
Build Command: (留空)
Output Directory: (留空)
Install Command: npm install
```

### 步骤5：配置环境变量
在 "Environment Variables" 部分添加：

| 变量名 | 值 |
|--------|-----|
| `MONGODB_USERNAME` | `terry07590759` |
| `MONGODB_PASSWORD` | `Na0E6iNR4p3gGNg1` |
| `MONGODB_CLUSTER` | `cluster0.zqsy7.mongodb.net` |
| `MONGODB_DATABASE` | `Leshan20250911` |
| `MONGODB_COLLECTION` | `price_template` |
| `NODE_ENV` | `production` |

### 步骤6：部署
1. 点击 **"Deploy"** 按钮
2. 等待部署完成（约2-3分钟）
3. 部署成功后，您会得到类似这样的域名：
   `https://leshan-furniture-batch-calculation-xxx.vercel.app`

## 💻 方法二：使用Vercel CLI部署

### 步骤1：登录Vercel CLI
```bash
cd "/Users/terry/Documents/AI/cursor/云数据库定制报价20250911/柜体投影面积计算系统"
npx vercel login
```

### 步骤2：部署项目
```bash
npx vercel
```

### 步骤3：配置环境变量
```bash
npx vercel env add MONGODB_USERNAME
# 输入: terry07590759

npx vercel env add MONGODB_PASSWORD
# 输入: Na0E6iNR4p3gGNg1

npx vercel env add MONGODB_CLUSTER
# 输入: cluster0.zqsy7.mongodb.net

npx vercel env add MONGODB_DATABASE
# 输入: Leshan20250911

npx vercel env add MONGODB_COLLECTION
# 输入: price_template

npx vercel env add NODE_ENV
# 输入: production
```

### 步骤4：重新部署
```bash
npx vercel --prod
```

## 🔧 部署配置说明

### vercel.json 配置
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

## 🌐 部署后访问地址

部署完成后，您可以通过以下地址访问：

### 主页面
- **测试页面**: `https://your-app.vercel.app/test`
- **完整系统**: `https://your-app.vercel.app/batch`
- **单个计算**: `https://your-app.vercel.app/`

### API接口
- **材质价格**: `https://your-app.vercel.app/api/prices`
- **批量计算**: `https://your-app.vercel.app/api/batch-calculate?height=2000&width=800&depth=600`
- **健康检查**: `https://your-app.vercel.app/api/health`

## 🔍 部署验证

### 检查部署状态
```bash
# 查看部署列表
npx vercel ls

# 查看项目信息
npx vercel inspect

# 查看日志
npx vercel logs
```

### 测试功能
1. 访问测试页面
2. 输入尺寸数据：高2000mm，宽800mm，深600mm
3. 点击"批量计算所有材质投影面积单价"
4. 验证计算结果

## 🎯 推荐部署流程

### 最简单的方式（推荐）
1. **使用Vercel网站部署**
2. **一键导入GitHub仓库**
3. **配置环境变量**
4. **点击部署**

### 命令行方式
1. **登录Vercel CLI**
2. **执行部署命令**
3. **配置环境变量**
4. **重新部署**

## 🔒 安全注意事项

1. **环境变量安全**: 确保MongoDB密码等敏感信息正确配置
2. **访问权限**: 检查MongoDB Atlas的IP白名单设置
3. **HTTPS**: Vercel自动提供HTTPS证书
4. **域名**: 可以使用自定义域名

## 📞 技术支持

### 常见问题
1. **部署失败**: 检查环境变量配置
2. **API无法访问**: 确认MongoDB连接设置
3. **页面无法加载**: 检查vercel.json路由配置

### 联系信息
- **项目**: 乐山家具定制批量投影面积计算系统
- **品牌**: 乐山家具定制
- **仓库**: https://github.com/TerryTang0759/leshan-furniture-batch-calculation

---

**🚀 开始部署您的乐山家具定制系统到Vercel吧！**
