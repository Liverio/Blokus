library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity evaluation_unit is
	generic (player: tpPlayer := HERO;
			 unit_num : integer := 0);
	port (----------------
          ---- INPUTS ----
		  ----------------			
		  clk, rst	: in STD_LOGIC;
		  -- Info from board module to carry out vertex selection
		  vertices_map 		: in tpVertices_map;
		  vertices_type_map	: in tpVertices_type_map;
		  -- Info from board module to initialize map with forbidden_rival positions
		  board : in tpBoard;			
		  tiles_available : in STD_LOGIC_VECTOR(21-1 downto 0);
		  -- Map loads
		  create_map : in STD_LOGIC;
		  update_map : in STD_LOGIC;
		  -----------------
		  ---- OUTPUTS ----
		  -----------------					
		  -- Current vertex
		  x, y: out STD_LOGIC_VECTOR(4-1 downto 0);
		  no_vertex : out STD_LOGIC;			
		  -- Map
		  accessibility_map : out tpAccessibility_map
	);
end evaluation_unit;

architecture evaluation_unitArch of evaluation_unit is
    component status_accessibility
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
    end component;
	
	component vertex_selector
		generic (direction : integer := 0);
		port (----------------
              ---- INPUTS ----
			  ----------------
			  last_vertex	: in STD_LOGIC_VECTOR(8-1 downto 0);	-- 7..row..4 3..col..0
			  -- Current player vertices map
			  vertices_map : in tpVertices_map;
			  -----------------
			  ---- OUTPUTS ----
			  -----------------
			  next_vertex : out STD_LOGIC_VECTOR(8-1 downto 0);
			  no_vertex	: out STD_LOGIC
        );
	end component;
	
	component window_center
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
	end component;
	
	component processing_window
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
	end component;
	
	component vertex_processor
		port (----------------
			  ---- INPUTS ----
			  ----------------
			  vertex_type: in STD_LOGIC_VECTOR(2-1 downto 0);
			  window: in tpProcessingWindow;
			  tiles_available : in STD_LOGIC_VECTOR(21-1 downto 0);
			  -----------------
			  ---- OUTPUTS ----
			  -----------------			
			  acc_a1,
			  acc_a2, acc_b2,
			  acc_a3, acc_b3, acc_c3, acc_d3, acc_e3,
			  acc_a4, acc_b4, acc_c4, acc_d4, acc_e4, acc_f4, acc_g4, acc_h4,
			  acc_a5, acc_b5, acc_c5, acc_d5, acc_e5, acc_f5, acc_g5, acc_h5, acc_i5, acc_j5, acc_k5, acc_l5, acc_m5: OUT STD_LOGIC);
	end component;
	
	component absolute_positions
		port (----------------
			  ---- INPUTS ----
			  ----------------
			  vertex_x, vertex_y: in STD_LOGIC_VECTOR(4-1 downto 0);
			  vertex_type: in STD_LOGIC_VECTOR(2-1 downto 0);
			  -----------------
			  ---- OUTPUTS ----
			  ----------------			
			  pos_a1: OUT STD_LOGIC_VECTOR(8-1 downto 0);
			  pos_a2, pos_b2: OUT STD_LOGIC_VECTOR(8-1 downto 0);
			  pos_a3, pos_b3, pos_c3, pos_d3, pos_e3: OUT STD_LOGIC_VECTOR(8-1 downto 0);
			  pos_a4, pos_b4, pos_c4, pos_d4, pos_e4, pos_f4, pos_g4, pos_h4: OUT STD_LOGIC_VECTOR(8-1 downto 0);
			  pos_a5, pos_b5, pos_c5, pos_d5, pos_e5, pos_f5, pos_g5, pos_h5, pos_i5, pos_j5, pos_k5, pos_l5, pos_m5: OUT STD_LOGIC_VECTOR(8-1 downto 0));
	end component;	
	
	component accessibility_map_reg
		port (----------------
			  ---- INPUTS ----
			  ----------------
			  clk, rst : in STD_LOGIC;
			  ld	    : in STD_LOGIC;
			  clear  : in STD_LOGIC;
			  map_in : in tpAccessibility_map;
			  -----------------
			  ---- OUTPUTS ----
			  -----------------
			  map_out : out tpAccessibility_map
		);
	end component;
	
	-- Vertex selector
	signal vertex: STD_LOGIC_VECTOR(8-1 downto 0);	-- 7..row..4 3..col..0	
	
	-- Window center
	signal vertex_type: STD_LOGIC_VECTOR(2-1 downto 0);
	signal window_center_int: STD_LOGIC_VECTOR(8-1 downto 0);	-- 7..row..4 3..col..0
	
	-- Window
	signal window: tpProcessingWindow;
	
	-- Accessibility vertices status
	signal update_vertex: STD_LOGIC;
	signal last_vertex: STD_LOGIC_VECTOR(8-1 downto 0);	-- 7..row..4 3..col..0
	
	-- Accessibility maps registers	
	signal accessibility_map_out: tpAccessibility_map;	
	
	-- New input composing for an update
	signal accessibility_map_new: tpAccessibility_map;
	
	-- Accessibility analysis
	signal acc_a1,
		   acc_a2, acc_b2,
		   acc_a3, acc_b3, acc_c3, acc_d3, acc_e3,
		   acc_a4, acc_b4, acc_c4, acc_d4, acc_e4, acc_f4, acc_g4, acc_h4,
		   acc_a5, acc_b5, acc_c5, acc_d5, acc_e5, acc_f5, acc_g5, acc_h5, acc_i5, acc_j5, acc_k5, acc_l5, acc_m5: STD_LOGIC;
	signal pos_a1,
		   pos_a2, pos_b2,
		   pos_a3, pos_b3, pos_c3, pos_d3, pos_e3,
		   pos_a4, pos_b4, pos_c4, pos_d4, pos_e4, pos_f4, pos_g4, pos_h4,
		   pos_a5, pos_b5, pos_c5, pos_d5, pos_e5, pos_f5, pos_g5, pos_h5, pos_i5, pos_j5, pos_k5, pos_l5, pos_m5: STD_LOGIC_VECTOR(8-1 downto 0);
