library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.types.ALL;

entity board_storage is
	port (----------------
		  ---- INPUTS ----
		  ----------------
		  clk, rst : in STD_LOGIC;
		  new_data : in STD_LOGIC;
		  data	   : in STD_LOGIC_VECTOR(32-1 downto 0);
		  -----------------
		  ---- OUTPUTS ----
		  -----------------
		  board		  : out tpBoard;
		  tiles_hero  : out STD_LOGIC_VECTOR(21-1 downto 0);
		  tiles_rival : out STD_LOGIC_VECTOR(21-1 downto 0);
		  work_mode   : out tpWorkMode_accessibilityMap;
		  player      : out tpPlayer;
		  create_map  : out STD_LOGIC
	);
end board_storage;

architecture board_storage_arch of board_storage is
    --signal count: STD_LOGIC_VECTOR(4-1 downto 0);
    signal count: STD_LOGIC_VECTOR(5-1 downto 0);
    signal row: tpBoardRow;
begin       
	row_conversion: for j in 0 to 14-1 generate
        row(j)  <= data(2*j+1 downto 2*j);
	end generate;	
	
	process(clk)                                                                        
    begin                                                                                       
        if rising_edge(clk) then                                                       
            if rst = '1' then
				count <= (others => '0');
				board <= (others => (others => "00"));
            -- Board
			elsif new_data = '1' AND count <= 13 then
				board(conv_integer(count)) <= row;
				count <= count + 1;
			-- Tiles hero
			elsif new_data = '1' AND count = 14 then
				tiles_hero <= data(21-1 downto 0);
				count <= count + 1;
			-- Tiles_rival, work mode and player
			elsif new_data = '1' then
				tiles_rival <= data(21-1 downto 0);
				if data(21) = '0' then
				    work_mode <= EVALUATION_MODE;
				else
				    work_mode <= OVERLAPPING_MODE;
				end if;				
				player      <= data(22);
				--count <= (others => '0');
				count <= count + 1;
			elsif count = 16 then			
                count <= (others => '0');                
            end if;
        end if;
    end process;
	
	--create_map <= '1' when new_data = '1' AND count = 15 else '0';
	create_map <= '1' when count = 16 else '0';
end board_storage_arch;