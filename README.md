# Attendance NFT
Attendance NFT is designed to be a decentralized application that allows for the creation of non-fungible tokens (NFTs) that represent attendance in a class or event.

The Admin of the NFT Package will issue `Meet` objects to selected event organizers or instructors. The event organizers or instructors will then issue `Attendance` objects to the students or attendees. The `Attendance` objects are stored on the Sui blockchain and can be used to prove attendance in a class or event. The `Attendance` objects are soul-bound and cannot be transferred once issued.

The NFTs are soul-bound and cannot be transferred once issued.

## Repository Structure
- `sources/` contains the source code for the Sui Move Package
- `tests/` contains the tests for the Sui Move Package
- `ptbs/` contains the PTBs to interact with the Sui package via the Sui PTB CLI

## TODO
- [ ] Export Airtable data
- [ ] Parse exported Airtable data to generate list of Sui addresses for airdrop
- [ ] Deploy Sui PTBs to Sui blockchain
- [ ] Submit Sui PTBs for airdrop in batches

## Design Doc
See [Design Doc](https://docs.google.com/document/d/1dFfMFkAWpG5DQsB4HJoaEC-iEZ91DthnB5oEJCLKyGA/edit)
