library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity vertex_squares_mux is
	port (----------------
			---- INPUTS ----
			----------------
			vertex_type: IN STD_LOGIC_VECTOR(2-1 downto 0);
			a2_in, b2_in,
			a3_in, b3_in, c3_in, d3_in, e3_in,
			a4_in, b4_in, c4_in, d4_in, e4_in, f4_in, g4_in, h4_in,
			a5_in, b5_in, c5_in, d5_in, e5_in, f5_in, g5_in, h5_in, i5_in, j5_in, k5_in, l5_in, m5_in: IN STD_LOGIC_VECTOR(4-1 downto 0);
			-----------------
			---- OUTPUTS ----
			-----------------
			a2, b2, a3, b3, c3, d3, e3, a4, b4, c4, d4, e4, f4, g4, h4, a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: OUT STD_LOGIC);
end vertex_squares_mux;

architecture vertex_squares_muxArch of vertex_squares_mux is	
begin
		-- Vertex info input mux
		a2 <= a2_in(conv_integer(vertex_type));
		b2 <= b2_in(conv_integer(vertex_type));
		a3 <= a3_in(conv_integer(vertex_type));
		b3 <= b3_in(conv_integer(vertex_type));
		c3 <= c3_in(conv_integer(vertex_type));
		d3 <= d3_in(conv_integer(vertex_type));
		e3 <= e3_in(conv_integer(vertex_type));
		a4 <= a4_in(conv_integer(vertex_type));
		b4 <= b4_in(conv_integer(vertex_type));
		c4 <= c4_in(conv_integer(vertex_type));
		d4 <= d4_in(conv_integer(vertex_type));
		e4 <= e4_in(conv_integer(vertex_type));
		f4 <= f4_in(conv_integer(vertex_type));
		g4 <= g4_in(conv_integer(vertex_type));
		h4 <= h4_in(conv_integer(vertex_type));
		a5 <= a5_in(conv_integer(vertex_type));
		b5 <= b5_in(conv_integer(vertex_type));
		c5 <= c5_in(conv_integer(vertex_type));
		d5 <= d5_in(conv_integer(vertex_type));
		e5 <= e5_in(conv_integer(vertex_type));
		f5 <= f5_in(conv_integer(vertex_type));
		g5 <= g5_in(conv_integer(vertex_type));
		h5 <= h5_in(conv_integer(vertex_type));
		i5 <= i5_in(conv_integer(vertex_type));
		j5 <= j5_in(conv_integer(vertex_type));
		k5 <= k5_in(conv_integer(vertex_type));
		l5 <= l5_in(conv_integer(vertex_type));
		m5 <= m5_in(conv_integer(vertex_type));
end vertex_squares_muxArch;