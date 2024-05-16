module sui_attendance_nft::meet {
    use std::string::{String};
    use sui::event;


    public struct AdminCap has key { id: UID }
    public struct MEET has drop {}

    public struct Meet has key, store {
        id: UID,
        location: String,
        date: String,
        description: String,
        series: Option<String>,
    }
    public struct MeetCreated has copy, drop {
        id: ID,
    }

    fun init(_otw: MEET, ctx: &mut TxContext) {
        let adminCap = AdminCap{ id: object::new(ctx) };
        transfer::transfer(adminCap, ctx.sender());
    }

    public fun new(
        _: &AdminCap,
        location: String,
        date: String,
        description: String,
        series: Option<String>,
        ctx: &mut TxContext
    ): Meet {
        let meet = Meet {
            id: object::new(ctx),
            location: location,
            date: date,
            description: description,
            series: series,
        };
        event::emit(MeetCreated{ id: meet.id.to_inner() });

        meet
    }

    public fun update_location(meet: &mut Meet, location: String) {
        meet.location = location;
    }

    public fun update_date(meet: &mut Meet, date: String) {
        meet.date = date;
    }

    public fun update_description(meet: &mut Meet, description: String) {
        meet.description = description;
    }

    public fun update_series(meet: &mut Meet, series: Option<String>) {
        meet.series = series;
    }

    public fun id(self: &Meet): ID { self.id.to_inner()}

    public fun location(self: &Meet): String { self.location }

    public fun date(self: &Meet): String { self.date }

    public fun description(self: &Meet): String { self.description }

    public fun series(self: &Meet): Option<String> { self.series }

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        let otw = MEET{};
        init(otw, ctx);
    }
}
