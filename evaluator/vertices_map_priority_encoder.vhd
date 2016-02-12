library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity priority_encoder is
	port (----------------
			---- INPUTS ----
			----------------
			vertices_map : in tpVertices_map;
			-----------------
			---- OUTPUTS ----
			-----------------
			row 		 : out STD_LOGIC_VECTOR(4-1 downto 0);
			col 		 : out STD_LOGIC_VECTOR(4-1 downto 0);
			no_vertex : out STD_LOGIC
	);
end priority_encoder;

architecture priority_encoderArch of priority_encoder is		
begin
	process(vertices_map)
	begin
		row <= conv_std_logic_vector(0, 4);
		col <= conv_std_logic_vector(0, 4);
		no_vertex <= '1';
		for i in 12 downto 0 loop
			for j in 12 downto 0 loop
				if vertices_map(i)(j) = '1' then
					no_vertex <= '0';
					row <= conv_std_logic_vector(i, 4);
					col <= conv_std_logic_vector(j, 4);
				end if;
			end loop;
		end loop;
	end process;
end priority_encoderArch;