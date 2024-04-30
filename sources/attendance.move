module sui_attendance_nft::attendance {
	use sui::tx_context::{sender};
    use std::string::{String};
	use sui_attendance_nft::meet::{Meet};

    // The creator bundle: these two packages often go together.
    use sui::package;
    use sui::display;

	public struct ATTENDANCE has drop {}

	/// The Attendance - a proof of attendance.
    public struct Attendance has key {
        id: UID,
		name: String,
        image_id: String,
		description: String,
		tier: u32,
		meet_id: ID,
    }

    fun init(otw: ATTENDANCE, ctx: &mut TxContext) {
		let keys = vector[
            b"name".to_string(),
            b"image_url".to_string(),
            b"description".to_string(),
            b"creator".to_string(),
        ];

		let values = vector[
            b"{name}".to_string(),
            // For `link` we can build a URL using an `id` property
            b"{image_id}".to_string(),
            // Description is static for all `Hero` objects.
            b"{description}".to_string(),
            b"Sui Developer Relations Team".to_string()
        ];

		// Claim the `Publisher` for the package!
        let publisher = package::claim(otw, ctx);
		// Claim the `Publisher` for the package!

        // Get a new `Display` object for the `Hero` type.
        let mut display = display::new_with_fields<Attendance>(
            &publisher, keys, values, ctx
        );


		display::update_version(&mut display);
		transfer::public_transfer(publisher, ctx.sender());
		transfer::public_transfer(display, ctx.sender());
	}

	entry fun mint_and_transfer(
		meet: &mut Meet,
		name: String,
		image_id: String,
		tier: u32,
		to_addr: address, 
		ctx: &mut TxContext
	) {
		let attendance = Attendance {
			id: object::new(ctx),
			name: name,
			description: meet.description(),
			tier: tier,
			image_id: image_id,
			meet_id: meet.id(),
		};
		meet.attendances_mut().push_back(attendance.id.to_inner());

		transfer::transfer(attendance, to_addr);
	}

	public fun name(self: &Attendance): String { self.name }

	#[test_only]
	public fun init_for_testing(ctx: &mut TxContext) {
		let otw = ATTENDANCE{};
        init(otw, ctx);
    }
}
