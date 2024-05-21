#!/bin/bash

 sui client ptb \
 	--assign meet @0xca95fc0cb3f676691555c2e40417d0f657cbd0e0ac6c5db92dc9a273e10e5883 \
	--assign desc "<std::string::String>" '"proof of attendance"' \
	--assign name '""' \
	--assign desc '"test desc"' \
	--assign image '"https://github.com/sui-foundation/attendance-nft/raw/zihe/add-gifs/gifs/overflow-registration.mp4"' \
	--assign images \
	--make-move-vec "<u8>" [1u8, 2u8] \
	--assign tiers \
	--make-move-vec "<address>" [@0x2655dd32a88c41d65b7ef5114785f663a045cd0d6c5a1de4c7fb3f9090843fbf, @0x2655dd32a88c41d65b7ef5114785f663a045cd0d6c5a1de4c7fb3f9090843fbf] \
	--assign addresses \
 	--move-call 0x91d97c3481bec9db0691a15726adc009e6945665472c3928177e05048f2b1515::command::mint_and_transfer_bulk meet names desc image tiers addresses \
 	--gas-budget 20000000
