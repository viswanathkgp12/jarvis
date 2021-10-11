WITH jfiats as (
    SELECT
        e."output_newToken" AS token_address,
        contract_address,
        e."tokenDecimals" AS decimals,
        e."tokenName" AS name,
        e."tokenSymbol" AS symbol
    FROM
        jarvis_network."SynthereumSyntheticTokenPermitFactory_call_createToken" e
)
-- Get the total supply of all jFIATS
SELECT
    CONCAT(
        '<a href="https://polygonscan.com/address/',
        token_address,
        '">',
        token_address,
        '</a>'
    ) AS token_address,
    symbol,
    decimals,
    CASE WHEN total_supply IS NULL THEN 0 ELSE total_supply END,
    CASE WHEN holder_count IS NULL THEN 0 ELSE holder_count END
FROM
    (
        SELECT
            COALESCE('0x' || ENCODE(token_address, 'hex')) AS token_address,
            symbol,
            decimals,
            dune_user_generated.erc20_total_supply(token_address) AS total_supply,
            dune_user_generated.erc20_unique_holders(token_address) AS holder_count
        FROM
            jfiats
    ) e
