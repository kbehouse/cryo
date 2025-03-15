## NORE: address needs to be lowercase
# filter logs by address (filter all WETH logs)
cargo run -- logs --rpc https://mainnet.base.org  --blocks 27631889:27631891 --requests-per-second 999 --chunk-size 1000 --sort block_number --hex --csv --output-dir ./data --query "SELECT * FROM logs WHERE address = '0x4200000000000000000000000000000000000006'"

# filter blocks by gas_used >= 50M
cargo run -- blocks --rpc https://mainnet.base.org  -b 27631890:+10 --requests-per-second 999 --chunk-size 1000 --sort block_number --hex --csv --output-dir ./data --query "SELECT * FROM blocks WHERE gas_used >= 50000000"

# filter erc20_transfers by USDC(0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913)
cargo run -- erc20_transfers --rpc https://mainnet.base.org -b 27631890:+10 --requests-per-second 999 --csv --output-dir ./data --query "SELECT * FROM erc20_transfers WHERE erc20 = LOWER('0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913')"

# error test, erc202 is not a column of erc20_transfers
cargo run -- erc20_transfers --rpc https://mainnet.base.org -b 27631890:+10 --requests-per-second 999 --csv --output-dir ./data --query "SELECT * FROM erc20_transfers WHERE erc202 = LOWER('0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913')"
# (errors in 1 chunks)
# - Collect failed: Error executing SQL query on erc20_transfers: not found: unable to find column "erc202"; valid columns: ["block_number", "transaction_index", "log_index", "transaction_hash", "erc20", "from_address", "to_address", "value_binary", "value_string", "value_f64", "chain_id"]


# filter transactions
#cargo run -- transactions --rpc https://mainnet.base.org -b 1000:+10 --requests-per-second 999 --csv --output-dir ./data
# the ORIGINAL main branch has following problem
# error summary
# ─────────────
# (errors in 1 chunks)
# - Failed to get block: deserialization error: data did not match any variant of untagged enum BlockTransactions at line 1 column 2429 (1x)
