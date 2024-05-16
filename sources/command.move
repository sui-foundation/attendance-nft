module sui_attendance_nft::command {
    use std::string::String;
    use sui_attendance_nft::meet::{Meet};
    use sui_attendance_nft::attendance::{mint_and_transfer};

    const ELengthMismatch: u64 = 0;

    // mint and transfer in bulk
    public fun mint_and_transfer_bulk(
        meet: &mut Meet,
        names: vector<String>,
        description: String,
        image_ids: vector<String>,
        tiers: vector<u8>,
        to_addr: vector<address>,
        ctx: &mut TxContext
    ) {
        assert!(names.length() == image_ids.length() && 
            image_ids.length() == tiers.length() && 
            tiers.length() == to_addr.length(), ELengthMismatch);
        let bulk_length = names.length();
        let mut i = 0;
        while (i < bulk_length) {
            mint_and_transfer(meet, names[i], description, image_ids[i], tiers[i], to_addr[i], ctx);
            i = i + 1;
        }
    }

}
