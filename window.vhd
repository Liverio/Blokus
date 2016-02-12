library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.types.all;

entity processing_window is
	generic (player : tpPlayer := HERO);
   port (----------------
			---- INPUTS ----
			----------------
			-- Current board
			board : in tpBoard;
			-- Vertex coordinates (processing window center) and vertex type
			window_x, window_y : in STD_LOGIC_VECTOR(4-1 downto 0);			
			-----------------
			---- OUTPUTS ----
			-----------------			
			-- Processing window
			window : out tpProcessingWindow
	);
end processing_window;

architecture processing_windowArch of processing_window is
begin		
	-- 		*** type 0 ***						*** type 1 ***			  			*** type 2 ***					*** type 3 ***	
	--					i5									e5
	--          h5 f4 j5				--       d5 c4 f5					--             b5					--          l5
	--       g5 e4 d3 g4 k5			--    c5 b4 b3 d4 g5				--          a5 a4 c5				--       k5 h4 m5
	--    f5 d4 c3 b2 e3 h4 l5		-- b5 a4 a3 a2 c3 e4 h5			--             a3 b4 d5			--    j5 g4 e3
	-- e5 c4 b3 a2 xx    m5 		--    a5    xx b2 d3 f4 i5		--    m5    xx a2 b3 c4 e5		-- i5 f4 d3 b2 xx    a5 
	--    d5 b4 a3						--             e3 g4 j5			-- l5 h4 e3 b2 c3 d4 f5			--    h5 e4 c3 a2 a3 a4 b5
	--       c5 a4 a5					--          m5 h4 k5				--    k5 g4 d3 e4 g5				--       g5 d4 b3 b4 c5
	--          b5 					--             l5					--       j5 f4 h5					--          f5 c4 d5		
	--																								i5										   e5
	
	hero_bit: if player = HERO generate
		process(window_x, window_y, board)
		begin
			for i in -4 to 4 loop
				for j in -4 to 4 loop
					-- Out of board
					if (conv_integer(window_y)+i < 0) OR (conv_integer(window_y)+i > 13) OR (conv_integer(window_x)+j < 0) OR (conv_integer(window_x)+j > 13) then
						window(i,j) <= '0';
					-- Board squares multiplexing 
					else
						-- Some squares are unreachable, some its output does not care. We set them to FORBIDDEN_BOTH
						if ((i =  0) AND (j  = 0))											OR	-- Center position is known to be available
							((i = -4) AND (j /= 0))											OR
							((i =  4) AND (j /= 0))											OR
							((j = -4) AND (i /= 0))											OR
							((j =  4) AND (i /= 0))											OR
							((i = -3) AND (j = -3 OR j = -2 OR j =  2 OR j =  3)) OR
							((i = -2) AND (j = -3 OR j =  3)) 							OR
							((i =  2) AND (j = -3 OR j =  3)) 							OR
							((i =  3) AND (j = -3 OR j = -2 OR j =  2 OR j =  3)) then
							window(i,j) <= '0';
						else
							window(i,j) <= NOT(board(conv_integer(window_y)+i)(conv_integer(window_x)+j)(1));
						end if;
					end if;
				end loop;
			end loop;
		end process;
	end generate;
	
	rival_bit: if player = RIVAL generate
		process(window_x, window_y, board)
		begin
			for i in -4 to 4 loop
				for j in -4 to 4 loop
					-- Out of board
					if (conv_integer(window_y)+i < 0) OR (conv_integer(window_y)+i > 13) OR (conv_integer(window_x)+j < 0) OR (conv_integer(window_x)+j > 13) then
						window(i,j) <= '0';
					-- Board squares multiplexing 
					else
						-- Some squares are unreachable, some its output does not care. We set them to FORBIDDEN_BOTH
						if ((i =  0) AND (j  = 0))											OR	-- Center position is known to be available
							((i = -4) AND (j /= 0))											OR
							((i =  4) AND (j /= 0))											OR
							((j = -4) AND (i /= 0))											OR
							((j =  4) AND (i /= 0))											OR
							((i = -3) AND (j = -3 OR j = -2 OR j =  2 OR j =  3)) OR
							((i = -2) AND (j = -3 OR j =  3)) 							OR
							((i =  2) AND (j = -3 OR j =  3)) 							OR
							((i =  3) AND (j = -3 OR j = -2 OR j =  2 OR j =  3)) then
							window(i,j) <= '0';
						else
							window(i,j) <= NOT(board(conv_integer(window_y)+i)(conv_integer(window_x)+j)(0));
						end if;
					end if;
				end loop;
			end loop;
		end process;
	end generate;
end processing_windowArch;