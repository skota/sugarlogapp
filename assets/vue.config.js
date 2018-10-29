const path = require('path');

module.exports = {
  lintOnSave: true,
  outputDir: path.resolve(__dirname, '../priv/static'),
  configureWebpack: {
    devtool: 'source-map'
  }
};