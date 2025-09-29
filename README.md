# 🏠 乐山家具定制 - 批量投影面积计算系统

## 📋 项目简介

这是一个专为乐山家具定制设计的批量投影面积计算系统，能够根据柜体的高、宽、深三个尺寸，自动计算所有材质的投影面积单价。

### ✨ 核心功能
- **统一尺寸输入**: 只需输入高、宽、深三个数据
- **批量计算**: 自动计算33种材质的投影面积单价
- **MongoDB集成**: 从数据库获取最新材质价格
- **详细计算逻辑**: 透明展示每个计算步骤
- **Excel导出**: 一键下载计算结果为Excel文件
- **响应式设计**: 支持各种设备访问

## 🚀 快速开始

### 本地开发
```bash
# 安装依赖
npm install

# 启动服务
node api.js

# 访问系统
open http://localhost:3001
```

### 一键启动
```bash
# 运行启动脚本
./启动批量计算系统.sh
```

## 🌐 云端部署

### Vercel部署（推荐）
1. 访问 https://vercel.com
2. 导入GitHub仓库：`TerryTang0759/leshan-furniture-batch-calculation`
3. 配置环境变量（见下方配置）
4. 一键部署

### 环境变量配置
| 变量名 | 值 |
|--------|-----|
| `MONGODB_USERNAME` | `terry07590759` |
| `MONGODB_PASSWORD` | `Na0E6iNR4p3gGNg1` |
| `MONGODB_CLUSTER` | `cluster0.zqsy7.mongodb.net` |
| `MONGODB_DATABASE` | `Leshan20250911` |
| `MONGODB_COLLECTION` | `price_template` |
| `NODE_ENV` | `production` |

## 📊 系统架构

### 前端
- **HTML5 + CSS3 + JavaScript**: 现代化响应式界面
- **批量计算页面**: `batch.html` - 主系统界面
- **实时计算**: 无需刷新页面即可查看结果

### 后端
- **Node.js + Express**: 轻量级API服务
- **MongoDB Atlas**: 云端数据库存储材质价格
- **RESTful API**: 标准化接口设计

## 🔧 计算逻辑

### 输入参数
- **高度 (mm)**: 柜体高度
- **宽度 (mm)**: 柜体宽度  
- **深度 (mm)**: 柜体深度

### 自动计算
1. **水平层板数量**: `Math.floor(高度 / 400) + 1`
2. **垂直层板数量**: `Math.floor(宽度 / 1000) + 1`
3. **柜体拆板面积**: 基于主系统逻辑计算
4. **投影面积**: `(宽度 × 高度) / 1,000,000` (转换为平方米)
5. **投影单价**: `拆板总价 ÷ 投影面积`

### 输出结果
- 33种材质的投影面积单价排序
- 详细的计算步骤说明
- 统计数据汇总
- Excel文件导出功能

## 📁 项目结构

```
leshan-furniture-batch-calculation/
├── api.js                      # API服务器
├── batch.html                  # 批量计算系统主页面
├── package.json                # 项目配置
├── vercel.json                 # Vercel部署配置
├── 启动批量计算系统.sh         # 启动脚本
├── README.md                   # 项目说明
├── 使用说明.md                 # 详细使用指南
├── 计算逻辑说明.md             # 计算逻辑详细说明
└── 部署相关文档...
```

## 🌐 API接口

### 获取材质价格
```
GET /api/prices
```

### 批量计算
```
POST /api/batch-calculate
```

### Excel导出
```
POST /api/export-excel
```

### 健康检查
```
GET /api/health
```

## 🎯 使用场景

### 适用对象
- **家具设计师**: 快速计算不同材质的投影面积单价
- **销售人员**: 为客户提供准确的报价参考
- **项目经理**: 批量评估项目成本

### 典型应用
- 定制柜体报价
- 材质成本对比
- 批量项目评估
- 客户询价响应

## 🔒 安全特性

- **HTTPS加密**: 自动SSL证书
- **环境变量**: 敏感信息安全存储
- **CORS配置**: 跨域访问控制
- **错误处理**: 完善的异常处理机制

## 📞 技术支持

### 联系方式
- **项目**: 乐山家具定制批量投影面积计算系统
- **品牌**: 乐山家具定制
- **仓库**: https://github.com/TerryTang0759/leshan-furniture-batch-calculation

### 常见问题
1. **无法连接数据库**: 检查环境变量配置
2. **计算结果异常**: 验证输入数据格式
3. **页面无法加载**: 检查网络连接状态

---

**🏠 乐山家具定制** - 让投影面积计算变得简单高效！