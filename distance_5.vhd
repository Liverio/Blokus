library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity distance_5 is
	generic (player : tpPlayer := HERO);
	port (----------------
			---- INPUTS ----
			----------------
			-- Involved tiles
			J, K, L, N, Q, R, S: IN STD_LOGIC;
			-- Involved squares
			a2, b2: IN STD_LOGIC;
			a3, b3, c3, d3, e3: IN STD_LOGIC;
			a4, b4, c4, d4, e4, f4, g4, h4: IN STD_LOGIC;
			a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: IN STD_LOGIC;
			-----------------
			---- OUTPUTS ----
			-----------------
			acc_a5, acc_b5, acc_c5, acc_d5, acc_e5, acc_f5, acc_g5, acc_h5, acc_i5, acc_j5, acc_k5, acc_l5, acc_m5: OUT STD_LOGIC);
end distance_5;

architecture distance_5Arch of distance_5 is
begin
		-- Squares availability
		--					i5
		--          h5 f4 j5
		--       g5 e4 d3 g4 k5
		--    f5 d4 c3 b2 e3 h4 l5
		-- e5 c4 b3 a2 xx    m5  
		--    d5 b4 a3
		--       c5 a4 a5
		--          b5		 
		
		acc_a5 <= (N AND a5 AND a4 AND a3 AND a2);

acc_b5 <= (K AND b5 AND a4 AND a3 AND a2);

acc_c5 <= (S AND c5 AND a4 AND a3 AND a2) OR
      (R AND c5 AND b4 AND a3 AND a2) OR
      (Q AND c5 AND b4 AND b3 AND a2);

acc_d5 <= (L AND d5 AND b4 AND a3 AND a2) OR
      (L AND d5 AND b4 AND b3 AND a2) OR
      (K AND d5 AND c4 AND b3 AND a2);

acc_e5 <= (J AND e5 AND c4 AND b3 AND a2);

acc_f5 <= (L AND f5 AND d4 AND b3 AND a2) OR
      (L AND f5 AND d4 AND c3 AND a2) OR
      (K AND f5 AND c4 AND b3 AND a2) OR
      (K AND f5 AND d4 AND c3 AND b2);

acc_g5 <= (S AND g5 AND d4 AND c3 AND b2) OR
      (S AND g5 AND e4 AND c3 AND a2) OR
      (R AND g5 AND e4 AND c3 AND b2) OR
      (R AND g5 AND d4 AND c3 AND a2) OR
      (Q AND g5 AND d4 AND b3 AND a2) OR
      (Q AND g5 AND e4 AND d3 AND b2);

acc_h5 <= (L AND h5 AND e4 AND c3 AND b2) OR
      (L AND h5 AND e4 AND d3 AND b2) OR
      (K AND h5 AND e4 AND c3 AND a2) OR
      (K AND h5 AND f4 AND d3 AND b2);

acc_i5 <= (J AND i5 AND f4 AND d3 AND b2);

acc_j5 <= (L AND j5 AND g4 AND e3 AND b2) OR
      (L AND j5 AND g4 AND d3 AND b2) OR
      (K AND j5 AND f4 AND d3 AND b2);

acc_k5 <= (S AND k5 AND h4 AND e3 AND b2) OR
      (R AND k5 AND g4 AND e3 AND b2) OR
      (Q AND k5 AND g4 AND d3 AND b2);

acc_l5 <= (K AND l5 AND h4 AND e3 AND b2);

acc_m5 <= (N AND m5 AND h4 AND e3 AND b2);
end distance_5Arch;