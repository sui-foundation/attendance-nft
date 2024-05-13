#!/bin/bash

sui client ptb \
 	--assign meet @0x60a1afb85348be9badaa7818ee4a084f1ed8f40b40f6ca5579df574aa6e21a01 \
	--assign tier 2u8 \
 	--move-call 0x63909bdfeab20457962e6840ed383bf0af40f9bbfcb15a502ab2e7960ceb41d7::command::mint_and_transfer meet '"test nft"' '"proof of attendance"' '"https://blog.sui.io/content/images/size/w1200/2024/03/03-22-Blog-Header--1800x700-.png"' tier @0x2655dd32a88c41d65b7ef5114785f663a045cd0d6c5a1de4c7fb3f9090843fbf \
 	--gas-budget 20000000
