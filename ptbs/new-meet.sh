#!/bin/bash

sui client ptb \
	--move-call sui::tx_context::sender \
	--assign sender \
	--assign adminCap @0xc26c3da4ca78a5b99caa4eb87fe3cc26a41a793181248444183b3cd2184b5df9 \
	--assign n none \
	--move-call 0x6f6b2d4bd1af9e99645eb13af785789a437d9b825157f9817ff63ec85b52ff43::meet::new_meet adminCap '"Rochester"' '"2024-04-27"' '"test description 2"' n \
	--assign meet \
	--transfer-objects [meet] sender \
	--gas-budget 20000000

