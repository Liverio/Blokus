library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity reg is
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
end reg;

architecture regArch of reg is
   signal cs, ns : std_logic_vector(bits-1 downto 0);
begin
	state:
	process(clk)
	begin
		if clk'event AND clk = '1' then
			if rst = '1' then
				cs <= conv_std_logic_vector(init_value, bits);
			else         
				cs <= ns;
			end if;
		end if;
	end process;

   ns <= din when ld = '1' else cs;
	
	dout <= cs;
end regArch;