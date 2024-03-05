require("@nomiclabs/hardhat-waffle");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.1",
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      forking: {
        url: "https://eth-mainnet.g.alchemy.com/v2/Pm9ZgeSGJWEXWRTYWkuJAMjcR-8ME1ma",
        blockNumber: 11129473
      }
    }
  },
  mocha: {
    timeout: 100000000
  }
};