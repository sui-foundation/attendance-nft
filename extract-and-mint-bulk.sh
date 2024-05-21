#!/bin/bash

raw_addresses=$(awk -F, '{OFS=",";print $2}' ./test.csv)

# create a new array from raw_addresses to store addresses that have 66 characters in length
valid_addresses_array=()
for addr in $raw_addresses; do
  if [ ${#addr} -eq 66 ]; then
    valid_addresses_array+=($addr)
  fi
done
echo "total valid addresses ${#valid_addresses_array[@]}"

sui_ns=()
for addr in $raw_addresses; do
  # if the address has ".sui" suffix, add it to the sui_ns array
  if [[ $addr == *".sui" ]]; then
      sui_ns+=($addr)
  fi
done
echo "omitting ${#sui_ns[@]} addresses with .sui suffix"

# split the valid_addresses_array into chunks of 200
for ((i=0; i<${#valid_addresses_array[@]}; i+=200)); do
  echo "Processing chunk $i" >> response.log
  chunk=("${valid_addresses_array[@]:i:200}")
  addresses_trailing_comma=$(printf '@%s,' ${chunk[*]})
  addresses=[${addresses_trailing_comma%,}]
  package_id="0x6283e20d17ea079e8d113bb2fcd878a2f5f1978b145224d591b5a35d0b3f94a4"
  meet=@0x6402fda6360b5ac3d93a26031b045f2dd1b58eef54e409665dc0392b1f33d180
  image_id='"https://github.com/sui-foundation/attendance-nft/raw/zihe/add-gifs/gifs/overflow-registration.gif"'
  name='"test nft"'
  desc='"registered"'
  tier="4u8"

  t=$(date '+%Y-%m-%dT%H:%M:%S')

  sui client ptb \
    --assign meet $meet \
    --assign tier $tier \
    --assign name "$name" \
    --assign desc "$desc" \
    --assign image "$image_id" \
    --make-move-vec "<address>" $addresses \
    --assign addrs \
    --move-call $package_id::command::mint_and_transfer_bulk meet name desc image tier addrs \
    --gas-budget 3000000000 >> ./logs/response-${t}.log

  echo ${#chunk[@]}
done

# echo ${valid_addresses_array[*]}
# echo ${sui_ns[*]}
