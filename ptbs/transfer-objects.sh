#!/bin/bash

sui client ptb \
	--assign nft @0x0c27139ae573a4c4b6d902c9ef60b381c8a564c185e8ce07fe28ec123564d873 \
	--assign to_addr @0x2a1f32f6b8beca0970553a40e0b2bfcce072f28bce1d53f57c48bbf4c1aab602 \
	--transfer-objects [nft] to_addr \
	--gas-budget 20000000

