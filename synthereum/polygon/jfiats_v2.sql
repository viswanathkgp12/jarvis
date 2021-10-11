SELECT
    e."output_newToken",
    contract_address,
    e."tokenDecimals",
    e."tokenName",
    e."tokenSymbol"
FROM
    jarvis_network."SynthereumSyntheticTokenPermitFactory_call_createToken" e
