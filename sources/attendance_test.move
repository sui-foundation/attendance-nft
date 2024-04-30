
#[test_only]
module sui_attendance_nft::attendance_test {
	use sui_attendance_nft::attendance::{mint_and_transfer,Attendance};
	use sui_attendance_nft::meet::{AdminCap,Meet,new_meet};
	#[test_only] use sui::test_scenario;

	#[test]
    fun test_mint() {
		use std::debug;

		let (alice, bob, fran) = (@0x1, @0x2, @0x3);

		let mut scenario = test_scenario::begin(alice);
		{
            sui_attendance_nft::meet::init_for_testing(scenario.ctx());
            sui_attendance_nft::attendance::init_for_testing(scenario.ctx());
		};

		scenario.next_tx(alice);
		{
			let adminCap = scenario.take_from_sender<AdminCap>();
			let meet = new_meet(
				&adminCap,
				b"Rochester".to_string(),
				b"2024-04-26".to_string(),
				b"test description".to_string(),
				option::none(),
				scenario.ctx()
			);
			scenario.return_to_sender(adminCap);
			transfer::public_transfer(meet, bob);
		};

		scenario.next_tx(bob);
		{
			let mut meet = scenario.take_from_sender<Meet>();

			mint_and_transfer(
				&mut meet,
				b"Bob".to_string(),
				b"image_url".to_string(),
				1,
				bob,
				scenario.ctx(),
			);
			assert!(meet.attendances().length() == 1, 0);

			scenario.return_to_sender(meet);
		};

		scenario.next_tx(bob);
		{
			let mut meet = scenario.take_from_sender<Meet>();
			mint_and_transfer(
				&mut meet,
				b"Fran".to_string(),
				b"image_url".to_string(),
				2,
				fran,
				scenario.ctx(),
			);

			assert!(meet.attendances().length() == 2, 0);
			scenario.return_to_sender(meet);
		};

		scenario.next_tx(fran);
		{
			let a = scenario.take_from_sender<Attendance>();
			assert!(a.name() == b"Fran".to_string(), 3);
			
			scenario.return_to_sender(a);
		};

        // // make assertions on the effects of the first transaction
        // let created_ids = prev_effects.created();
        // let shared_ids = prev_effects.shared();
        // let sent_ids = prev_effects.transferred_to_account();
        // let events_num = prev_effects.num_user_events();

        // assert!(created_ids.length() == 3, 0);
        // assert!(shared_ids.length() == 1, 1);
        // assert!(sent_ids.size() == 1, 2);
        // assert!(events_num == 0, 3);

		scenario.end();
	}

	#[test]
	#[expected_failure]
    fun test_freeze_meet() {
		let (alice, bob) = (@0x1, @0x2);

		let mut scenario = test_scenario::begin(alice);
		{
            sui_attendance_nft::meet::init_for_testing(scenario.ctx());
            sui_attendance_nft::attendance::init_for_testing(scenario.ctx());
		};

		scenario.next_tx(alice);
		{
			let adminCap = scenario.take_from_sender<AdminCap>();
			let meet = new_meet(
				&adminCap,
				b"Rochester".to_string(),
				b"2024-04-26".to_string(),
				b"test description".to_string(),
				option::none(),
				scenario.ctx()
			);
			scenario.return_to_sender(adminCap);
			transfer::public_transfer(meet, alice);
		};

		scenario.next_tx(alice);
		{
			let meet = scenario.take_from_sender<Meet>();
			transfer::public_freeze_object(meet);
		};

		scenario.next_tx(alice);
		{
			// mint and transfer attendance should Fail
			let mut meet = scenario.take_from_sender<Meet>();
			mint_and_transfer(
				&mut meet,
				b"Bob".to_string(),
				b"image_url".to_string(),
				1,
				bob,
				scenario.ctx(),
			);
			scenario.return_to_sender(meet);
		};

		scenario.end();
	}
}
