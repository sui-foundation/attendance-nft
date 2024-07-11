#!/bin/bash

filename="./csvs/winners-2nd-place-responded-2024-07-10.csv"
raw_addresses=$(awk -F, '{OFS=",";print $3}' $filename)

teams=()
tracks=()
while IFS="," read -r team track address
do
  if [ "$team" == "team" ]; then
    continue
  else
    teams+=("$team")
    tracks+=("$track")
  fi
done< $filename

# create a new array from raw_addresses to store addresses that have 66 characters in length
valid_addresses_array=()
for addr in $raw_addresses; do
  if [ ${#addr} -eq 66 ]; then
    valid_addresses_array+=($addr)
  fi
done
echo "total valid addresses ${#valid_addresses_array[@]}"

# split the valid_addresses_array into chunks of 200
for ((i=0; i<${#valid_addresses_array[@]}; i+=1)); do
  echo "Processing $i row from file $filename"
  address="@${valid_addresses_array[i]}"
  team="${teams[$i]}"
  track="${tracks[$i]}"
  echo ">>> address: "$address""
  echo ">>> team: "$team""
  echo ">>> track: "$track""
  package_id="0x41a3350004440adf89a2f837c1e4c0bf1fe4edf6e08b56383ccb5c1606f210c1"
  meet=@0x49b6ea50eaf249f6ded5fb1a096a6297e428ab97f1dc1f873e91ba8a9a8a6073
  image_id='"https://github.com/sui-foundation/attendance-nft/raw/main/gifs/overflow-2nd.gif"'
  name="\"2nd Place Winner at Sui Overflow 2024 - ${track}\""
  desc="\"Congratulations! This hacker from ${team} won 2nd Place at the 2024 Sui Overflow global hackathon!\""
  tier="2u8"

  t=$(date '+%Y-%m-%dT%H:%M:%S')
  teamname=$(echo $team | tr ' ' '-')

  echo $t >> ./logs/winners-2nd-place-${teamname}.log

  sui client ptb \
    --assign meet $meet \
    --assign tier $tier \
    --assign name "$name" \
    --assign desc "$desc" \
    --assign image "$image_id" \
    --assign addr "$address" \
    --move-call $package_id::attendance::mint_and_transfer meet name desc image tier addr \
    --gas-budget 500000000 >> ./logs/winners-2nd-place-${teamname}.log

  echo "Sleeping for 5 second..."
  sleep 5
done
