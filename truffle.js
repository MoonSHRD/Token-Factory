
const LoomTruffleProvider = require('loom-truffle-provider');
require('babel-register');
require('babel-polyfill');


const loom = new LoomTruffleProvider('default', "http://127.0.0.1:46658/rpc", "http://127.0.0.1:46658/query", "quMK1GiagMhnRtTbR4uXZYGgMRf2c2lVVtYK+00//P0I6lBi8MzZJ1Le2HdtbsZGgsynki7m7lSwdkc9/d4JNg==")
loom.createExtraAccounts(2);

module.exports = {

  networks: {
    test: {
      provider: loom,
      network_id: '*'
    },
  },

  mocha: {
    useColors: true,
    reporter: 'spec',

  },
};
