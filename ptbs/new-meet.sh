#!/bin/bash

sui client ptb \
	--move-call sui::tx_context::sender \
	--assign sender \
	--assign adminCap @0x39c968bf0a2da03e98bf1d094a72ad38a9dfe8bdf28198bda56e9c79bcde76a3 \
	--assign n none \
	--move-call 0x6283e20d17ea079e8d113bb2fcd878a2f5f1978b145224d591b5a35d0b3f94a4::meet::new adminCap '"Rochester"' '"2024-04-27"' '"test description 2"' n \
	--assign meet \
	--transfer-objects [meet] sender \
	--gas-budget 20000000

