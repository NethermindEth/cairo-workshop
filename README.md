# Intro to Cairo Smart Contract Development

## Prerequisites

- Install Rust & Cargo:
  - `curl https://sh.rustup.rs -sSf | sh -s`
    or
  - `rustup update` (make sure you are at Rust 1.80.1)

- Install scarb (https://docs.swmansion.com/scarb/download.html):
  - `curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh`

- Install starklings
  - THIS TEMP FORK WORKS FOR NOW: `git clone https://github.com/stranger80/starklings-cairo1.git && cd starklings-cairo1`
    - NOTE: ORIGINAL REPO DOES NOT WORK UNTIL FIXED BY AUTHOR: `git clone https://github.com/shramee/starklings-cairo1.git && cd starklings-cairo1`
  - `cargo update`
  - `cargo run -r --bin starklings`

- Install Starknet wallet *(recommended for in-browser development)*
  - https://braavos.app/
    
    or
  - https://www.argent.xyz/

