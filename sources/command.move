module sui_attendance_nft::command {
	use std::string::String;
	use sui_attendance_nft::meet::{Meet};
	use sui_attendance_nft::attendance::{new_attendance, transfer_attendance};
	fun init(_: &mut TxContext) {}

	const ELengthMismatch: u64 = 0;

	public fun mint_and_transfer(
		meet: &mut Meet,
		name: String,
		image_id: String,
		tier: u8,
		to_addr: address, 
		ctx: &mut TxContext
	) {
		let attendance = new_attendance(
			name, 
			meet.description(),
			image_id, 
			tier, 
			meet.id(),
			ctx
		);
		meet.attendances_mut().push_back(attendance.id());

		transfer_attendance(attendance, to_addr);
	}

	// mint and transfer in bulk
	public fun mint_and_transfer_bulk(
		meet: &mut Meet,
		names: vector<String>,
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
			mint_and_transfer(meet, names[i], image_ids[i], tiers[i], to_addr[i], ctx);
			i = i + 1;
		}
	}

}
