#!/bin/bash

sui client ptb \
	--move-call sui::tx_context::sender \
	--assign sender \
	--assign adminCap @0x90e7ff265c8bd06cbbbfb221f0479a54b1d4b440a8bbc88fd3dc159f719c64b3 \
  --move-call 0x1::option::none "<0x1::string::String>" \
	--assign n \
	--move-call 0x3b3aed1d6d2c9b602a499a95c09ead18bf6d4de316f67aff8db1a0b9f16c46e8::meet::new adminCap '"Remote"' '"2024-04-21"' '"2024 Sui Overflow global hackathon"' n \
	--assign meet \
	--transfer-objects [meet] sender \
	--gas-budget 20000000
