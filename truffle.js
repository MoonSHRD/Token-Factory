// Allows us to use ES6 in our migrations and tests.
require('babel-register')

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1',
      port: 7545,
    //  from: "0xF649E047109E9e422E75c9C764e9885BE3e56410",
      network_id: '*' // Match any network id
    }
  }
}
