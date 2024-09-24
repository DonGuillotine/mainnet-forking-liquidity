# LiquidityProvider - Uniswap V3 Liquidity Management Contract

This project contains a Solidity smart contract designed to simplify the process of adding liquidity to Uniswap V3 pools using NFTs. The `LiquidityProvider` contract interacts with Uniswap V3's `INonfungiblePositionManager` to manage liquidity in a concentrated liquidity pool, abstracting the complexities and ensuring unused tokens are refunded to users.

## Overview

The `LiquidityProvider` contract allows users to provide liquidity to Uniswap V3 pools. The contract automatically handles token transfers, approvals, and liquidity minting on behalf of the user. It also ensures that any unused tokens are refunded after the liquidity position is created. The result is a unique NFT representing the liquidity position, which users can later use to manage or withdraw their liquidity.

### Features

- **Token Transfers and Approvals:** Automatically handles ERC-20 token transfers from users and grants necessary approvals to the Uniswap V3 position manager.
- **Mint Liquidity Position:** Interacts with the Uniswap V3 protocol to mint liquidity positions based on the specified pool parameters, including token amounts and tick range.
- **Refund Unused Tokens:** Ensures any tokens not utilized for liquidity are securely refunded back to the user.
- **NFT Representation:** Each liquidity position is represented by a non-fungible token (NFT) that can be used for further management.

## Contract Details

- **Solidity Version:** ^0.8.24
- **External Dependency:** Uniswap V3 Periphery
  - `INonfungiblePositionManager`: Handles liquidity management.
  - `TransferHelper`: Ensures safe ERC-20 token transfers and approvals.

### Workflow

1. **Transfer Tokens:** The contract accepts tokens `tokenA` and `tokenB` from the user, which represent the Uniswap V3 pool's trading pair.
2. **Approve Position Manager:** After transferring the tokens, the contract approves the Uniswap V3 `INonfungiblePositionManager` to use them for liquidity provisioning.
3. **Mint Liquidity:** Using the provided parameters (tokens, fee, tick range, and desired amounts), the contract mints a liquidity position on Uniswap V3 and returns an NFT representing the position.
4. **Refund Excess Tokens:** If the full token amounts are not required for liquidity, the contract refunds any unused `tokenA` and `tokenB` back to the user.

### Parameters for `addLiquidity` Function

- `tokenA`, `tokenB`: ERC-20 tokens representing the pair of assets in the liquidity pool.
- `fee`: The fee tier of the Uniswap V3 pool.
- `amountA`, `amountB`: The desired amounts of `tokenA` and `tokenB` to provide for liquidity.
- `amountAMin`, `amountBMin`: The minimum amounts of `tokenA` and `tokenB` that must be provided, ensuring slippage protection.
- `tickLower`, `tickUpper`: The price range (in ticks) for providing concentrated liquidity.
- `recipient`: The address to receive the NFT representing the liquidity position.
- `deadline`: A timestamp to ensure the transaction is completed before a specified time.

## Project Setup

This project is built using the Hardhat development environment. Follow the instructions below to install and set up the project.

### Prerequisites

- **Node.js**
- **npm** or **yarn**
- **Hardhat** (included in the project)

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/DonGuillotine/mainnet-forking-liquidity.git
   cd mainnet-forking-liquidity
   ```

2. **Install dependencies:**

   Install the required npm packages using:

   ```bash
   npm install
   ```

   or with yarn:

   ```bash
   yarn install
   ```

### Hardhat Setup

This project uses Hardhat for development, testing, and deployment. Hardhat is already configured in the project. Here are some useful commands:

- **Compile the contract:**

   ```bash
   npx hardhat compile
   ```

   This will compile the `LiquidityProvider` contract and output the artifacts in the `artifacts/` directory.

- **Run a local Hardhat network:**

   ```bash
   npx hardhat node
   ```

   This starts a local blockchain network for development and testing.

### Testing

Tests have not been implemented yet. You can create test cases under the `test/` folder using the Hardhat testing framework. Consider writing unit tests for the following key scenarios:

- Token transfers and refunds
- Liquidity position creation
- Edge cases such as slippage protection and deadlines

### Configuration

- **Solidity Compiler:** The project uses Solidity version `^0.8.24`, as defined in `hardhat.config.js`.
- **Networks:** You can configure networks (e.g., local, Rinkeby, Mainnet) in the `hardhat.config.js` file under the `networks` section.

## Dependencies

- **Uniswap V3 Periphery Contracts:** Ensure you install the necessary Uniswap V3 contracts to interact with the liquidity manager:
  ```bash
  npm install @uniswap/v3-periphery
  ```

## Roadmap

- Add test cases for `LiquidityProvider` contract.
- Deploy the contract on a public testnet (Sepolia, Goerli).
- Write scripts to manage liquidity and retrieve liquidity position details.
- Implement additional features such as withdrawing liquidity and managing positions.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---

## Contributing

If you'd like to contribute to this project, feel free to fork the repository, make your changes, and open a pull request. Contributions, issues, and feature requests are welcome!
