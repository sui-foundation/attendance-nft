module sui_attendance_nft::attendance {
    use sui_attendance_nft::meet::{Meet};
    use sui::tx_context::{sender};
    use std::string::{String};
    use sui::transfer::Receiving;
    use sui::event;

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
        tier: u8,
        meet_id: ID,
    }

    public struct AttendanceCreated has copy, drop {
        id: ID,
        meet_id: ID,
        tier: u8,
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

    public(package) fun new(
        name: String,
        description: String,
        image_id: String,
        tier: u8,
        meet_id: ID,
        ctx: &mut TxContext
    ): Attendance {
        let attendance = Attendance {
            id: object::new(ctx),
            name: name,
            description: description,
            image_id: image_id,
            tier: tier,
            meet_id: meet_id,
        };
        event::emit(AttendanceCreated {
            meet_id: meet_id,
            id: attendance.id.to_inner(),
            tier: tier,
        });

        attendance
    }

    public fun mint_and_transfer(
        meet: &mut Meet,
        name: String,
        description: String,
        image_id: String,
        tier: u8,
        to: address,
        ctx: &mut TxContext
    ) {
        let meet_id = meet.id();
        let attendance = new(name, description, image_id, tier, meet_id, ctx);
        transfer::transfer(attendance, to);
    }

    public fun id(self: &Attendance): ID { self.id.to_inner()}

    public fun name(self: &Attendance): String { self.name }

    public fun tier(self: &Attendance): u8 { self.tier }

    public fun receive<T: key + store>(a: &mut Attendance, sent: Receiving<T>): T {
        transfer::public_receive(&mut a.id, sent)
    }

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        let otw = ATTENDANCE{};
        init(otw, ctx);
    }
}
