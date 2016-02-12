--  - 
-- | |	<-- square (0,0)
--  -x	<-- vertex (0,0)
--
-- MATCHING BETWEEN SQUARES AND VERTEX:
-- 	type 0) 
--			vertex (i,j) requires: 
--								- square (i+1,j+1): SQUARE_HERO
--								- square (i  ,j  ): SQUARE_FREE
--								- square (i  ,j+1): NOT(SQUARE_HERO)
--								- square (i+1,j  ): NOT(SQUARE_HERO)
-- 	type 1) 
--			vertex (i,j) requires: 
--								- square (i+1,j  ): SQUARE_HERO
--								- square (i  ,j+1): SQUARE_FREE
--								- square (i  ,j  ): NOT(SQUARE_HERO)
--								- square (i+1,j+1): NOT(SQUARE_HERO)
-- 	type 2) 
--			vertex (i,j) requires: 
--								- square (i  ,j  ): SQUARE_HERO
--								- square (i+1,j+1): SQUARE_FREE
--								- square (i+1,j  ): NOT(SQUARE_HERO)
-- 							- square (i  ,j+1): NOT(SQUARE_HERO)
-- 	type 3) 
--			vertex (i,j) requires: 
--								- square (i  ,j+1): SQUARE_HERO
--								- square (i+1,j  ): SQUARE_FREE
--								- square (i  ,j  ): NOT(SQUARE_HERO)
--								- square (i+1,j+1): NOT(SQUARE_HERO)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.types.ALL;

entity vertices_map is
	generic (player: tpPlayer := HERO);
	port (----------------
			---- INPUTS ----
			----------------
			board	 		: in tpBoard;
			board_color	: in tpBoard;
			-----------------
			---- OUTPUTS ----
			-----------------
			vertices_map : out tpVertices_map;	-- 13*13 = 169 bits
			vertices_type_map : out tpVertices_type_map	-- 13*13*2 = 338 bits
	);
end vertices_map;

architecture vertices_mapArch of vertices_map is
	component vertex_detector
		generic (player: tpPlayer := HERO);
		port (----------------
				---- INPUTS ----
				----------------
				-- Forbiddens info
				upper_left	 : in tpSquare;
				upper_right	 : in tpSquare;
				bottom_left	 : in tpSquare;
				bottom_right : in tpSquare;
				-- Color info
				upper_left_color	 : in tpSquare;
				upper_right_color	 : in tpSquare;
				bottom_left_color	 : in tpSquare;
				bottom_right_color : in tpSquare;
				-----------------
				---- OUTPUTS ----
				-----------------
				vertex_found : out STD_LOGIC;
				vertex_type	 : out STD_LOGIC_VECTOR(2-1 downto 0)
		);
	end component;
begin
	rows: for i in 0 to 13-1 generate
		cols: for j in 0 to 13-1 generate						
			vertex_detector_I: vertex_detector generic map(player)
										port map(-- INPUTS --
													board(i  )(j ), 
													board(i  )(j+1),
													board(i+1)(j  ),
													board(i+1)(j+1),
													board_color(i  )(j ), 
													board_color(i  )(j+1),
													board_color(i+1)(j  ),
													board_color(i+1)(j+1),
													-- OUTPUTS --
													vertices_map	  (i)(j),
													vertices_type_map(i, j));
		end generate cols;
	end generate rows;
end vertices_mapArch;