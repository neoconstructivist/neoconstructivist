const webpack = require('webpack');
const path = require('path');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const bourbon = require('bourbon').includePaths;
const neat = require('bourbon-neat').includePaths;

module.exports = {
  context: path.resolve(__dirname, 'source', 'assets'),
  entry: './javascripts/app.js',
  output: {
    path: path.resolve(__dirname, '.tmp', 'dist'),
    filename: './javascripts/app.bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env']
          }
        }
      },
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          {
            loader: 'sass-loader',
            options: {
              includePaths: [
                bourbon,
                neat
              ]
            }
          }
        ]
      }
    ]
  },
  plugins: [
    new webpack.EnvironmentPlugin(['NODE_ENV']),
    new CleanWebpackPlugin(['.tmp']),
    new MiniCssExtractPlugin({ filename: './stylesheets/main.css' })
  ]
}
