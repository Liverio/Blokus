library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity adder is
	generic (input_width: positive := 1);
	port(a, b: in  STD_LOGIC_VECTOR(input_width-1 downto 0);
		  add : out STD_LOGIC_VECTOR((input_width+1)-1 downto 0)
	);
end adder;

architecture adderArch of adder is
begin
		add <= ("0"&a) + ("0"&b);
end adderArch;