install-bun:
	curl -fsSL https://bun.sh/install | bash

install-noir:
	curl -L https://raw.githubusercontent.com/noir-lang/noirup/refs/heads/main/install | bash
	noirup --version 1.0.0-beta.3

install-barretenberg:
	curl -L https://raw.githubusercontent.com/AztecProtocol/aztec-packages/refs/heads/master/barretenberg/bbup/install | bash
	bbup --version 0.85.0

install-starknet:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.starkup.dev | sh

install-devnet:
	asdf plugin add starknet-devnet
	asdf install starknet-devnet 0.3.0

install-garaga:
	pip install garaga==0.17.0

devnet:
	starknet-devnet --accounts=2 --seed=0 --initial-balance=100000000000000000000000

accounts-file:
	curl -s http://localhost:5050/predeployed_accounts | jq '{"alpha-sepolia": {"devnet0": {address: .[0].address, private_key: .[0].private_key, public_key: .[0].public_key, class_hash: "0xe2eb8f5672af4e6a4e8a8f1b44989685e668489b0a25437733756c5a34a1d6", deployed: true, legacy: false, salt: "0x14", type: "open_zeppelin"}}}' > ./contracts/accounts.json

build-circuit:
	cd packages/circuit && nargo build

exec-circuit:
	cd packages/circuit && nargo execute witness

prove-circuit:
	bb prove --scheme ultra_honk --oracle_hash starknet -b ./packages/circuit/target/circuit.json -w ./packages/circuit/target/witness.gz -o ./circuit/target

gen-vk:
	bb write_vk --scheme ultra_honk --oracle_hash starknet -b ./packages/circuit/target/circuit.json -o ./packages/circuit/target

gen-verifier:
	cd packages/contracts && garaga gen --system ultra_starknet_honk --vk ../circuit/target/vk --project-name verifier

build-verifier:
	cd packages/contracts/verifier && scarb build

declare-verifier:
	cd packages/contracts && sncast declare --contract-name UltraStarknetHonkVerifier --package verifier

deploy-verifier:
	# TODO: use class hash from the result of the `make declare-verifier` step
	cd packages/contracts && sncast deploy --class-hash 0x057f6a6bda4e2ee16424f38a5c784dc31fc3c9dcfc0c8388fac4ba159a610edf

declare-contract:
	cd packages/contracts && sncast declare --contract-name Mastermind  --package mastermind

deploy-contract:
	# TODO: use class hash from the result of the `make declare-contract` step
	cd packages/contracts && sncast deploy --class-hash 0x024476d650e33213bcc4e92a76ae3df5462bd56b6090950cbd076c0f4f5580ff

verifier-artifacts:
	cp ./packages/circuit/target/circuit.json ./packages/app/src/assets/circuit.json
	cp ./packages/circuit/target/vk ./packages/app/src/assets/vk.bin
	cp ./packages/contracts/target/release/verifier_UltraKeccakHonkVerifier.contract_class.json ./packages/app/src/assets/verifier.json


contract-artifacts:
	cp ./contracts/target/release/mastermind_Mastermind.contract_class.json ./app/src/assets/contract.json

run-app:
	cd app && bun run dev
