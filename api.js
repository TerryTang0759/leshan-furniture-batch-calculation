// 批量计算系统API接口
// 用于支持批量投影面积计算系统的数据获取

const express = require('express');
const { MongoClient } = require('mongodb');
const cors = require('cors');
const path = require('path');
const XLSX = require('xlsx');

const app = express();
const PORT = process.env.PORT || 3001;

// 中间件
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname)));

// MongoDB连接配置
const mongoConfig = {
    username: process.env.MONGODB_USERNAME || 'terry07590759',
    password: process.env.MONGODB_PASSWORD || 'Na0E6iNR4p3gGNg1',
    cluster: process.env.MONGODB_CLUSTER || 'cluster0.zqsy7.mongodb.net',
    defaultDbName: process.env.MONGODB_DATABASE || 'Leshan20250911',
    priceCollectionName: process.env.MONGODB_COLLECTION || 'price_template'
};

const uri = `mongodb+srv://${mongoConfig.username}:${mongoConfig.password}@${mongoConfig.cluster}/`;

// 首页路由 - 提供批量计算系统
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '批量计算系统.html'));
});

// 测试页面路由
app.get('/test', (req, res) => {
    res.sendFile(path.join(__dirname, '测试页面.html'));
});

// API路由 - 获取柜体材质数据
app.get('/api/prices', async (req, res) => {
    const client = new MongoClient(uri);
    
    try {
        await client.connect();
        const db = client.db(mongoConfig.defaultDbName);
        const collection = db.collection(mongoConfig.priceCollectionName);
        
        const category = req.query.category;
        let query = {};
        
        // 支持多种分类筛选
        if (category) {
            if (category === '柜体板材' || category === 'cabinet') {
                query = { category: { $in: ['柜体板材', 'cabinet'] } };
            } else {
                query = { category: category };
            }
        }
        
        const prices = await collection.find(query).sort({ category: 1, price: 1 }).toArray();
        
        res.json({
            success: true,
            data: prices,
            count: prices.length,
            timestamp: new Date().toISOString()
        });
        
    } catch (error) {
        console.error('获取价格数据失败:', error);
        res.status(500).json({
            success: false,
            error: '获取价格数据失败',
            message: error.message
        });
    } finally {
        await client.close();
    }
});

