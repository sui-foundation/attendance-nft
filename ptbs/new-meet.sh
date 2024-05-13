#!/bin/bash

sui client ptb \
	--move-call sui::tx_context::sender \
	--assign sender \
	--assign adminCap @0xfc1c01bf941a8877a336ebbba704f061bb1d349a4d446a661bfe681ce8052c7a \
	--assign n none \
	--move-call 0x63909bdfeab20457962e6840ed383bf0af40f9bbfcb15a502ab2e7960ceb41d7::meet::new adminCap '"Rochester"' '"2024-04-27"' '"test description 2"' n \
	--assign meet \
	--transfer-objects [meet] sender \
	--gas-budget 20000000

