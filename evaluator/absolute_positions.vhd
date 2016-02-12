library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity absolute_positions is
	port (----------------
			---- INPUTS ----
			----------------
			vertex_x, vertex_y: in STD_LOGIC_VECTOR(4-1 downto 0);
			vertex_type: in STD_LOGIC_VECTOR(2-1 downto 0);
			-----------------
			---- OUTPUTS ----
			-----------------
			pos_a1: OUT STD_LOGIC_VECTOR(8-1 downto 0);			
			pos_a2, pos_b2: OUT STD_LOGIC_VECTOR(8-1 downto 0);
			pos_a3, pos_b3, pos_c3, pos_d3, pos_e3: OUT STD_LOGIC_VECTOR(8-1 downto 0);
			pos_a4, pos_b4, pos_c4, pos_d4, pos_e4, pos_f4, pos_g4, pos_h4: OUT STD_LOGIC_VECTOR(8-1 downto 0);
			pos_a5, pos_b5, pos_c5, pos_d5, pos_e5, pos_f5, pos_g5, pos_h5, pos_i5, pos_j5, pos_k5, pos_l5, pos_m5: OUT STD_LOGIC_VECTOR(8-1 downto 0));
end absolute_positions;

architecture absolute_positionsArch of absolute_positions is
begin
	pos_a1 <= conv_std_logic_vector(conv_integer(vertex_x), 4) & conv_std_logic_vector(conv_integer(vertex_y), 4);
	process (vertex_type, vertex_x, vertex_y)
	begin
		if conv_integer(vertex_type) = 0 then
			pos_a2 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_b2 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_a3 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_b3 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_c3 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_d3 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_e3 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_a4 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_b4 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_c4 <= conv_std_logic_vector(conv_integer(vertex_x) - 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_d4 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_e4 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_f4 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 3, 4);
			pos_g4 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_h4 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);			
			pos_a5 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_b5 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 3, 4);
			pos_c5 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_d5 <= conv_std_logic_vector(conv_integer(vertex_x) - 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_e5 <= conv_std_logic_vector(conv_integer(vertex_x) - 4, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_f5 <= conv_std_logic_vector(conv_integer(vertex_x) - 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_g5 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_h5 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 3, 4);
			pos_i5 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 4, 4);
			pos_j5 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 3, 4);
			pos_k5 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_l5 <= conv_std_logic_vector(conv_integer(vertex_x) + 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_m5 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);			
		elsif conv_integer(vertex_type) = 1 then
			pos_a2 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_b2 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_a3 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_b3 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_c3 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_d3 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_e3 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_a4 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_b4 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_c4 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 3, 4);
			pos_d4 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_e4 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_f4 <= conv_std_logic_vector(conv_integer(vertex_x) + 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_g4 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_h4 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);			
			pos_a5 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_b5 <= conv_std_logic_vector(conv_integer(vertex_x) - 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_c5 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_d5 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 3, 4);
			pos_e5 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 4, 4);
			pos_f5 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 3, 4);
			pos_g5 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_h5 <= conv_std_logic_vector(conv_integer(vertex_x) + 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_i5 <= conv_std_logic_vector(conv_integer(vertex_x) + 4, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_j5 <= conv_std_logic_vector(conv_integer(vertex_x) + 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_k5 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_l5 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 3, 4);
			pos_m5 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
		elsif conv_integer(vertex_type) = 2 then
			pos_a2 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_b2 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_a3 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_b3 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_c3 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_d3 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_e3 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_a4 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_b4 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_c4 <= conv_std_logic_vector(conv_integer(vertex_x) + 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_d4 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_e4 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_f4 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 3, 4);
			pos_g4 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_h4 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);			
			pos_a5 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_b5 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 3, 4);
			pos_c5 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_d5 <= conv_std_logic_vector(conv_integer(vertex_x) + 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_e5 <= conv_std_logic_vector(conv_integer(vertex_x) + 4, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_f5 <= conv_std_logic_vector(conv_integer(vertex_x) + 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_g5 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_h5 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 3, 4);
			pos_i5 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 4, 4);
			pos_j5 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 3, 4);
			pos_k5 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_l5 <= conv_std_logic_vector(conv_integer(vertex_x) - 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_m5 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
		else
			pos_a2 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_b2 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_a3 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_b3 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_c3 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_d3 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_e3 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_a4 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_b4 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_c4 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 3, 4);
			pos_d4 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_e4 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_f4 <= conv_std_logic_vector(conv_integer(vertex_x) - 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_g4 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_h4 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);			
			pos_a5 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_b5 <= conv_std_logic_vector(conv_integer(vertex_x) + 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_c5 <= conv_std_logic_vector(conv_integer(vertex_x) + 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_d5 <= conv_std_logic_vector(conv_integer(vertex_x) + 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 3, 4);
			pos_e5 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 4, 4);
			pos_f5 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 3, 4);
			pos_g5 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 2, 4);
			pos_h5 <= conv_std_logic_vector(conv_integer(vertex_x) - 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 1, 4);
			pos_i5 <= conv_std_logic_vector(conv_integer(vertex_x) - 4, 4) & conv_std_logic_vector(conv_integer(vertex_y) + 0, 4);
			pos_j5 <= conv_std_logic_vector(conv_integer(vertex_x) - 3, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 1, 4);
			pos_k5 <= conv_std_logic_vector(conv_integer(vertex_x) - 2, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
			pos_l5 <= conv_std_logic_vector(conv_integer(vertex_x) - 1, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 3, 4);
			pos_m5 <= conv_std_logic_vector(conv_integer(vertex_x) + 0, 4) & conv_std_logic_vector(conv_integer(vertex_y) - 2, 4);
		end if;
	end process;
end absolute_positionsArch;