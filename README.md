# Intro to Cairo Smart Contract Development

## Slidedeck

https://docs.google.com/presentation/d/11atBf9fmFT1ZPeCEqFQiifylQUFhTk8dR6W6T0-NlXk

## Prerequisites

The following components are recommended to be installed for full experience of the workshop. 
NOTE: CLI commands listed below are for a Linux shell (for Windows-based systems it is recommended to use WSL for efficiency)

- Install Rust & Cargo:
  - `curl https://sh.rustup.rs -sSf | sh -s`
    or
  - `rustup update` (make sure you are at Rust 1.80.1)

- Install scarb (https://docs.swmansion.com/scarb/download.html):
  - `curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh`

- Download and build starklings
  - `git clone https://github.com/shramee/starklings-cairo1.git && cd starklings-cairo1`
  - `cargo update`
  - `cargo run -r --bin starklings`

- Install starkli *(recommended for CLI-heavy development)*
  - `curl https://get.starkli.sh | sh`
  - `starkliup`

- Install Starknet wallet *(recommended for in-browser development)*
  - https://braavos.app/
    
    or
  - https://www.argent.xyz/

## Starknet fundamentals

### STARK

- Succinct Non-Interactive Argument of Knowledge - one of fields of research of zk proofs
- Proof of 'integrity'
- For example - I computed program P over input I which resulted in O

### Logical concept of Starknet

```


                                             ┌───────────┐
                                  ┌─────────►│           │ Proof
                                  │          │   SHARP   ├────────┐
                              ┌───┴───┐      │           │        │
┌─────┐      ┌──────────┐     │ Block │      └───────────┘  ┌─────▼───────┐
│ tx1 │      │          │     │  ---  │                     │             │
│     ├─────►│ Starknet ├────►│  tx1  │                     │   Ethereum  │
│ tx2 │      │          │     │       │                     │             │
│     │      └──────────┘     │  tx2  │                     └─────────────┘
│ tx3 │                       │       │                           ▲
│     │                       │  tx3  ├───────────────────────────┘
│  .  │                       │       │
│  .  │                       │   .   │
│  .  │                       │   .   │
│     │                       │   .   │
└─────┘                       └───────┘

```
---

### Cairo

- `Cairo` is a high level language which compiles to `Sierra` (The `S`afe `I`nt`e`rmediate `R`ep`r`esent`a`tion) - prevents writing unprovable code
- `Sierra` compiles to `Cairo Assembly` (`CASM`)
- `CASM` is a provable computation language
  - i.e. execution of CASM can be proven by SHARP (and proof stored on L1).

```

     ┌─────────┐
     │         │
     │  Cairo  │
     │         │
     └────┬────┘                             ┌───────────────────────┐
          │                                  │                       │
          ▼                                  │                       │
   ┌────────────┐                            │                       │
   │            │                            │                       │
   │   Sierra   │     ──────────────────►    │   Starknet network    │
   │            │                            │                       │
   └──────┬─────┘                            │                       │
          │                                  │                       │
          ▼                                  └────────┬──────────────┘
 ┌─────────────────┐                                  │
 │                 │                                  │
 │      CASM       │                                  │
 │(Cairo Assembly) │                                  │
 │                 ├──────────────────────────────────┤
 └─────────────────┘                                  │
                                                      ▼
                                              ┌─┬─────┬───┬─┐
                                              │ ├─────────┤ │
                                              │ │         │ │
                                              │ │  SHARP  │ │
                                              │ │         │ │
                                              │ ├─────────┤ │
                                              └─┴────┼────┴─┘
```

---

### Cairo program example
```rust
use debug::PrintTrait;

fn fib(a: felt252, b: felt252, n: felt252) -> felt252 {
    if n == 0 {
        a
    } else {
        fib(b, a+b, n-1)
    }
}

fn main() {
    let x = fib(1,1,3);
    x.print();
}
```

---

### Mutability

```rust
use debug::PrintTrait;
fn main() {
    let x = 5;
    x.print();
    x = 6;  // compile error
    x.print();
}
```

```rust
use debug::PrintTrait;
fn main() {
    let mut x = 5;
    x.print();
    x = 6;  // OK
    x.print();
}
```

---

### Types

Scalar types

- Felt type : `felt252`
- Integer type : `u8`, `u16`, `u32`, `u64`, `u128`, `u256`, `usize`
- Boolean : `bool`
- 'strings' : `felt252`
- unit: `()`
---

### Casting

```rust
use traits::TryInto;
use option::OptionTrait;
fn main() {
    let x: felt252 = 3;
    let y: u32 = x.try_into().unwrap();
}
```
---

### Functions

```rust
use debug::PrintTrait;

fn another_function() {
    'Another function.'.print();
}

fn main() {
    'Hello, world!'.print();
    another_function();
}
```

---
#### Named parameters

```rust
fn foo(x: u8, y: u8) {}

fn main() {
    let first_arg = 3;
    let second_arg = 4;
    foo(x: first_arg, y: second_arg);
    let x = 1;
    let y = 2;
    foo(:x, :y)
}
```

---
#### Return values

A function 'is an expression'

```rust
use debug::PrintTrait;

fn main() {
    let x = plus_one(5);

    x.print();
}

fn plus_one(x: u32) -> u32 {
    x + 1
}
```

---
### Control flow
#### if else

```rust
use debug::PrintTrait;

fn main() {
    let number = 3;

    if number == 12 {
        'number is 12'.print();
    } else if number == 3 {
        'number is 3'.print();
    } else if number - 2 == 1 {
        'number minus 2 is 1'.print();
    } else {
        'number not found'.print();
    }
}
```


Note: 'if' is an expression!

```rust
if true { 42 } else { 0 } == 42
```

---
#### Loops

```rust
use debug::PrintTrait;
fn main() {
    let mut i: usize = 0;
    loop {
        if i > 10 {
            break;
        }
        if i == 5 {
            i += 1;
            continue;
        }
        i.print();
        i += 1;
    }
}
```

---

### Structs

```rust
struct User {
    active: bool,
    username: felt252,
    email: felt252,
    sign_in_count: u64,
}
```
---

### Arrays

```rust
use array::ArrayTrait;

fn main() {
    let mut a = ArrayTrait::new();
    a.append(0);
    a.append(1);
    a.append(2);
}
```
```rust
let first_value = a.pop_front().unwrap();
```


```rust
use array::ArrayTrait;
fn main() {
    let mut a = ArrayTrait::new();
    a.append(0);
    a.append(1);

    let first = *a.at(0);
    let second = *a.at(1);
}
```
```rust
use array::ArrayTrait;
use box::BoxTrait;
fn main() -> u128 {
    let mut arr = ArrayTrait::<u128>::new();
    arr.append(100);
    let index_to_access =
        1; // Change this value to see different results, what would happen if the index doesn't exist?
    match arr.get(index_to_access) {
        Option::Some(x) => {
            *x.unbox()
        // Don't worry about * for now, if you are curious see Chapter 3.2 #desnap operator
        // It basically means "transform what get(idx) returned into a real value"
        },
        Option::None(_) => {
            let mut data = ArrayTrait::new();
            data.append('out of bounds');
            panic(data)
        }
    }
}
```
---

### Dictionaries

```rust
use dict::Felt252DictTrait;

fn main() {
    let mut balances: Felt252Dict<u64> = Default::default();

    balances.insert('Alex', 100);

    let alex_balance = balances.get('Alex');
    assert(alex_balance == 100, 'Balance is not 100');
}
```

---

### Ownership

```
{
  let s = ...;
}
```

- `s` is always 'owned'
- When `s` comes into scope, it is valid.
- It remains valid until it goes out of scope.


If `s` is passed to a function it is moved.
However, if `s` implements `Copy` it is copied.

---

### Snapshot

A snapshot is an immutable instance of a variable.
```
let v = ...;
let snapshot_v = @v;

let modifiablevalue = *snapshot_v;
```

A function must explicitely specify the snapshot type to accept snapshots.

```
fn mod(arg: @ArgType) {
}
```

---




## Toolchain characteristics

### Scarb

- Build tool, package manager
- Includes Cairo compiler

### Starkli

- Starknet CLI utility - contract declaration & deployment

### VSCode Extension

- Syntax highlighting
- Scarb integration
- Code formatter
- Dev productivity aids

### Starknet Foundry

- Dev, build & test toolpack

### Devnet

- Emulated Starknet "instance"

### Remix (with Starknet plugin)

- Online IDE with Cairo syntax highlighting
- Online compilation
- Contract declaration, deployment & interaction
- Devnet & Wallet integration

## Learning resources

  - Cairo book (https://book.cairo-lang.org/)
  - Starklings (https://github.com/shramee/starklings-cairo1.git)
  - Starknet by Example (https://starknet-by-example.voyager.online/)
  - Cairo by Example (https://cairo-by-example.com/)
  - Exercism (https://exercism.org/tracks/cairo)
  - Node Guardians (https://nodeguardians.io/) - WIP

## Starklings

Just follow Starklings exercises.

## Let's play! (with Remix IDE)

1. Open Remix with Starknet and GitHub repo
    
    https://remix.ethereum.org/?#activate=Starknet&call=Starknet//loadFolderFromGithub//NethermindEth/cairo-workshop//

2. Select a smart contract code file
3. Go to Starknet plugin panel, run Compile 
4. Go to Environments panel at the top (one with "Remote Devnet" selected) - press to drop down and select one random account from the list
5. Go back to Starknet plugin panel, in Deploy section run Declare
6. Once declare step completes, fill in the constructor parameters and run Deploy
7. Go to Interact section, call/invoke contract methods

## Go to testnet

### Create testnet account using a wallet
1. Open a Starknet wallet (eg. Braavos)
2. Select "Add account" and create a new account record in wallet - note the new account address
3. Switch the wallet to Testnet (Sepolia) network
4. Fund the account (eg. from wallet via testnet faucet - https://starknet-faucet.vercel.app/)
5. Deploy the account to the network
6. View the account in block explorer (eg. Voyager, https://sepolia.voyager.online/contract/<contact_address>)

### Put contract on testnet

1. In Remix Starknet plugin, in the Environments panel, select Wallet 
2. Connect to preferred wallet
3. Go to plugin Deploy section, run Declare for selected Wallet account
4. Fill in contract constructor parameters if required
5. Run Deploy
6. Go to Interact section, call/invoke contract methods

## Unit testing

1. In command line, in cairo-workshop folder, run `scarb build` to build all contracts in project
2. Run `scarb test` to see unit tests run

