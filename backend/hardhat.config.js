require('@nomiclabs/hardhat-waffle');
require('dotenv').config();

module.exports = {
  solidity: "0.8.0",
  networks: {
    ropsten: {
      url: `https://ropsten.infura.io/v3/YOUR_INFURA_PROJECT_ID`,
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    }
  }
};
