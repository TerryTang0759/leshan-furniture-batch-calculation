# 🚀 EdgeOne快速部署指南

## 📋 部署步骤

### 方法一：通过EdgeOne控制台部署（最简单）

#### 步骤1：准备项目
1. 确保GitHub仓库已更新：`TerryTang0759/leshan-furniture-batch-calculation`
2. 项目包含所有必要文件：
   - `api.js` - API服务器
   - `batch.html` - 前端页面
   - `package.json` - 项目配置
   - `edgeone.json` - EdgeOne配置

#### 步骤2：登录EdgeOne控制台
1. 访问：https://console.edgeone.com
2. 使用腾讯云账号登录

#### 步骤3：创建Pages项目
1. 点击 "Pages" 菜单
2. 选择 "新建项目"
3. 项目名称：`leshan-furniture-batch-calculation`
4. 选择 "从Git仓库导入"
5. 连接GitHub仓库：`TerryTang0759/leshan-furniture-batch-calculation`

#### 步骤4：配置构建设置
```
框架预设: Node.js
构建命令: npm install
输出目录: ./
根目录: ./
```

#### 步骤5：配置环境变量
在项目设置中添加：
```
MONGODB_USERNAME=terry07590759
MONGODB_PASSWORD=Na0E6iNR4p3gGNg1
MONGODB_CLUSTER=cluster0.zqsy7.mongodb.net
MONGODB_DATABASE=Leshan20250911
MONGODB_COLLECTION=price_template
NODE_ENV=production
```

#### 步骤6：部署
1. 点击 "部署" 按钮
2. 等待部署完成
3. 获得访问域名

### 方法二：使用EdgeOne CLI部署

#### 安装EdgeOne CLI
```bash
npm install -g edgeone
```

#### 登录并部署
```bash
# 登录EdgeOne
edgeone login

# 进入项目目录
cd "/Users/terry/Documents/AI/cursor/云数据库定制报价20250911/柜体投影面积计算系统"

# 部署项目
edgeone pages deploy
```

## 🌐 访问地址

部署完成后，您将获得EdgeOne域名：
```
https://leshan-furniture-batch-calculation-xxx.edgeone.app
```

### 功能测试
- **主页面**: `https://your-domain.edgeone.app/`
- **API接口**: `https://your-domain.edgeone.app/api/prices`
- **健康检查**: `https://your-domain.edgeone.app/api/health`

## 🎯 EdgeOne优势

- **全球CDN加速**: 自动分发到全球节点
- **边缘计算**: 就近处理请求
- **自动扩容**: 根据流量自动扩展
- **高可用性**: 99.9%+ SLA保证
- **DDoS防护**: 自动防护恶意攻击

## 📞 技术支持

- **EdgeOne文档**: https://docs.edgeone.com
- **腾讯云支持**: https://cloud.tencent.com/support
- **项目仓库**: https://github.com/TerryTang0759/leshan-furniture-batch-calculation

---

**🏠 乐山家具定制** - 享受EdgeOne全球加速服务！
