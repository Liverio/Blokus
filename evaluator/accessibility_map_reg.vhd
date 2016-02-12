library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity accessibility_map_reg is
	generic (bits_score : positive := 9);
	port (----------------
			---- INPUTS ----
			----------------
			clk, rst : in STD_LOGIC;
			ld	   : in STD_LOGIC;
			clear  : in STD_LOGIC;
			map_in : in tpAccessibility_map;
			-----------------
			---- OUTPUTS ----
			-----------------
			map_out : out tpAccessibility_map
	);
end accessibility_map_reg;

architecture accessibility_map_regArch of accessibility_map_reg is
   signal cs, ns : tpAccessibility_map;
begin
	state:
	process(clk)
	begin
		if clk'event AND clk = '1' then
			if rst = '1' OR clear = '1' then
				for i in 0 to 14-1 loop
					for j in 0 to 14-1 loop
						cs(i,j) <= '0';
					end loop;
				end loop;
			else         
				cs <= ns;
			end if;
		end if;
	end process;

	ns <= map_in when ld = '1' else cs;
	
	map_out <= cs;
end accessibility_map_regArch;