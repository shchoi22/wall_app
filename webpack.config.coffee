webpack = require('webpack')
path = require('path')


config =
  context: path.resolve(__dirname, 'public', 'src'),
  entry:
    app: "./app.coffee"
    vendor: [ "jquery", "angular", "angular-resource", "angular-sanitize", 
              "angular-cookies", "angular-ui-router", "angular-ui-router.statehelper", 
              "ngStorage", "materialize-css",
    ]
  output:
    path: path.resolve(__dirname, 'public', 'dist', 'js'),
    filename: "[name].js"
    publicPath: "/js/"

  resolve:
    extensions: ['', '.coffee', '.js', '.css', '.html']
    root: [path.resolve(__dirname,'public', 'src')]
  plugins: [
    new webpack.DefinePlugin
      ENV:
        REST_API_URL: JSON.stringify(process.env.REST_API_URL or "http://localhost:8000")
    new webpack.optimize.DedupePlugin()
    new webpack.optimize.CommonsChunkPlugin "vendor", "vendor.js"
  ]
  module:
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' }
      { test: /\.css$/, loader: 'style!css' }
      { test: /\.html$/, loader: 'html?minimize=false' }
      { test: require.resolve("jquery"),  loaders: ['expose?jQuery', 'expose?$'] }
      { test: require.resolve("angular"), loader: 'expose?angular' }
    ]
  historyApiFallback: true
  devtool: "source-map"

module.exports = config 