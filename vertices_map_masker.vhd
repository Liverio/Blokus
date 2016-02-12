--------------------------------
-- Masks the explored vertices --
--------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.types.ALL;

entity vertices_map_masker is
	port (----------------
			---- INPUTS ----
			----------------
			vertices_map : in tpVertices_map;
			last_vertex	 : in STD_LOGIC_VECTOR(8-1 downto 0);	-- 7..row..4 3..col..0
			-----------------
			---- OUTPUTS ----
			-----------------
			vertices_map_masked : out tpVertices_map
	);
end vertices_map_masker;

architecture vertices_map_maskerArch of vertices_map_masker is	
begin
	rows: for i in 0 to 13-1 generate
		cols: for j in 0 to 13-1 generate		  -- Not unexplored board			
			vertices_map_masked(i)(j) <= '0' when last_vertex(3 downto 1) /= "111" AND
															  -- Positions previous to the last vertex
															  (
															   (i < conv_integer(last_vertex(7 downto 4))) 																 OR
																(i = conv_integer(last_vertex(7 downto 4)) AND j <= conv_integer(last_vertex(3 downto 0)))
															  )
												  else vertices_map(i)(j);
		end generate cols;
	end generate rows;
end vertices_map_maskerArch;