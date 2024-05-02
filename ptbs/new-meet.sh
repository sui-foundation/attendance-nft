#!/bin/bash

sui client ptb \
	--move-call sui::tx_context::sender \
	--assign sender \
	--assign adminCap @0xd69362d2561c5140b921d4b4095fdc83ffa030a1fe510f864d82b4f2bf17cafb \
	--assign n none \
	--move-call 0x30533ad31831e6dbcc865c27699eeac59e3f4b46df9346e7a48e2f36754ef479::meet::new_meet adminCap '"Rochester"' '"2024-04-27"' '"test description 2"' n \
	--assign meet \
	--transfer-objects [meet] sender \
	--gas-budget 20000000

