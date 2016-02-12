library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.types.ALL;

entity vertex_detector is
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
			vertex_type : out STD_LOGIC_VECTOR(2-1 downto 0)
	);
end vertex_detector;

architecture vertex_detectorArch of vertex_detector is
	signal upper_left_bit, upper_right_bit, bottom_left_bit, bottom_right_bit: STD_LOGIC;
	signal upper_left_color_bit, upper_right_color_bit, bottom_left_color_bit, bottom_right_color_bit: STD_LOGIC;
begin
	-- Board encoding				|	-- Color Board encoding
		-- 00	Free					|		-- 00	Free
		-- 01	Rival					|		-- 01	Forbidden Rival
		-- 10	Hero					|		-- 10 Forbidden Hero
		-- 11	NOT USED HERE		|		-- 11 Forbidden both
		
	player_hero: if player = HERO generate
		upper_left_bit   <= upper_left(1);
		upper_right_bit  <= upper_right(1);
		bottom_left_bit  <= bottom_left(1);
		bottom_right_bit <= bottom_right(1);
		upper_left_color_bit   <= upper_left_color(1);
		upper_right_color_bit  <= upper_right_color(1);
		bottom_left_color_bit  <= bottom_left_color(1);
		bottom_right_color_bit <= bottom_right_color(1);
	end generate;
	
	player_rival: if player = RIVAL generate
		upper_left_bit   <= upper_left(0);
		upper_right_bit  <= upper_right(0);
		bottom_left_bit  <= bottom_left(0);
		bottom_right_bit <= bottom_right(0);
		upper_left_color_bit   <= upper_left_color(0);
		upper_right_color_bit  <= upper_right_color(0);
		bottom_left_color_bit  <= bottom_left_color(0);
		bottom_right_color_bit <= bottom_right_color(0);
	end generate;	
	
	
	vertex_found <= '1' when -- type 0
									 --  - 
									 -- | |
									 --  -x
									(upper_left_bit			= '0' AND	-- Free OR Forbidden Rival
									 bottom_right_color_bit = '1'  		-- Hero tile
									) OR
									-- type 1
									--  - 
									-- | |
									-- x-
									(upper_right_bit	  		= '0' AND	-- Free OR Forbidden Rival
									 bottom_left_color_bit  = '1'			-- Hero tile
									) OR
									-- type 2
									-- x- 
									-- | |
									--  -
									(upper_left_color_bit	= '1' AND	-- Hero tile
									 bottom_right_bit	  		= '0'    	-- Free OR Forbidden Rival
									) OR
									-- type 3
									--  -x 
									-- | |
									--  -
									(upper_right_color_bit  = '1' AND	-- Hero tile
									 bottom_left_bit	  		= '0'			-- Free OR Forbidden Rival
									)

						 else '0';
	
	vertex_type <= "00" when -- type 0
									 --  - 
									 -- | |
									 --  -x
									upper_left_bit			  = '0' AND	-- Free OR Forbidden Rival
									bottom_right_color_bit = '1'  	-- Hero tile
									else
						"01" when -- type 1
									 --  - 
									 -- | |
									 -- x-
									 upper_right_bit	  		= '0' AND	-- Free OR Forbidden Rival
									 bottom_left_color_bit  = '1'			-- Hero tile
									else
						"10" when -- type 2
									 -- x- 
									 -- | |
									 --  -
									 upper_left_color_bit	= '1' AND	-- Hero tile
									 bottom_right_bit	  		= '0'    	-- Free OR Forbidden Rival
									else 
						"11";
end vertex_detectorArch;