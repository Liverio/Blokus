library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity status_accessibility is
	port (----------------
			---- INPUTS ----
			----------------
			clk, rst : in STD_LOGIC;
			-- Vertex
			update_vertex : in STD_LOGIC;
			new_vertex 	  : in STD_LOGIC_VECTOR(8-1 downto 0);	-- 7..row..4 3..col..0
			-- Resets the vertex
			clear : in STD_LOGIC;					
			-----------------
			---- OUTPUTS ----
			-----------------
			-- Vertex
			last_vertex	: out STD_LOGIC_VECTOR(8-1 downto 0)
	);
end status_accessibility;

architecture status_accessibilityArch of status_accessibility is
	component reg
		generic(bits		 : positive := 128;
				  init_value : natural := 0);
		port (----------------
				---- INPUTS ----
				----------------
				clk : in std_logic;
				rst : in std_logic;
				ld	 : in std_logic;
				din : in std_logic_vector(bits-1 downto 0);
				-----------------
				---- OUTPUTS ----
				-----------------
				dout : out std_logic_vector(bits-1 downto 0)
		);
	end component;
	
	signal rstReg, ld_vertex: STD_LOGIC;
	signal vertex: STD_LOGIC_VECTOR(8-1 downto 0);
begin
		-- Unexplored vertex marked as 8+4+2 so comparison to check it are only need 3 bits (take 0000 1110 as "no vertex" since it is not a valid vertex)
		vertex_reg: reg generic map(8, 8+4+2)
			port map (clk, rstReg, ld_vertex, new_vertex, last_vertex);
		
		ld_vertex 		 <= '1' when update_vertex = '1' else '0';
		rstReg 			 <= '1' when rst = '1' OR clear = '1' else '0';
end status_accessibilityArch;