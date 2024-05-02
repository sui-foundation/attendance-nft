module sui_attendance_nft::command {
	use std::string::String;
	use sui_attendance_nft::meet::{Meet};
	use sui_attendance_nft::attendance::{new_attendance, transfer_attendance};
	fun init(_: &mut TxContext) {}

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

}
