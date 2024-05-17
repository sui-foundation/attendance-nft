module sui_attendance_nft::command {
    use std::string::String;
    use sui_attendance_nft::meet::{Meet};
    use sui_attendance_nft::attendance::{mint_and_transfer};

    // mint and transfer in bulk
    public fun mint_and_transfer_bulk(
        meet: &mut Meet,
        name: String,
        description: String,
        image_ids: String,
        tiers: u8,
        to_addr: vector<address>,
        ctx: &mut TxContext
    ) {
        let bulk_length = to_addr.length();
        let mut i = 0;
        while (i < bulk_length) {
            mint_and_transfer(meet, name, description, image_ids, tiers, to_addr[i], ctx);
            i = i + 1;
        }
    }

}
