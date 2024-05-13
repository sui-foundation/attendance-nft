#!/bin/bash

 sui client ptb \
 	--assign meet @0xca95fc0cb3f676691555c2e40417d0f657cbd0e0ac6c5db92dc9a273e10e5883 \
	--make-move-vec "<std::string::String>" ['"test nft"', '"test nft 2"'] \
	--assign names \
	--assign desc '"test desc"' \
	--make-move-vec "<std::string::String>" ['"https://blog.sui.io/content/images/size/w1200/2024/03/03-22-Blog-Header--1800x700-.png"', '"https://blog.sui.io/content/images/size/w1200/2024/03/03-22-Blog-Header--1800x700-.png"'] \
	--assign images \
	--make-move-vec "<u8>" [1u8, 2u8] \
	--assign tiers \
	--make-move-vec "<address>" [@0x2655dd32a88c41d65b7ef5114785f663a045cd0d6c5a1de4c7fb3f9090843fbf, @0x2655dd32a88c41d65b7ef5114785f663a045cd0d6c5a1de4c7fb3f9090843fbf] \
	--assign addresses \
 	--move-call 0x91d97c3481bec9db0691a15726adc009e6945665472c3928177e05048f2b1515::command::mint_and_transfer_bulk meet names desc images tiers addresses \
 	--gas-budget 20000000
