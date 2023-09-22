#[starknet::interface]
trait ITemperatureRecorder<TContractState> {
    // Record a new temperature.
    fn record_temperature(ref self: TContractState, temperature: u256);
    
    // Fetch the latest recorded temperature.
    fn get_latest_temperature(self: @TContractState) -> u256;
}

#[starknet::contract]
mod TemperatureRecorder {
    #[storage]
    struct Storage {
        // Variable to store the latest recorded temperature.
        latest_temperature: u256,
    }

    #[generate_trait]
    #[external(v0)]
    impl TemperatureRecorder of ITemperatureRecorder {
        fn record_temperature(ref self: ContractState, temperature: u256) {
            // Store the provided temperature.
            self.latest_temperature.write(temperature);
        }

        fn get_latest_temperature(self: @ContractState) -> u256 {
            // Return the latest recorded temperature.
            return self.latest_temperature.read();
        }
    }
}
