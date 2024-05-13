#!/bin/bash

sui client ptb \
	--assign meet @0xca95fc0cb3f676691555c2e40417d0f657cbd0e0ac6c5db92dc9a273e10e5883 \
	--assign location none \
	--assign t none \
	--assign s none \
	--move-call std::option::some "<std::string::String>" '"updated description 1"' \
	--assign d \
	--move-call 0x91d97c3481bec9db0691a15726adc009e6945665472c3928177e05048f2b1515::meet::update meet location t d s \
	--gas-budget 20000000
