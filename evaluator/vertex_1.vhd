library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity vertex_1 is
	port (window: in tpProcessingWindow;
			a2, b2: OUT STD_LOGIC;
			a3, b3, c3, d3, e3: OUT STD_LOGIC;
			a4, b4, c4, d4, e4, f4, g4, h4: OUT STD_LOGIC;
			a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: OUT STD_LOGIC);
end vertex_1;

architecture vertex_1Arch of vertex_1 is
begin
		-- Squares availability
		--				e5
		--       d5 c4 f5
		--    c5 b4 b3 d4 g5
		-- b5 a4 a3 a2 c3 e4 h5
		--    a5    xx b2 d3 f4 i5
		--             e3 g4 j5
		--          m5 h4 k5
		--             l5
		
		a2 <= window(-1, 0);
		b2 <= window( 0, 1);
		a3 <= window(-1,-1);
		b3 <= window(-2, 0);
		c3 <= window(-1, 1);
		d3 <= window( 0, 2);
		e3 <= window( 1, 1);
		a4 <= window(-1,-2);
		b4 <= window(-2,-1);
		c4 <= window(-3, 0);
		d4 <= window(-2, 1);
		e4 <= window(-1, 2);
		f4 <= window( 0, 3);
		g4 <= window( 1, 2);
		h4 <= window( 2, 1);
		a5 <= window( 0,-2);
		b5 <= window(-1,-3);
		c5 <= window(-2,-2);
		d5 <= window(-3,-1);
		e5 <= window(-4, 0);
		f5 <= window(-3, 1);
		g5 <= window(-2, 2);
		h5 <= window(-1, 3);
		i5 <= window( 0, 4);
		j5 <= window( 1, 3);
		k5 <= window( 2, 2);
		l5 <= window( 3, 1);
		m5 <= window( 2, 0);
end vertex_1Arch;