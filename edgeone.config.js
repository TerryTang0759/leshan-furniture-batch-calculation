// EdgeOne Pages 配置文件
module.exports = {
  // 项目名称
  name: 'leshan-furniture-batch-calculation',
  
  // 构建配置
  build: {
    // 构建命令
    command: 'npm install',
    // 输出目录
    output: './',
    // 根目录
    root: './'
  },
  
  // 路由配置
  routes: [
    {
      // API路由
      src: '/api/(.*)',
      dest: '/api.js'
    },
    {
      // 静态文件路由
      src: '/(.*)',
      dest: '/batch.html'
    }
  ],
  
  // 环境变量
  env: {
    NODE_ENV: 'production'
  },
  
  // 服务器配置
  server: {
    port: 3001,
    host: '0.0.0.0'
  }
};