// API路由 - 批量计算投影面积单价
app.post('/api/batch-calculate', async (req, res) => {
    const client = new MongoClient(uri);
    
    try {
        const { height, width, depth } = req.body;
        
        // 验证输入参数
        if (!height || !width || !depth || height <= 0 || width <= 0 || depth <= 0) {
            return res.status(400).json({
                success: false,
                error: '参数无效',
                message: '高度、宽度、深度必须大于0'
            });
        }

        await client.connect();
        const db = client.db(mongoConfig.defaultDbName);
        const collection = db.collection(mongoConfig.priceCollectionName);
        
        // 获取柜体材质数据
        const materials = await collection.find({ 
            category: { $in: ['柜体板材', 'cabinet'] } 
        }).sort({ price: 1 }).toArray();
        
        if (materials.length === 0) {
            return res.status(404).json({
                success: false,
                error: '未找到材质数据',
                message: '数据库中暂无柜体板材数据'
            });
        }

        // 计算柜体拆板面积
        const cabinetInfo = calculateCabinetArea(height, width, depth);
        const projectionArea = (width * height) / 1000000; // mm² 转换为 m²

        // 批量计算所有材质
        const results = materials.map(material => {
            const totalPrice = cabinetInfo.area * material.price;
            const projectionUnitPrice = totalPrice / projectionArea;

            return {
                name: material.name,
                brand: material.brand || '乐山家具',
                materialPrice: material.price,
                totalPrice: totalPrice,
                projectionArea: projectionArea,
                projectionUnitPrice: projectionUnitPrice,
                roundedPrice: Math.round(projectionUnitPrice)
            };
        });

        // 按投影面积单价排序
        results.sort((a, b) => a.projectionUnitPrice - b.projectionUnitPrice);

        // 计算统计信息
        const stats = {
            totalMaterials: results.length,
            avgPrice: results.reduce((sum, r) => sum + r.projectionUnitPrice, 0) / results.length,
            minPrice: Math.min(...results.map(r => r.projectionUnitPrice)),
            maxPrice: Math.max(...results.map(r => r.projectionUnitPrice)),
            cabinetInfo: cabinetInfo,
            calculationSteps: {
                input: {
                    height: height,
                    width: width,
                    depth: depth
                },
                shelfCalculation: {
                    horizontalShelves: cabinetInfo.horizontalShelves,
                    verticalShelves: cabinetInfo.verticalShelves,
                    formula: {
                        horizontal: `⌊${height}÷400⌋ + 1 = ${cabinetInfo.horizontalShelves}`,
                        vertical: `⌊${width}÷1000⌋ + 1 = ${cabinetInfo.verticalShelves}`
                    }
                },
                areaCalculation: {
                    topBottom: `${2} × (${width/1000}m × ${depth/1000}m) = ${cabinetInfo.topBottom.toFixed(4)}㎡`,
                    leftRight: `${2} × (${depth/1000}m × ${height/1000}m) = ${cabinetInfo.leftRight.toFixed(4)}㎡`,
                    back: `${width/1000}m × ${height/1000}m = ${cabinetInfo.back.toFixed(4)}㎡`,
                    horizontalShelves: `${cabinetInfo.horizontalShelves} × (${width/1000}m × ${depth/1000}m) = ${cabinetInfo.horizontalShelvesArea.toFixed(4)}㎡`,
                    verticalShelves: `${cabinetInfo.verticalShelves} × (${depth/1000}m × ${height/1000}m) = ${cabinetInfo.verticalShelvesArea.toFixed(4)}㎡`,
                    totalArea: `${cabinetInfo.area.toFixed(4)}㎡`
                },
                projectionCalculation: {
                    projectionArea: `${projectionArea.toFixed(4)}㎡`,
                    formula: `投影面积 = ${width/1000}m × ${height/1000}m = ${projectionArea.toFixed(4)}㎡`
                }
            }
        };

        res.json({
            success: true,
            data: results,
            stats: stats,
            timestamp: new Date().toISOString()
        });
        
    } catch (error) {
        console.error('批量计算失败:', error);
        res.status(500).json({
            success: false,
            error: '批量计算失败',
            message: error.message
        });
    } finally {
        await client.close();
    }
});

// 计算柜体拆板面积函数
function calculateCabinetArea(height, width, depth) {
    // 转换为米
    const h = height / 1000;
    const w = width / 1000;
    const d = depth / 1000;
    
    // 自动计算隔板数量
    const horizontalShelves = Math.floor(height / 400) + 1;
    const verticalShelves = Math.floor(width / 1000) + 1;
    
    // 柜体面积计算
    const topBottom = 2 * (w * d);                    // 顶板+底板
    const leftRight = 2 * (d * h);                    // 左右侧板
    const back = w * h;                               // 背板
    const horizontalShelvesArea = horizontalShelves * (w * d); // 横隔板
    const verticalShelvesArea = verticalShelves * (d * h);     // 竖隔板
    
    return {
        area: topBottom + leftRight + back + horizontalShelvesArea + verticalShelvesArea,
        horizontalShelves: horizontalShelves,
        verticalShelves: verticalShelves,
        topBottom: topBottom,
        leftRight: leftRight,
        back: back,
        horizontalShelvesArea: horizontalShelvesArea,
        verticalShelvesArea: verticalShelvesArea
    };
}

