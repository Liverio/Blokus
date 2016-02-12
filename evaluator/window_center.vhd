---------------------------------------------------------------------------------
-- Analyses the four surrounding squares to a given vertex to know vertex type --
---------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.types.all;

entity window_center is
   port (----------------
			---- INPUTS ----
			----------------
			vertex_type : in STD_LOGIC_VECTOR(2-1 downto 0);
			vertex_row	: in STD_LOGIC_VECTOR(4-1 downto 0);
			vertex_col	: in STD_LOGIC_VECTOR(4-1 downto 0);			
			-----------------
			---- OUTPUTS ----
			-----------------
			window_center_out : out STD_LOGIC_VECTOR(8-1 downto 0)
	);
end window_center;

architecture window_centerArch of window_center is
	signal vertex_col_int: STD_LOGIC_VECTOR(4-1 downto 0);
	signal x_center, y_center: STD_LOGIC_VECTOR(4-1 downto 0);	
begin
	-- Non explored vertices are stored as 14, and it causes out of boundaries simulation error
	vertex_col_int <= vertex_col when conv_integer(vertex_col) <= 13 else "0000";
						
	-- Window center as a function of vertex coordinates and vertex type
	process(vertex_type, vertex_col_int, vertex_row)
	begin
		if		vertex_type = "00" then
			x_center <= vertex_col_int;
			y_center <= vertex_row;
		elsif vertex_type = "01" then
			x_center <= vertex_col_int + 1;
			y_center <= vertex_row;
		elsif vertex_type = "10" then
			x_center <= vertex_col_int + 1;
			y_center <= vertex_row + 1;
		else
			x_center <= vertex_col_int;
			y_center <= vertex_row + 1;
		end if;
	end process;
	
	-- Output
	window_center_out <= x_center & y_center;
end window_centerArch;