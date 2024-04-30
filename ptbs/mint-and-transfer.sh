#!/bin/bash

 sui client ptb \
 	--assign meet @0xac784dbce6349749d7ba2cf0349546ae634cef7bd7a2b7b80d69c7eafb064c1a \
	--assign tier 1u32 \
 	--move-call 0x6f6b2d4bd1af9e99645eb13af785789a437d9b825157f9817ff63ec85b52ff43::attendance::mint_and_transfer meet '"test nft"' '"https://blog.sui.io/content/images/size/w1200/2024/03/03-22-Blog-Header--1800x700-.png"' tier @0x5a23eb92d6742e81f113df2edee568db8d1b22923c76e4d04203e6e80b1172d4 \
 	--gas-budget 20000000
