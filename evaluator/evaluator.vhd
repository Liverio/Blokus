library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity evaluator is
    port (----------------
          ---- INPUTS ----
          ----------------            
          clk100   : in STD_LOGIC;
		  clk, rst : in STD_LOGIC;
          -- Info from board composer
          board            : in tpBoard;
          board_forbiddens : in tpBoard;
          tiles_hero  : in STD_LOGIC_VECTOR(21-1 downto 0);
          tiles_rival : in STD_LOGIC_VECTOR(21-1 downto 0);
          -- Create a new map
          create_map : in STD_LOGIC;
          work_mode  : in tpWorkMode_accessibilityMap;
          player     : in tpPlayer;
          -----------------
          ---- OUTPUTS ----
          -----------------
          -- Accessibility output
          evaluation_done : out STD_LOGIC;
          send_map        : out STD_LOGIC;
          overlapping_map : out tpAccessibility_map;
          acc_hero        : out STD_LOGIC_VECTOR(7-1 downto 0);
          acc_rival       : out STD_LOGIC_VECTOR(7-1 downto 0)
    );
end evaluator;

architecture evaluator_arch of evaluator is
    component vertices_map
        generic (player: tpPlayer := HERO);
        port (----------------
                ---- INPUTS ----
                ----------------
                board         : in tpBoard;
                board_color    : in tpBoard;
                -----------------
                ---- OUTPUTS ----
                -----------------
                vertices_map : out tpVertices_map;    -- 13*13 = 169 bits
                vertices_type_map : out tpVertices_type_map    -- 13*13*2 = 338 bits
        );
    end component;
    
    component accessibility_map
        generic(player: tpPlayer := HERO;
                num_evaluators: positive := 1);
        port(----------------
             ---- INPUTS ----
             ----------------            
             clk, rst    : in STD_LOGIC;
             -- Info from board module to carry out vertex selection
             vertices_map         : in tpVertices_map;
             vertices_type_map    : in tpVertices_type_map;
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
             map_created         : out STD_LOGIC;                
             accessibility_count : out STD_LOGIC_VECTOR(7-1 downto 0);
             overlapping_map_out : out tpAccessibility_map
        );
    end component;
    
	-- Latch for create_map signal, that is asserted one cycle at 100MHz. Accessibility modules and FSM work at 25MHz.
	signal create_map_latch: STD_LOGIC;
    
	-- Vertices maps
    signal vertices_map_hero : tpVertices_map;
    signal vertices_map_rival: tpVertices_map;
    signal vertices_type_map_hero : tpVertices_type_map;    
    signal vertices_type_map_rival: tpVertices_type_map;
    
    -- Accessibility maps
    signal evaluate: STD_LOGIC;
    signal overlapping_map_hero : tpAccessibility_map;
    signal overlapping_map_rival: tpAccessibility_map;
    signal map_created_hero: STD_LOGIC;
    signal map_created_rival: STD_LOGIC;
    
    -- Evaluator FSM
	signal clear_create_map: STD_LOGIC;
    signal no_vertex: STD_LOGIC;
    type state is (IDLE, EVALUATING, WAIT_RIVAL, WAIT_HERO);
    signal currentState, nextState : state;

begin
    vertices_map_I_hero: vertices_map generic map(HERO)
        port map(---- INPUTS ----
                 board_forbiddens,
                 board,
                 ---- OUTPUTS ----
                 vertices_map_hero,
                 vertices_type_map_hero
        );
    
    vertices_map_I_rival: vertices_map generic map(RIVAL)
        port map(---- INPUTS ----
                 board_forbiddens,
                 board,
                 ---- OUTPUTS ----
                 vertices_map_rival,
                 vertices_type_map_rival
        );
        
    accessibility_map_I_hero: accessibility_map generic map(HERO, 2)            
        port map(---- INPUTS ----
                 clk, rst,
                 -- Info from board module to carry out vertex selection
                 vertices_map_hero, vertices_type_map_hero,
                 -- Info from board module to initialize map with forbidden_rival positions
                 board_forbiddens,
                 -- Info from board module to build the accessibility map
                 tiles_hero,
                 -- Create a new map
                 evaluate,
                 ---- OUTPUTS ----                        
                 -- Accessibility output
                 map_created_hero, acc_hero,
                 -- Info for overlapping_maps module
                 overlapping_map_hero
        );
            
    accessibility_map_I_rival: accessibility_map generic map(RIVAL, 2)
        port map(---- INPUTS ----
                 clk, rst,
                 -- Info from board module to carry out vertex selection
                 vertices_map_rival, vertices_type_map_rival,
                 -- Info from board module to initialize map with forbidden_rival positions
                 board_forbiddens,
                 -- Info from board module to build the accessibility map
                 tiles_rival,
                 -- Create a new map
                 evaluate,
                 ---- OUTPUTS ----
                 -- Accessibility output
                 map_created_rival, acc_rival,
                 -- Info for overlapping_maps module
                 overlapping_map_rival
        );
	
	-- Reg to store create_map until the Evaluator FSM (@25MHz) actually catchs it
	process(clk100)
	begin			  
	   if rising_edge(clk100) then
           if rst = '1' OR clear_create_map = '1' then
		      create_map_latch <= '0';
		   elsif create_map = '1' then
			  create_map_latch <= '1';
		   end if;
	   end if;
	end process;

    -- Evaluator FSM
    evaluator_FSM: process(currentState, map_created_hero, map_created_rival)
    begin
		clear_create_map <= '0';
		evaluation_done <= '0';
		evaluate <= '0';
		nextState <= currentState;
			
		case currentState is
            when IDLE =>
                -- Assert in this state to be visible long enough to the PS 
                evaluation_done <= '1';
				if create_map_latch = '1' then
				    evaluate <= '1';
                    nextState <= EVALUATING;
                end if;
				
			when EVALUATING =>
                clear_create_map <= '1';
				if map_created_hero = '1' AND map_created_rival = '1' then						
				    evaluation_done <= '1';
					nextState <= IDLE;
			    elsif map_created_hero = '1' then
                    nextState <= WAIT_RIVAL;
                elsif map_created_rival = '1' then
                    nextState <= WAIT_HERO;
				end if;
            
            when WAIT_RIVAL =>
                if map_created_rival = '1' then                        
                    evaluation_done <= '1';
                    nextState <= IDLE;
                end if;
            
            when WAIT_HERO =>
                if map_created_hero = '1' then                        
                    evaluation_done <= '1';
                    nextState <= IDLE;
                end if;
		end case;
    end process evaluator_FSM;
		
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
	
	overlapping_map  <= overlapping_map_rival when player = HERO else overlapping_map_hero;
	send_map <= '1' when (work_mode = OVERLAPPING_MODE) AND
                         ((player = HERO AND map_created_rival = '1') OR (player = RIVAL AND map_created_hero = '1')) else '0';
end evaluator_arch;
