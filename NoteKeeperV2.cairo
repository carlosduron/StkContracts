#[starknet::interface]
trait INoteKeeper<TContractState> {
    // Define a fixed size for our notes, for example, 32 bytes.
    const NOTE_SIZE: usize = 32;

    // Save a note with a unique ID.
    fn save_note(ref self: TContractState, note_id: u256, note_content: felt[NOTE_SIZE]);

    // Retrieve a note using its ID.
    fn get_note(self: @TContractState, note_id: u256) -> felt[NOTE_SIZE];
}

#[starknet::contract]
mod NoteKeeper {
    #[storage]
    struct Storage {
        // Map to store notes using unique IDs.
        notes: Map<u256, felt[INoteKeeper::NOTE_SIZE]>,
    }

    #[generate_trait]
    #[external(v0)]
    impl NoteKeeper of INoteKeeper {
        fn save_note(ref self: ContractState, note_id: u256, note_content: felt[INoteKeeper::NOTE_SIZE]) {
            // Save the note in the map.
            self.notes.write(note_id, note_content);
        }

        fn get_note(self: @ContractState, note_id: u256) -> felt[INoteKeeper::NOTE_SIZE] {
            // Retrieve the note using its ID.
            match self.notes.read(note_id) {
                Some(content) => content,
                None => [0; INoteKeeper::NOTE_SIZE], // Return an empty array if the note is not found.
            }
        }
    }
}
