#!/bin/bash

sui client ptb \
	--move-call sui::tx_context::sender \
	--assign sender \
	--assign adminCap @0xdd9cfd692386653334cc7d2bfe9db2e61852cbe67a7c598971b53fdd3218670d \
	--assign n none \
	--move-call 0x41a3350004440adf89a2f837c1e4c0bf1fe4edf6e08b56383ccb5c1606f210c1::meet::new adminCap '"Remote"' '"2024-04-21"' '"2024 Sui Overflow global hackathon"' n \
	--assign meet \
	--transfer-objects [meet] sender \
	--gas-budget 20000000

