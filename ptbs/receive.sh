#!/bin/bash

sui client ptb \
	--assign att @0xebcd88946e2d172904b2fffc67658ee44237f53e3ab0fe6d38308150978d98d2 \
	--assign c @0x881588153f897b89a5d11530f5f6a6240a841e4ed35c1ce1350145a639b6b541 \
	--move-call sui::tx_context::sender \
	--assign sender \
	--move-call 0x63909bdfeab20457962e6840ed383bf0af40f9bbfcb15a502ab2e7960ceb41d7::attendance::receive "<0x2::sui::SUI>" att c \
	--assign r \
	--transfer-objects [r] sender \
	--gas-budget 20000000

