#[starknet::interface]
trait INoteKeeper<TContractState> {
    // Save a note with a unique ID.
    fn save_note(ref self: TContractState, note_id: u256, note_content: String);

    // Retrieve a note using its ID.
    fn get_note(self: @TContractState, note_id: u256) -> String;
}

#[starknet::contract]
mod NoteKeeper {
    #[storage]
    struct Storage {
        // Map to store notes using unique IDs.
        notes: Map<u256, String>,
    }

    #[generate_trait]
    #[external(v0)]
    impl NoteKeeper of INoteKeeper {
        fn save_note(ref self: ContractState, note_id: u256, note_content: String) {
            // Save the note in the map.
            self.notes.write(note_id, note_content);
        }

        fn get_note(self: @ContractState, note_id: u256) -> String {
            // Retrieve the note using its ID.
            match self.notes.read(note_id) {
                Some(content) => content,
                None => "Note not found.".to_string(),
            }
        }
    }
}
