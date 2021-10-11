DROP VIEW dune_user_generated.view_jarvis_fiats;

CREATE OR REPLACE VIEW dune_user_generated.view_jarvis_fiats (symbol, token_address, decimals) AS VALUES
('jEUR'::text, '\x0f17BC9a994b87b5225cFb6a2Cd4D667ADb4F20B'::bytea, 18::numeric),
('jGBP'::text, '\x7409856CAE628f5d578B285B45669b36E7005283'::bytea, 18::numeric),
('jCHF'::text, '\x53dfEa0A8CC2A2A2e425E1C174Bc162999723ea0'::bytea, 18::numeric);
