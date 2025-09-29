# 🚀 EdgeOne部署指南

## 📋 系统概述

将乐山家具定制批量投影面积计算系统部署到EdgeOne Pages平台，享受全球CDN加速和高可用性服务。

## 🌐 EdgeOne Pages部署

### 步骤1：准备部署文件

确保项目包含以下核心文件：
```
leshan-furniture-batch-calculation/
├── api.js                      # API服务器
├── batch.html                  # 批量计算系统主页面
├── package.json                # 项目配置
├── edgeone.json                # EdgeOne部署配置
├── 启动批量计算系统.sh         # 启动脚本
├── README.md                   # 项目说明
└── 其他文档文件...
```

### 步骤2：创建EdgeOne Pages项目

1. **登录EdgeOne控制台**
   - 访问：https://console.edgeone.com
   - 使用您的腾讯云账号登录

2. **创建Pages项目**
   - 点击 "Pages" 菜单
   - 选择 "新建项目"
   - 项目名称：`leshan-furniture-batch-calculation`

3. **连接GitHub仓库**
   - 选择 "从Git仓库导入"
   - 连接GitHub账号
   - 选择仓库：`TerryTang0759/leshan-furniture-batch-calculation`

### 步骤3：配置构建设置

#### 构建设置（确保与Vercel一致）
```
框架预设: Node.js
构建命令: npm install
输出目录: ./
根目录: ./
启动命令: node api.js
```

**重要说明**：
- EdgeOne Pages使用与Vercel相同的构建器（`@vercel/node`和`@vercel/static`）
- 确保路由配置与Vercel完全一致
- 使用相同的`batch.html`作为主页面

#### 环境变量配置
在项目设置中添加以下环境变量：

| 变量名 | 值 | 说明 |
|--------|-----|------|
| `MONGODB_USERNAME` | `terry07590759` | MongoDB用户名 |
| `MONGODB_PASSWORD` | `Na0E6iNR4p3gGNg1` | MongoDB密码 |
| `MONGODB_CLUSTER` | `cluster0.zqsy7.mongodb.net` | MongoDB集群地址 |
| `MONGODB_DATABASE` | `Leshan20250911` | 数据库名称 |
| `MONGODB_COLLECTION` | `price_template` | 集合名称 |
| `NODE_ENV` | `production` | 生产环境标识 |

### 步骤4：自定义域名（可选）

1. **添加自定义域名**
   - 在项目设置中选择 "自定义域名"
   - 添加您的域名（如：`calc.leshanfurniture.com`）

2. **配置DNS**
   - 在域名DNS设置中添加CNAME记录
   - 指向EdgeOne提供的域名

## 🔧 EdgeOne CLI部署（推荐）

### 安装EdgeOne CLI
```bash
npm install -g edgeone
```

### 登录EdgeOne
```bash
edgeone login
```

### 部署项目
```bash
# 进入项目目录
cd "/Users/terry/Documents/AI/cursor/云数据库定制报价20250911/柜体投影面积计算系统"

# 部署到EdgeOne
edgeone deploy
```

### 配置环境变量
```bash
# 设置环境变量
edgeone env add MONGODB_USERNAME terry07590759
edgeone env add MONGODB_PASSWORD Na0E6iNR4p3gGNg1
edgeone env add MONGODB_CLUSTER cluster0.zqsy7.mongodb.net
edgeone env add MONGODB_DATABASE Leshan20250911
edgeone env add MONGODB_COLLECTION price_template
edgeone env add NODE_ENV production
```

## 📊 部署配置说明

### edgeone.json配置
```json
{
  "version": 2,
  "name": "leshan-furniture-batch-calculation",
  "builds": [
    {
      "src": "api.js",
      "use": "@edgeone/node"
    },
    {
      "src": "batch.html",
      "use": "@edgeone/static"
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
  ],
  "env": {
    "NODE_ENV": "production"
  }
}
```

### 路由配置说明
- `/api/*` → 转发到Node.js API服务器
- `/*` → 服务静态HTML文件

## 🌐 部署后访问

### 默认域名
部署完成后，您将获得EdgeOne提供的默认域名：
```
https://leshan-furniture-batch-calculation-xxx.edgeone.app
```

### 访问地址
- **主页面**: `https://your-domain.edgeone.app/`
- **API接口**: `https://your-domain.edgeone.app/api/prices`
- **健康检查**: `https://your-domain.edgeone.app/api/health`

## 🎯 EdgeOne优势

### 性能优势
- **全球CDN**: 自动分发到全球节点
- **边缘计算**: 就近处理请求
- **智能缓存**: 自动优化缓存策略

### 可靠性优势
- **高可用性**: 99.9%+ SLA保证
- **自动扩容**: 根据流量自动扩展
- **故障转移**: 自动故障恢复

### 安全优势
- **DDoS防护**: 自动防护恶意攻击
- **SSL证书**: 自动HTTPS加密
- **访问控制**: 灵活的访问策略

## 🔍 部署验证

### 功能测试
1. **访问主页面**: 确认页面正常加载
2. **测试API**: 验证MongoDB连接
3. **批量计算**: 测试核心计算功能
4. **Excel导出**: 验证文件下载功能

### 性能测试
1. **加载速度**: 测试页面加载时间
2. **API响应**: 测试接口响应速度
3. **并发测试**: 测试多用户访问

## 🆘 故障排除

### 常见问题
1. **部署失败**: 检查构建日志和依赖
2. **环境变量**: 确认变量配置正确
3. **API错误**: 检查MongoDB连接设置
4. **域名解析**: 确认DNS配置正确

### 调试步骤
1. 查看EdgeOne部署日志
2. 检查环境变量配置
3. 测试API接口连通性
4. 验证数据库连接

## 📞 技术支持

### 联系信息
- **EdgeOne文档**: https://docs.edgeone.com
- **腾讯云支持**: https://cloud.tencent.com/support
- **项目仓库**: https://github.com/TerryTang0759/leshan-furniture-batch-calculation

### 监控和日志
- **实时监控**: EdgeOne控制台监控面板
- **访问日志**: 详细的访问和错误日志
- **性能指标**: 响应时间和成功率统计

---

**🏠 乐山家具定制** - 享受EdgeOne全球加速服务！
