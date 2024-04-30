#!/bin/bash

sui client ptb \
	--assign display @0xdd4f0b58e2ed81520bcc92b8ff330ce394bbf363fe410fb06609306e22f89af7 \
	--move-call 0x2::display::edit "<0x101805976cb3c29adf4d16bc8dbcb2bf1f360db1858745424c46059952c56ec6::attendance::Attendance>" display  '"image_url"' '"{image_url}"' \
	--gas-budget 20000000
