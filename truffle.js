const {readFileSync} = require('fs')
require('babel-register')
require('babel-polyfill')
var PrivateKeyProvider = require("truffle-hdwallet-provider-privkey");


module.exports = {
    solc: {
        optimizer: {
            enabled: true,
            runs: 200
        }
    },
    networks: {
        test: {
            port: 8545,
            network_id: "8995",
            host: "localhost"
        },

        poa_local: {
            host: "192.168.1.21",
            port: 8545,
            network_id: "8995",
            provider: () => {
                return new PrivateKeyProvider(["4B840E1D567A493B9B21308D2C85616C56CD664C97520B041F539EC5F35F62AA"], "http://192.168.1.21:8545")
            },
            gasPrice: 1,
        },


        poa_testnet: {
            host: "status.moonshrd.io",
            port: 8545,
            network_id: "8995",
            provider: () => {
                return new PrivateKeyProvider(["4B840E1D567A493B9B21308D2C85616C56CD664C97520B041F539EC5F35F62AA"], "http://status.moonshrd.io:8545")
            },
            gasPrice: 1,
        }


    },

    mocha: {
        useColors: true
    },
};