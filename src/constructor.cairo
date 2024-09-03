#[starknet::contract]
pub mod ExampleConstructor {
    use starknet::ContractAddress;
    use starknet::storage::Map;

    #[storage]
    struct Storage {
        names: Map::<ContractAddress, felt252>,
    }

    // The constructor is decorated with a `#[constructor]` attribute.
    // It is not inside an `impl` block.
    #[constructor]
    fn constructor(ref self: ContractState, name: felt252, address: ContractAddress) {
        self.names.write(address, name);
    }
}