begin	
    status_accessibility_I: status_accessibility
        port map(---- INPUTS ----
                 clk, rst,
                 update_map, vertex, create_map,
				 ---- OUTPUTS ----
				 last_vertex
        );
			
    vertex_selector_I: vertex_selector generic map(unit_num)
        port map(---- INPUTS ----
                 last_vertex, vertices_map,
				 ---- OUTPUTS ----
				 vertex, no_vertex
        );
		
    -- OUTPUT
    x <= vertex(3 downto 0);
    y <= vertex(7 downto 4);
	
    vertex_type <= vertices_type_map(conv_integer(vertex(7 downto 4)), conv_integer(vertex(3 downto 0)));
		
    window_center_I: window_center
        port map(---- INPUTS ----
                 vertex_type	=> vertex_type,
				 vertex_row 	=> vertex(7 downto 4),
				 vertex_col 	=> vertex(3 downto 0),
				 ---- OUTPUTS ----
				 window_center_out => window_center_int);
		
    window_I: processing_window generic map(player)
        port map(---- INPUTS ----
				 -- Current board
				 board	=> board,
				 -- Vertex coordinates (processing window center) and vertex type
				 window_x => window_center_int(7 downto 4),
				 window_y => window_center_int(3 downto 0),
				 ---- OUTPUTS ----
				 -- Processing window
				 window => window);
		
	vertex_processor_I: vertex_processor
        port map(---- INPUTS ----
                 vertex_type,
				 window,
				 tiles_available,
				 ---- OUTPUTS ----
				 acc_a1,
				 acc_a2, acc_b2,
				 acc_a3, acc_b3, acc_c3, acc_d3, acc_e3,
				 acc_a4, acc_b4, acc_c4, acc_d4, acc_e4, acc_f4, acc_g4, acc_h4,
				 acc_a5, acc_b5, acc_c5, acc_d5, acc_e5, acc_f5, acc_g5, acc_h5, acc_i5, acc_j5, acc_k5, acc_l5, acc_m5
        );
		
    absolute_positions_I: absolute_positions
        port map(---- INPUTS ----
				 window_center_int(7 downto 4), window_center_int(3 downto 0),
				 vertex_type,
				 ---- OUTPUTS ----			
				 pos_a1,
				 pos_a2, pos_b2,
				 pos_a3, pos_b3, pos_c3, pos_d3, pos_e3,
				 pos_a4, pos_b4, pos_c4, pos_d4, pos_e4, pos_f4, pos_g4, pos_h4,
				 pos_a5, pos_b5, pos_c5, pos_d5, pos_e5, pos_f5, pos_g5, pos_h5, pos_i5, pos_j5, pos_k5, pos_l5, pos_m5
        );
		
    -----------------------
	-- ACCESSIBILITY MAP --
	-----------------------
	accessibility_map_reg_I: accessibility_map_reg
          port map(clk, rst, update_map, create_map, accessibility_map_new, accessibility_map_out);		
		
    ------- Accessibility map new input while updating with vertex area analysis -------
    new_input_y: for i in 0 to 14-1 generate
        new_input_x: for j in 0 to 14-1 generate
            accessibility_map_new(i,j) <= '1' when (acc_a1 = '1' AND conv_integer(pos_a1(3 downto 0)) = i AND conv_integer(pos_a1(7 downto 4)) = j) OR
												   (acc_a2 = '1' AND conv_integer(pos_a2(3 downto 0)) = i AND conv_integer(pos_a2(7 downto 4)) = j) OR
												   (acc_b2 = '1' AND conv_integer(pos_b2(3 downto 0)) = i AND conv_integer(pos_b2(7 downto 4)) = j) OR
												   (acc_a3 = '1' AND conv_integer(pos_a3(3 downto 0)) = i AND conv_integer(pos_a3(7 downto 4)) = j) OR
                                                   (acc_b3 = '1' AND conv_integer(pos_b3(3 downto 0)) = i AND conv_integer(pos_b3(7 downto 4)) = j) OR
												   (acc_c3 = '1' AND conv_integer(pos_c3(3 downto 0)) = i AND conv_integer(pos_c3(7 downto 4)) = j) OR
												   (acc_d3 = '1' AND conv_integer(pos_d3(3 downto 0)) = i AND conv_integer(pos_d3(7 downto 4)) = j) OR
												   (acc_e3 = '1' AND conv_integer(pos_e3(3 downto 0)) = i AND conv_integer(pos_e3(7 downto 4)) = j) OR
												   (acc_a4 = '1' AND conv_integer(pos_a4(3 downto 0)) = i AND conv_integer(pos_a4(7 downto 4)) = j) OR
												   (acc_b4 = '1' AND conv_integer(pos_b4(3 downto 0)) = i AND conv_integer(pos_b4(7 downto 4)) = j) OR
												   (acc_c4 = '1' AND conv_integer(pos_c4(3 downto 0)) = i AND conv_integer(pos_c4(7 downto 4)) = j) OR
												   (acc_d4 = '1' AND conv_integer(pos_d4(3 downto 0)) = i AND conv_integer(pos_d4(7 downto 4)) = j) OR
												   (acc_e4 = '1' AND conv_integer(pos_e4(3 downto 0)) = i AND conv_integer(pos_e4(7 downto 4)) = j) OR
												   (acc_f4 = '1' AND conv_integer(pos_f4(3 downto 0)) = i AND conv_integer(pos_f4(7 downto 4)) = j) OR
												   (acc_g4 = '1' AND conv_integer(pos_g4(3 downto 0)) = i AND conv_integer(pos_g4(7 downto 4)) = j) OR
												   (acc_h4 = '1' AND conv_integer(pos_h4(3 downto 0)) = i AND conv_integer(pos_h4(7 downto 4)) = j) OR
												   (acc_a5 = '1' AND conv_integer(pos_a5(3 downto 0)) = i AND conv_integer(pos_a5(7 downto 4)) = j) OR
												   (acc_b5 = '1' AND conv_integer(pos_b5(3 downto 0)) = i AND conv_integer(pos_b5(7 downto 4)) = j) OR
												   (acc_c5 = '1' AND conv_integer(pos_c5(3 downto 0)) = i AND conv_integer(pos_c5(7 downto 4)) = j) OR
												   (acc_d5 = '1' AND conv_integer(pos_d5(3 downto 0)) = i AND conv_integer(pos_d5(7 downto 4)) = j) OR
												   (acc_e5 = '1' AND conv_integer(pos_e5(3 downto 0)) = i AND conv_integer(pos_e5(7 downto 4)) = j) OR
												   (acc_f5 = '1' AND conv_integer(pos_f5(3 downto 0)) = i AND conv_integer(pos_f5(7 downto 4)) = j) OR
												   (acc_g5 = '1' AND conv_integer(pos_g5(3 downto 0)) = i AND conv_integer(pos_g5(7 downto 4)) = j) OR
												   (acc_h5 = '1' AND conv_integer(pos_h5(3 downto 0)) = i AND conv_integer(pos_h5(7 downto 4)) = j) OR
												   (acc_i5 = '1' AND conv_integer(pos_i5(3 downto 0)) = i AND conv_integer(pos_i5(7 downto 4)) = j) OR
												   (acc_j5 = '1' AND conv_integer(pos_j5(3 downto 0)) = i AND conv_integer(pos_j5(7 downto 4)) = j) OR
												   (acc_k5 = '1' AND conv_integer(pos_k5(3 downto 0)) = i AND conv_integer(pos_k5(7 downto 4)) = j) OR
												   (acc_l5 = '1' AND conv_integer(pos_l5(3 downto 0)) = i AND conv_integer(pos_l5(7 downto 4)) = j) OR
												   (acc_m5 = '1' AND conv_integer(pos_m5(3 downto 0)) = i AND conv_integer(pos_m5(7 downto 4)) = j) else 
										  accessibility_map_out(i,j);
        end generate;
    end generate;
	
    -- Map output
	accessibility_map <= accessibility_map_out;
end evaluation_unitArch;