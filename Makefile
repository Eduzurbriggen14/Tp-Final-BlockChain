-include .env

# Direccion de contrato
CONTRACT_CCNFT := 0xd68182eCde05f9c859D183710719FC00953946C8
CONTRACT_BUSD := 0xDEd7294Eba3a729486Cf610CbC6139AAFd007319
FUNDS_COLLECTOR := 0x3DaEeA66074e196B084Dbb4B4e283f3Bb49DecCf
FEES_COLLECTOR := 0xeb7878ed3CB9a0927ae0A392e406618B1D383Cc1

CONFIG_SEPOLIA = --rpc-url ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY} --etherscan-api-key ${ETHERSCAN_API_KEY}

CONFIG_SEPOLIA_VERIFY := ${CONFIG_SEPOLIA} --broadcast -vvvv --verify

runtest:
	@forge test -vvv -gas-report -g

deployCCNFT:
	@forge script script/DeployCCNFT.s.sol:DeployCCNFT ${CONFIG_SEPOLIA_VERIFY}

deployBUSD:
	@forge script script/DeployBUSD.s.sol:DeployBUSD ${CONFIG_SEPOLIA_VERIFY}

setFundsToken:
	@cast send ${CONTRACT_CCNFT} "setFundsToken(address)" ${CONTRACT_BUSD} ${CONFIG_SEPOLIA}

setFeesCollector:
	@cast send ${CONTRACT_CCNFT} "setFeesCollector(address)" ${FEES_COLLECTOR} $(CONFIG_SEPOLIA)

setFundsCollector:
	@cast send ${CONTRACT_CCNFT} "setFundsCollector(address)" ${FUNDS_COLLECTOR} $(CONFIG_SEPOLIA)

setRequiredVars:
	@cast send ${CONTRACT_CCNFT} "setMaxValueToRaise(uint256)" 100000000000000000000000000 $(CONFIG_SEPOLIA)
	@cast send ${CONTRACT_CCNFT} "setCanBuy(bool)" true $(CONFIG_SEPOLIA)
	@cast send ${CONTRACT_CCNFT} "setMaxBatchCount(uint16)" 8 $(CONFIG_SEPOLIA)
	@cast send ${CONTRACT_CCNFT} "setBuyFee(uint16)" 10 $(CONFIG_SEPOLIA)

addValidValues:
	@cast send ${CONTRACT_CCNFT} "addValidValues(uint256)" 24000000000000000000000 $(CONFIG_SEPOLIA)

approveFunds:
	@cast send ${CONTRACT_BUSD} "approve(address, uint256)" ${CONTRACT_CCNFT} 100000000000000000000000000 $(CONFIG_SEPOLIA)

buy:
	@cast send ${CONTRACT_CCNFT} "buy(uint256, uint256)" 24000000000000000000000 1 $(CONFIG_SEPOLIA)