// 系统状态检查
// API路由 - 导出Excel文件
app.post('/api/export-excel', async (req, res) => {
    try {
        const { calculationData, inputData } = req.body;
        
        if (!calculationData || !inputData) {
            return res.status(400).json({
                success: false,
                error: '参数缺失',
                message: '缺少计算数据或输入数据'
            });
        }

        // 创建工作簿
        const workbook = XLSX.utils.book_new();
        
        // 创建数据工作表
        const worksheetData = [
            ['乐山家具定制 - 批量投影面积计算报告'],
            [''],
            ['计算参数'],
            ['高度 (mm)', inputData.height],
            ['宽度 (mm)', inputData.width],
            ['深度 (mm)', inputData.depth],
            ['投影面积 (m²)', inputData.projectionArea],
            [''],
            ['计算结果'],
            ['序号', '材质名称', '单价 (元/m²)', '投影面积单价 (元/m²)', '拆板总价 (元)']
        ];

        // 添加计算结果数据
        calculationData.forEach((item, index) => {
            worksheetData.push([
                index + 1,
                item.materialName,
                item.price,
                item.projectionUnitPrice.toFixed(2),
                item.totalPrice.toFixed(2)
            ]);
        });

        // 添加统计信息
        worksheetData.push(['']);
        worksheetData.push(['统计信息']);
        worksheetData.push(['最高单价', calculationData[calculationData.length - 1]?.projectionUnitPrice.toFixed(2) || '0']);
        worksheetData.push(['最低单价', calculationData[0]?.projectionUnitPrice.toFixed(2) || '0']);
        worksheetData.push(['平均单价', (calculationData.reduce((sum, item) => sum + item.projectionUnitPrice, 0) / calculationData.length).toFixed(2)]);
        worksheetData.push(['材质总数', calculationData.length]);

        // 创建工作表
        const worksheet = XLSX.utils.aoa_to_sheet(worksheetData);
        
        // 设置列宽
        worksheet['!cols'] = [
            { wch: 15 }, // 序号
            { wch: 25 }, // 材质名称
            { wch: 15 }, // 单价
            { wch: 20 }, // 投影面积单价
            { wch: 15 }  // 拆板总价
        ];

        // 添加工作表到工作簿
        XLSX.utils.book_append_sheet(workbook, worksheet, '投影面积计算结果');

        // 生成Excel文件
        const excelBuffer = XLSX.write(workbook, { type: 'buffer', bookType: 'xlsx' });

        // 设置响应头
        const filename = `乐山家具定制_投影面积计算结果_${new Date().toISOString().slice(0, 10)}.xlsx`;
        res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        res.setHeader('Content-Disposition', `attachment; filename="${encodeURIComponent(filename)}"`);
        res.setHeader('Content-Length', excelBuffer.length);

        // 发送文件
        res.send(excelBuffer);

    } catch (error) {
        console.error('导出Excel失败:', error);
        res.status(500).json({
            success: false,
            error: '导出Excel失败',
            message: error.message
        });
    }
});

app.get('/api/health', async (req, res) => {
    const client = new MongoClient(uri);
    
    try {
        await client.connect();
        const db = client.db(mongoConfig.defaultDbName);
        const collection = db.collection(mongoConfig.priceCollectionName);
        
        const count = await collection.countDocuments();
        
        res.json({
            success: true,
            status: 'healthy',
            mongodb: {
                connected: true,
                database: mongoConfig.defaultDbName,
                collection: mongoConfig.priceCollectionName,
                documentCount: count
            },
            timestamp: new Date().toISOString()
        });
        
    } catch (error) {
        res.json({
            success: false,
            status: 'unhealthy',
            mongodb: {
                connected: false,
                error: error.message
            },
            timestamp: new Date().toISOString()
        });
    } finally {
        await client.close();
    }
});

// 启动服务器
app.listen(PORT, () => {
    console.log('🏠 乐山家具定制 - 批量计算系统API');
    console.log('================================');
    console.log(`🚀 服务器已启动: http://0.0.0.0:${PORT}`);
    console.log(`📊 批量计算系统: http://0.0.0.0:${PORT}/`);
    console.log(`🔌 API接口: http://0.0.0.0:${PORT}/api/prices`);
    console.log(`💊 健康检查: http://0.0.0.0:${PORT}/api/health`);
    console.log('================================');
});

module.exports = app;
