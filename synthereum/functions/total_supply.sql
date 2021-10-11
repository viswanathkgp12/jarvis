/**
 * Custom function to get total supply of erc20 address
 *
 * JOIN or IN operator or erc20_balances based queries are too much time consuming
 * Hence this custom fn.
 **/
CREATE OR REPLACE FUNCTION dune_user_generated.erc20_total_supply (erc20_address bytea)
    RETURNS DECIMAL
AS $$
DECLARE
    total_supply DECIMAL;
BEGIN
    WITH erc20_transfers_agg AS (
        SELECT
            token_address,
            SUM(minted) as minted,
            SUM(burned) as burned
        FROM
            (
                SELECT
                    contract_address AS token_address,
                    CASE WHEN "from" = '\x0000000000000000000000000000000000000000' THEN (value / 10 ^ 18) ELSE 0 END AS minted,
                    CASE WHEN "to" = '\x0000000000000000000000000000000000000000' THEN (value / 10 ^ 18) ELSE 0 END AS burned
                FROM
                    erc20."ERC20_evt_Transfer"
                WHERE
                    contract_address = erc20_address -- enter token address here
            ) AS t
        GROUP BY
            token_address
    )
    SELECT
        SUM(minted) - SUM(burned) INTO total_supply
    FROM
        erc20_transfers_agg
    GROUP BY
        token_address;
    RETURN total_supply;
END
$$ LANGUAGE 'plpgsql';
