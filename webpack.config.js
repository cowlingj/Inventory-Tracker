const path = require('path');
const FileManagerPlugin = require('filemanager-webpack-plugin');

module.exports = {
  entry: {
    "get-list": './src/get-list.js',
    "stub": './src/stub.js'
  },
  output: {
    libraryTarget: 'commonjs',
    path: path.resolve(__dirname, 'dist'),
    filename: '[name].js'
  },
  target: 'node',
  module: {
    rules: [{
      test: /\.js$/,
      exclude: /node_modules/,
      use: {
        loader: 'babel-loader',
      }
    }]
  },
  plugins: [
    new FileManagerPlugin({
      onStart: {
          delete: [
            'dist/*',
            'deploy/build/*'
          ]
      },
      onEnd: 
        {
          archive: [
            {
              source: 'dist/get-list.js',
              destination: 'deploy/build/get-list.zip'
            },
            {
              source: 'dist/stub.js',
              destination: 'deploy/build/stub.zip'
            }
          ]
        }
    }),
  ],
};