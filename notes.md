Cairo dev workshop agenda:

SLIDE: Workshop resources
  - URL of the workshop repo
  - QR Code to the workshop repo
  - Prerequisites: Setup the download and build of tools

TOOLS: 

Install Rust & Cargo:
  - curl https://sh.rustup.rs -sSf | sh -s
   - rustup update (to 1.80.1)

Install scarb (https://docs.swmansion.com/scarb/download.html):
  - curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh

Install Starknet wallet
  - https://braavos.app/
  - https://www.argent.xyz/

Install starklings
  - DOES NOT WORK UNTIL FIXED: git clone https://github.com/shramee/starklings-cairo1.git && cd starklings-cairo1
  - THIS WORKS FOR NOW git clone https://github.com/stranger80/starklings-cairo1.git && cd starklings-cairo1
  - cargo run -r --bin starklings
    - NOTE: may need to update some deps (cargo update)

SLIDE: Purpose

SLIDE: Agenda
  - Starknet fundamentals
  - Brief Cairo language characteristic
  - Brief toolchain characteristic
  - Learning resources
  - Short encounter with Starklings
  - Setup of Testnet account in browser
  - My first contract - quick path (Remix)
  - My serious contract development - CLI tools 

SLIDE: Cairo language

SLIDE: Cairo toolchain
  - Scarb
  - Cairo VSCode extension
  - Starknet CLI
  - Devnet
  - Remix (with Starknet plugin)  

SLIDE: Cairo learning resources
  - Cairo book (https://book.cairo-lang.org/)
  - Starklings (https://github.com/shramee/starklings-cairo1.git)
  - Starknet by Example (https://starknet-by-example.voyager.online/)
  - Cairo by Example (https://cairo-by-example.com/)
  - Exercism (https://exercism.org/tracks/cairo)
  

SLIDE: How to use Starklings
  - live coding
  
SLIDE: Basics of Cairo Smart Contract

SLIDE: Hello world with Remix
  - https://remix.ethereum.org/?#activate=Starknet&call=Starknet//loadFolderFromGithub//NethermindEth/cairo-workshop//
 
  - (follow the sequence from here: https://starknet-by-example.voyager.online/getting-started/basics/introduction.html )
  - Compile (one file)
  - Compile project



SLIDE: Setup your Testnet account
  - Create a new wallet account
  - Get sepolia tokens from faucet (https://starknet-faucet.vercel.app/)
  - Deploy wallet account

SLIDE: ERC20 on Sepolia

- Launch Remix with Starknet plugin
- 

