CREATE OR REPLACE FUNCTION dune_user_generated.erc20_unique_holders (erc20_address bytea)
    RETURNS DECIMAL
AS $$
DECLARE
    unique_holders DECIMAL;
BEGIN
    SELECT
        COUNT (DISTINCT wallet_address) INTO unique_holders
    FROM
        (
            SELECT
                contract_address AS token_address,
                "from" || "to" AS wallet_address
            FROM
                erc20."ERC20_evt_Transfer"
            WHERE
                contract_address = erc20_address -- enter erc20 address
        ) AS erc20_holders_agg
    GROUP BY
        token_address;
    RETURN unique_holders;
END
$$ LANGUAGE 'plpgsql';
