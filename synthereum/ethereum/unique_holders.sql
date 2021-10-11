SELECT
    token_address,
    symbol,
    decimals,
    dune_user_generated.erc20_unique_holders(token_address)
FROM
    dune_user_generated.view_jarvis_fiats
