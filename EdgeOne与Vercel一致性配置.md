# 🔧 EdgeOne与Vercel一致性配置指南

## 🎯 目标

确保EdgeOne部署的批量计算系统与Vercel部署的完全一致，包括页面显示、功能和用户体验。

## 📋 配置对比

### 当前配置状态

#### Vercel配置 (vercel.json)
```json
{
  "version": 2,
  "builds": [
    {
      "src": "api.js",
      "use": "@vercel/node"
    },
    {
      "src": "batch.html",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/api.js"
    },
    {
      "src": "/(.*)",
      "dest": "/batch.html"
    }
  ]
}
```

#### EdgeOne配置 (edgeone.json)
```json
{
  "version": 2,
  "builds": [
    {
      "src": "api.js",
      "use": "@vercel/node"
    },
    {
      "src": "batch.html",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/api.js"
    },
    {
      "src": "/(.*)",
      "dest": "/batch.html"
    }
  ]
}
```

## ✅ 一致性检查清单

### 1. 构建器配置
- ✅ **Node.js构建器**: 使用`@vercel/node`处理API
- ✅ **静态文件构建器**: 使用`@vercel/static`处理HTML
- ✅ **构建命令**: `npm install`

### 2. 路由配置
- ✅ **API路由**: `/api/*` → `api.js`
- ✅ **主页面路由**: `/*` → `batch.html`
- ✅ **路由优先级**: API路由优先于静态文件

### 3. 环境变量
- ✅ **MongoDB配置**: 相同的数据库连接参数
- ✅ **Node环境**: `NODE_ENV=production`
- ✅ **端口配置**: 自动端口分配

### 4. 文件结构
- ✅ **主页面**: `batch.html`（批量计算系统）
- ✅ **API服务器**: `api.js`（Express服务器）
- ✅ **依赖配置**: `package.json`（相同的依赖版本）

## 🔍 问题排查

### 如果EdgeOne页面与Vercel不一致

#### 检查1：构建器配置
```bash
# 确认EdgeOne使用正确的构建器
# 在edgeone.json中应该使用：
"use": "@vercel/node"     # 不是 "@edgeone/node"
"use": "@vercel/static"   # 不是 "@edgeone/static"
```

#### 检查2：路由配置
```bash
# 确认路由配置正确
# 主页面应该指向batch.html，不是index.html
{
  "src": "/(.*)",
  "dest": "/batch.html"    # ✅ 正确
  # "dest": "/index.html"  # ❌ 错误
}
```

#### 检查3：环境变量
```bash
# 确认所有环境变量都已配置
MONGODB_USERNAME=terry07590759
MONGODB_PASSWORD=Na0E6iNR4p3gGNg1
MONGODB_CLUSTER=cluster0.zqsy7.mongodb.net
MONGODB_DATABASE=Leshan20250911
MONGODB_COLLECTION=price_template
NODE_ENV=production
```

## 🚀 重新部署步骤

### 如果发现不一致，按以下步骤重新部署：

#### 步骤1：更新配置
```bash
# 确保edgeone.json与vercel.json完全一致
cp vercel.json edgeone.json
```

#### 步骤2：推送更改
```bash
git add .
git commit -m "fix: 确保EdgeOne与Vercel配置一致"
git push origin main
```

#### 步骤3：重新部署EdgeOne
```bash
# 在EdgeOne控制台中重新部署
# 或使用CLI：
edgeone pages deploy
```

## 📊 验证方法

### 功能对比测试
1. **页面加载**: 两个平台都应该显示相同的批量计算界面
2. **API功能**: `/api/prices`和`/api/batch-calculate`应该工作一致
3. **Excel导出**: 下载功能应该在两个平台都正常
4. **响应速度**: 两个平台都应该有良好的响应速度

### 视觉对比测试
1. **界面布局**: 表单、按钮、表格布局应该完全一致
2. **样式显示**: 颜色、字体、间距应该相同
3. **交互效果**: 悬停、点击效果应该一致

## 🎯 预期结果

部署完成后，您应该看到：

### EdgeOne部署
- **URL**: `https://your-app.edgeone.app`
- **页面**: 与Vercel完全相同的批量计算界面
- **功能**: 所有功能正常工作

### Vercel部署
- **URL**: `https://your-app.vercel.app`
- **页面**: 批量计算界面
- **功能**: 所有功能正常工作

## 📞 技术支持

如果仍然存在不一致问题：

1. **检查构建日志**: 查看EdgeOne部署日志中的错误信息
2. **对比网络请求**: 使用浏览器开发者工具对比API响应
3. **联系支持**: EdgeOne技术支持或项目维护团队

---

**🏠 乐山家具定制** - 确保EdgeOne与Vercel部署完全一致！
