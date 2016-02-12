library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity accessibility_map is
	generic (player: tpPlayer := HERO;
	         num_evaluators: positive := 1);
	port (----------------
		  ---- INPUTS ----
		  ----------------			
          clk, rst	: in STD_LOGIC;
          -- Info from board module to carry out vertex selection
          vertices_map 		: in tpVertices_map;
          vertices_type_map	: in tpVertices_type_map;
          -- Info from board module
          board : in tpBoard;
          -- Info from board module to build the accessibility map			
          tiles_available : in STD_LOGIC_VECTOR(21-1 downto 0);
          -- Create a new map
          create_map : in STD_LOGIC;
          -----------------
          ---- OUTPUTS ----
          -----------------
          -- Accessibility output
          map_created 		  : out STD_LOGIC;				
          accessibility_count : out STD_LOGIC_VECTOR(7-1 downto 0);
          overlapping_map_out : out tpAccessibility_map
    );
end accessibility_map;

architecture accessibility_mapArch of accessibility_map is
	component evaluation_unit
		generic (player	  : tpPlayer := HERO;
				 unit_num : integer  := 0);
		port (----------------
			  ---- INPUTS ----
			  ----------------			
			  clk, rst	: in STD_LOGIC;
			  -- Info from board module to carry out vertex selection
			  vertices_map 		: in tpVertices_map;
			  vertices_type_map	: in tpVertices_type_map;
			  -- Info from board module to initialize map with forbidden_rival positions
			  board           : in tpBoard;			
			  tiles_available : in STD_LOGIC_VECTOR(21-1 downto 0);
			  -- Map loads
			  create_map : in STD_LOGIC;
			  update_map : in STD_LOGIC;
			  -----------------
			  ---- OUTPUTS ----
			  -----------------					
			  -- Current vertex
			  x, y      : out STD_LOGIC_VECTOR(4-1 downto 0);
			  no_vertex : out STD_LOGIC;			
			  -- Map
			  accessibility_map : out tpAccessibility_map
        );
    end component;		
	
	component treeCounter
		port (input:  in  tpAccessibility_map;
			  output: out STD_LOGIC_VECTOR(7-1 downto 0));
	end component;
		
	-- Joined accessibility map
	signal accessibility_map_int: tpAccessibility_map;
	
	-- Evaluation units
	signal x_1, y_1, x_2, y_2: STD_LOGIC_VECTOR(4-1 downto 0);
	signal no_vertex_1, no_vertex_2: STD_LOGIC;	
	signal map_1, map_2: tpAccessibility_map;
	
	-- Overlapping map	
	signal forbiddens_map: tpAccessibility_map;
	
	-- Accessibility FSM
	signal update_map: STD_LOGIC;
	signal no_vertex: STD_LOGIC;
	type state is (IDLE, UPDATING_MAP);
	signal currentState, nextState : state;
begin
    evaluation_unit_1: evaluation_unit generic map(player, 0)
        port map(---- INPUTS ----			
				 clk, rst,
				 -- Info from board module to carry out vertex selection
				 vertices_map, vertices_type_map,
				 -- Info from board module to initialize map with forbidden_rival positions
				 board, tiles_available,
				 -- Map loads
				 create_map,
				 update_map,
				 ---- OUTPUTS ----
				 -- Current vertex
				 x_1, y_1,
				 no_vertex_1,
				 -- Map
				 map_1);
    ev_2: if num_evaluators = 2 generate
        evaluation_unit_2: evaluation_unit generic map(player, 1)
            port map(---- INPUTS ----			
				     clk, rst,
				     -- Info from board module to carry out vertex selection
				     vertices_map, vertices_type_map,
				     -- Info from board module to initialize map with forbidden_rival positions
				     board, tiles_available,
				     -- Map loads
				     create_map,
				     update_map,
				     ---- OUTPUTS ----
				     -- Current vertex
				     x_2, y_2,
				     no_vertex_2,
				     -- Map
				     map_2);
    end generate;				     	
		
    -- Count
	accessibilityCounter: treeCounter
        port map(---- INPUTS ----
				 accessibility_map_int,
				 ---- OUTPUTS ----
                 accessibility_count);
			
    one_eval_0: if num_evaluators = 1 generate
        no_vertex <= '1' when no_vertex_1 = '1' else
                     '0';
    end generate;
    two_evals_0: if num_evaluators = 2 generate
        no_vertex <= '1' when (no_vertex_1 = '1' AND no_vertex_2 = '1') OR
                              (y_1 > y_2) 						 		OR
                              (y_1 = y_2 AND x_1 > x_2) else
				     '0';
    end generate;
			
    -------------------------
    ---- OVERLAPPING MAP ----
    -------------------------
    ------- Accessibility map new input while updating with forbidden positions -------    
    forbiddens_y: for i in 0 to 14-1 generate
        forbiddens_x: for j in 0 to 14-1 generate
            hero_forbiddens: if player = HERO generate
                forbiddens_map(i,j) <= '1' when board(i)(j) = FORBIDDEN_HERO else '0';
            end generate;
            rival_forbiddens: if player = RIVAL generate
                forbiddens_map(i,j) <= '1' when board(i)(j) = FORBIDDEN_RIVAL else '0';
            end generate;
        end generate;
    end generate;
		
		
    -- Accessibility map building FSM
    accessibility_map_FSM: process(currentState,    -- DEFAULT
                                   create_map,      -- IDLE
                                   no_vertex)       -- MAP_UPDATE
    begin
		update_map <= '0';
		map_created <= '0';
		nextState <= currentState;
			
		case currentState is
            when IDLE =>
				if create_map = '1' then
                    nextState <= UPDATING_MAP;				
				end if;
				
			when UPDATING_MAP =>
				if no_vertex = '1' then						
				    map_created <= '1';
					nextState <= IDLE;
				else
					update_map <= '1';
				end if;
		end case;
    end process accessibility_map_FSM;
		
	states: process(clk)
	begin			  
	   if clk'event AND clk = '1' then
           if rst = '1' then
		      currentState <= IDLE;
		   else
			  currentState <= nextState;
		   end if;
	   end if;
	end process;

    -- OUTPUTS
	new_input_y: for i in 0 to 14-1 generate
        new_input_x: for j in 0 to 14-1 generate
            one_eval_1: if num_evaluators = 1 generate
                accessibility_map_int(i,j) <= map_1(i,j);
                overlapping_map_out(i,j) <= map_1(i,j) OR forbiddens_map(i,j);
            end generate;
            two_evals_1: if num_evaluators = 2 generate
                accessibility_map_int(i,j) <= map_1(i,j) OR map_2(i,j);
                overlapping_map_out(i,j) <= map_1(i,j) OR map_2(i,j) OR forbiddens_map(i,j);
            end generate;
	   end generate;
	end generate;
end accessibility_mapArch;