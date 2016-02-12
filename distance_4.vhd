library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity distance_4 is
	generic (player : tpPlayer := HERO);
	port (----------------
			---- INPUTS ----
			----------------
			-- Involved tiles
			E, F, I, J, K, L, M, N, O, P, Q, R, S, T: IN STD_LOGIC;
			-- Involved squares
			a2, b2: IN STD_LOGIC;
			a3, b3, c3, d3, e3: IN STD_LOGIC;
			a4, b4, c4, d4, e4, f4, g4, h4: IN STD_LOGIC;
			a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: IN STD_LOGIC;
			-----------------
			---- OUTPUTS ----
			-----------------
			acc_a4, acc_b4, acc_c4, acc_d4, acc_e4, acc_f4, acc_g4, acc_h4: OUT STD_LOGIC);
end distance_4;

architecture distance_4Arch of distance_4 is	
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
		 
		acc_a4 <= (T AND a4 AND b4 AND a3 AND a2) OR
      (S AND c5 AND a4 AND a3 AND a2) OR
      (P AND a4 AND a3 AND b3 AND a2) OR
      (O AND a4 AND a3 AND c3 AND a2) OR
      (N AND a5 AND a4 AND a3 AND a2) OR
      (L AND a4 AND a3 AND a2 AND b2) OR
      (K AND b5 AND a4 AND a3 AND a2) OR
      (F AND a4 AND a3 AND a2);

acc_b4 <= (T AND a4 AND b4 AND a3 AND a2) OR
      (T AND b4 AND b3 AND c3 AND a2) OR
      (T AND b4 AND a3 AND c3 AND a2) OR
      (S AND b4 AND b3 AND a2 AND b2) OR
      (R AND c5 AND b4 AND a3 AND a2) OR
      (R AND b4 AND a3 AND a2 AND b2) OR
      (Q AND c5 AND b4 AND b3 AND a2) OR
      (P AND b4 AND d4 AND b3 AND a2) OR
      (O AND b4 AND c4 AND b3 AND a2) OR
      (M AND b4 AND a3 AND b3 AND a2) OR
      (L AND d5 AND b4 AND a3 AND a2) OR
      (L AND d5 AND b4 AND b3 AND a2) OR
      (I AND b4 AND a3 AND a2) OR
      (F AND b4 AND b3 AND a2);

acc_c4 <= (O AND c4 AND a3 AND b3 AND a2) OR
      (O AND b4 AND c4 AND b3 AND a2) OR
      (O AND c4 AND d4 AND b3 AND a2) OR
      (O AND c4 AND b3 AND c3 AND a2) OR
      (K AND f5 AND c4 AND b3 AND a2) OR
      (K AND c4 AND b3 AND a2 AND b2) OR
      (K AND d5 AND c4 AND b3 AND a2) OR
      (J AND e5 AND c4 AND b3 AND a2) OR
      (E AND c4 AND b3 AND a2);

acc_d4 <= (T AND d4 AND a3 AND b3 AND a2) OR
      (T AND d4 AND a3 AND c3 AND a2) OR
      (T AND d4 AND e4 AND c3 AND b2) OR
      (T AND d4 AND e4 AND c3 AND a2) OR
      (S AND g5 AND d4 AND c3 AND b2) OR
      (R AND g5 AND d4 AND c3 AND a2) OR
      (Q AND g5 AND d4 AND b3 AND a2) OR
      (P AND b4 AND d4 AND b3 AND a2) OR
      (P AND d4 AND c3 AND d3 AND b2) OR
      (O AND d4 AND c3 AND e3 AND b2) OR
      (O AND c4 AND d4 AND b3 AND a2) OR
      (N AND d4 AND b3 AND a2 AND b2) OR
      (N AND d4 AND b3 AND c3 AND b2) OR
      (M AND d4 AND b3 AND c3 AND a2) OR
      (M AND d4 AND c3 AND a2 AND b2) OR
      (L AND f5 AND d4 AND b3 AND a2) OR
      (L AND f5 AND d4 AND c3 AND a2) OR
      (K AND f5 AND d4 AND c3 AND b2) OR
      (I AND d4 AND c3 AND a2) OR
      (F AND d4 AND b3 AND a2) OR
      (F AND d4 AND c3 AND b2);

acc_e4 <= (T AND e4 AND c3 AND e3 AND b2) OR
      (T AND e4 AND d3 AND e3 AND b2) OR
      (T AND d4 AND e4 AND c3 AND b2) OR
      (T AND d4 AND e4 AND c3 AND a2) OR
      (S AND g5 AND e4 AND c3 AND a2) OR
      (R AND g5 AND e4 AND c3 AND b2) OR
      (Q AND g5 AND e4 AND d3 AND b2) OR
      (P AND e4 AND b3 AND c3 AND a2) OR
      (P AND e4 AND g4 AND d3 AND b2) OR
      (O AND e4 AND f4 AND d3 AND b2) OR
      (O AND e4 AND a3 AND c3 AND a2) OR
      (N AND e4 AND d3 AND a2 AND b2) OR
      (N AND e4 AND c3 AND d3 AND a2) OR
      (M AND e4 AND c3 AND a2 AND b2) OR
      (M AND e4 AND c3 AND d3 AND b2) OR
      (L AND h5 AND e4 AND c3 AND b2) OR
      (L AND h5 AND e4 AND d3 AND b2) OR
      (K AND h5 AND e4 AND c3 AND a2) OR
      (I AND e4 AND c3 AND b2) OR
      (F AND e4 AND c3 AND a2) OR
      (F AND e4 AND d3 AND b2);

acc_f4 <= (O AND f4 AND g4 AND d3 AND b2) OR
      (O AND e4 AND f4 AND d3 AND b2) OR
      (O AND f4 AND c3 AND d3 AND b2) OR
      (O AND f4 AND d3 AND e3 AND b2) OR
      (K AND f4 AND d3 AND a2 AND b2) OR
      (K AND j5 AND f4 AND d3 AND b2) OR
      (K AND h5 AND f4 AND d3 AND b2) OR
      (J AND i5 AND f4 AND d3 AND b2) OR
      (E AND f4 AND d3 AND b2);

acc_g4 <= (T AND g4 AND c3 AND e3 AND b2) OR
      (T AND g4 AND c3 AND d3 AND b2) OR
      (T AND g4 AND h4 AND e3 AND b2) OR
      (S AND g4 AND d3 AND a2 AND b2) OR
      (R AND k5 AND g4 AND e3 AND b2) OR
      (R AND g4 AND e3 AND a2 AND b2) OR
      (Q AND k5 AND g4 AND d3 AND b2) OR
      (P AND e4 AND g4 AND d3 AND b2) OR
      (O AND f4 AND g4 AND d3 AND b2) OR
      (M AND g4 AND d3 AND e3 AND b2) OR
      (L AND j5 AND g4 AND e3 AND b2) OR
      (L AND j5 AND g4 AND d3 AND b2) OR
      (I AND g4 AND e3 AND b2) OR
      (F AND g4 AND d3 AND b2);

acc_h4 <= (T AND g4 AND h4 AND e3 AND b2) OR
      (S AND k5 AND h4 AND e3 AND b2) OR
      (P AND h4 AND d3 AND e3 AND b2) OR
      (O AND h4 AND c3 AND e3 AND b2) OR
      (N AND m5 AND h4 AND e3 AND b2) OR
      (L AND h4 AND e3 AND a2 AND b2) OR
      (K AND l5 AND h4 AND e3 AND b2) OR
      (F AND h4 AND e3 AND b2);
end distance_4Arch;