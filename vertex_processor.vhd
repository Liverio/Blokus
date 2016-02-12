library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity vertex_processor is
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
end vertex_processor;

architecture vertex_processorArch of vertex_processor is
	component vertex_0
		port (window: in tpProcessingWindow;
				a2, b2: OUT STD_LOGIC;
				a3, b3, c3, d3, e3: OUT STD_LOGIC;
				a4, b4, c4, d4, e4, f4, g4, h4: OUT STD_LOGIC;
				a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: OUT STD_LOGIC);
	end component;
	
	component vertex_1
		port (window: in tpProcessingWindow;
				a2, b2: OUT STD_LOGIC;
				a3, b3, c3, d3, e3: OUT STD_LOGIC;
				a4, b4, c4, d4, e4, f4, g4, h4: OUT STD_LOGIC;
				a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: OUT STD_LOGIC);
	end component;
	
	component vertex_2
		port (window: in tpProcessingWindow;
				a2, b2: OUT STD_LOGIC;
				a3, b3, c3, d3, e3: OUT STD_LOGIC;
				a4, b4, c4, d4, e4, f4, g4, h4: OUT STD_LOGIC;
				a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: OUT STD_LOGIC);
	end component;
	
	component vertex_3
		port (window: in tpProcessingWindow;
				a2, b2: OUT STD_LOGIC;
				a3, b3, c3, d3, e3: OUT STD_LOGIC;
				a4, b4, c4, d4, e4, f4, g4, h4: OUT STD_LOGIC;
				a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: OUT STD_LOGIC);
	end component;
	
	component vertex_squares_mux is
		port (----------------
				---- INPUTS ----
				----------------
				vertex_type: IN STD_LOGIC_VECTOR(2-1 downto 0);
				a2_in, b2_in,
				a3_in, b3_in, c3_in, d3_in, e3_in,
				a4_in, b4_in, c4_in, d4_in, e4_in, f4_in, g4_in, h4_in,
				a5_in, b5_in, c5_in, d5_in, e5_in, f5_in, g5_in, h5_in, i5_in, j5_in, k5_in, l5_in, m5_in: IN STD_LOGIC_VECTOR(4-1 downto 0);
				-----------------
				---- OUTPUTS ----
				-----------------
				a2, b2, a3, b3, c3, d3, e3, a4, b4, c4, d4, e4, f4, g4, h4, a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: OUT STD_LOGIC);
	end component;
	
	component distance_2
		port (----------------
				---- INPUTS ----
				----------------
				-- Involved tiles (tiles which can reach distance-2 squares)
				B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U: IN STD_LOGIC;
				-- Involved squares
				a2, b2: IN STD_LOGIC;
				a3, b3, c3, d3, e3: IN STD_LOGIC;
				a4, b4, c4, d4, e4, f4, g4, h4: IN STD_LOGIC;
				a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: IN STD_LOGIC;
				-----------------
				---- OUTPUTS ----
				-----------------
				acc_a2, acc_b2: OUT STD_LOGIC);
	end component;
	
	component distance_3
		port (----------------
				---- INPUTS ----
				----------------
				-- Involved tiles (tiles which can reach distance-3 squares)
				C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U: IN STD_LOGIC;
				-- Involved squares
				a2, b2: IN STD_LOGIC;
				a3, b3, c3, d3, e3: IN STD_LOGIC;
				a4, b4, c4, d4, e4, f4, g4, h4: IN STD_LOGIC;
				a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: IN STD_LOGIC;
				-----------------
				---- OUTPUTS ----
				-----------------
				acc_a3, acc_b3, acc_c3, acc_d3, acc_e3: OUT STD_LOGIC);
	end component;
	
	component distance_4
		port (----------------
				---- INPUTS ----
				----------------
				-- Involved tiles (tiles which can reach distance-4 squares)
				E, F, I, J, K, L, M, N, O, P, Q, R, S, T: IN STD_LOGIC;
				-- Involved squares
				a2, b2: IN STD_LOGIC;
				a3, b3, c3, d3, e3: IN STD_LOGIC;
				a4, b4, c4, d4, e4, f4, g4, h4: IN STD_LOGIC;
				a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: IN STD_LOGIC;
				-----------------
				---- OUTPUTS ----
				-----------------
				acc_a4, acc_b4, acc_c4, acc_d4, acc_e4, acc_f4, acc_g4, acc_h4: OUT STD_LOGIC);
	end component;
	
	component distance_5
		port (----------------
				---- INPUTS ----
				----------------
				-- Involved tiles (tiles which can reach distance-5 squares)
				J, K, L, N, Q, R, S: IN STD_LOGIC;
				-- Involved squares
				a2, b2: IN STD_LOGIC;
				a3, b3, c3, d3, e3: IN STD_LOGIC;
				a4, b4, c4, d4, e4, f4, g4, h4: IN STD_LOGIC;
				a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: IN STD_LOGIC;
				-----------------
				---- OUTPUTS ----
				-----------------
				acc_a5, acc_b5, acc_c5, acc_d5, acc_e5, acc_f5, acc_g5, acc_h5, acc_i5, acc_j5, acc_k5, acc_l5, acc_m5: OUT STD_LOGIC);
	end component;
	
	signal A, B, C, D, E, F, G, H, I, J, K,
			 L, M, N, O, P, Q, R, S, T, U: STD_LOGIC;
	signal a2, b2, a3, b3, c3, d3, e3, a4, b4, c4, d4, e4, f4, g4, h4, a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5: STD_LOGIC;	
	signal a2_out, b2_out,
			 a3_out, b3_out, c3_out, d3_out, e3_out,
			 a4_out, b4_out, c4_out, d4_out, e4_out, f4_out, g4_out, h4_out,
			 a5_out, b5_out, c5_out, d5_out, e5_out, f5_out, g5_out, h5_out, i5_out, j5_out, k5_out, l5_out, m5_out: STD_LOGIC_VECTOR(4-1 downto 0);
	signal acc_a2_int, acc_b2_int: STD_LOGIC;
begin
		vertex_0_squares: vertex_0
					port map(window, 
								a2_out(0), b2_out(0), 
								a3_out(0), b3_out(0), c3_out(0), d3_out(0), e3_out(0),
								a4_out(0), b4_out(0), c4_out(0), d4_out(0), e4_out(0), f4_out(0), g4_out(0), h4_out(0),
								a5_out(0), b5_out(0), c5_out(0), d5_out(0), e5_out(0), f5_out(0), g5_out(0), h5_out(0), i5_out(0), j5_out(0), k5_out(0), l5_out(0), m5_out(0));
		
		vertex_1_squares: vertex_1
					port map(window, 
								a2_out(1), b2_out(1), 
								a3_out(1), b3_out(1), c3_out(1), d3_out(1), e3_out(1),
								a4_out(1), b4_out(1), c4_out(1), d4_out(1), e4_out(1), f4_out(1), g4_out(1), h4_out(1),
								a5_out(1), b5_out(1), c5_out(1), d5_out(1), e5_out(1), f5_out(1), g5_out(1), h5_out(1), i5_out(1), j5_out(1), k5_out(1), l5_out(1), m5_out(1));
		
		vertex_2_squares: vertex_2
					port map(window, 
								a2_out(2), b2_out(2), 
								a3_out(2), b3_out(2), c3_out(2), d3_out(2), e3_out(2),
								a4_out(2), b4_out(2), c4_out(2), d4_out(2), e4_out(2), f4_out(2), g4_out(2), h4_out(2),
								a5_out(2), b5_out(2), c5_out(2), d5_out(2), e5_out(2), f5_out(2), g5_out(2), h5_out(2), i5_out(2), j5_out(2), k5_out(2), l5_out(2), m5_out(2));
		
		vertex_3_squares: vertex_3
					port map(window, 
								a2_out(3), b2_out(3), 
								a3_out(3), b3_out(3), c3_out(3), d3_out(3), e3_out(3),
								a4_out(3), b4_out(3), c4_out(3), d4_out(3), e4_out(3), f4_out(3), g4_out(3), h4_out(3),
								a5_out(3), b5_out(3), c5_out(3), d5_out(3), e5_out(3), f5_out(3), g5_out(3), h5_out(3), i5_out(3), j5_out(3), k5_out(3), l5_out(3), m5_out(3));
				
		-- Vertex info output mux
		vertex_squares_mux_I: vertex_squares_mux
			port map(---- INPUTS ----
						vertex_type,
						a2_out, b2_out,
						a3_out, b3_out, c3_out, d3_out, e3_out,
						a4_out, b4_out, c4_out, d4_out, e4_out, f4_out, g4_out, h4_out,
						a5_out, b5_out, c5_out, d5_out, e5_out, f5_out, g5_out, h5_out, i5_out, j5_out, k5_out, l5_out, m5_out,
						---- OUTPUTS ----
						a2, b2, a3, b3, c3, d3, e3, a4, b4, c4, d4, e4, f4, g4, h4, a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5);
		
		-- For clearer code
		A <= tiles_available(conv_integer(tile_a));
		B <= tiles_available(conv_integer(tile_b));
		C <= tiles_available(conv_integer(tile_c));
		D <= tiles_available(conv_integer(tile_d));
		E <= tiles_available(conv_integer(tile_e));
		F <= tiles_available(conv_integer(tile_f));
		G <= tiles_available(conv_integer(tile_g));
		H <= tiles_available(conv_integer(tile_h));
		I <= tiles_available(conv_integer(tile_i));
		J <= tiles_available(conv_integer(tile_j));
		K <= tiles_available(conv_integer(tile_k));
		L <= tiles_available(conv_integer(tile_l));
		M <= tiles_available(conv_integer(tile_m));
		N <= tiles_available(conv_integer(tile_n));
		O <= tiles_available(conv_integer(tile_o));
		P <= tiles_available(conv_integer(tile_p));
		Q <= tiles_available(conv_integer(tile_q));
		R <= tiles_available(conv_integer(tile_r));
		S <= tiles_available(conv_integer(tile_s));
		T <= tiles_available(conv_integer(tile_t));
		U <= tiles_available(conv_integer(tile_u));
		
		distance_2_I: distance_2
			port map(---- INPUTS ----
						-- Involved tiles
						B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U,
						-- Involved squares
						a2, b2,
						a3, b3, c3, d3, e3,
						a4, b4, c4, d4, e4, f4, g4, h4,
						a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5,
						---- OUTPUTS ----
						acc_a2_int, acc_b2_int);
		acc_a2 <= acc_a2_int;
		acc_b2 <= acc_b2_int;

		distance_3_I: distance_3
			port map(---- INPUTS ----
						-- Involved tiles
						C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U,
						-- Involved squares
						a2, b2,
						a3, b3, c3, d3, e3,
						a4, b4, c4, d4, e4, f4, g4, h4,
						a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5,
						---- OUTPUTS ----
						acc_a3, acc_b3, acc_c3, acc_d3, acc_e3);
		
		distance_4_I: distance_4
			port map(---- INPUTS ----
						-- Involved tiles
						E, F, I, J, K, L, M, N, O, P, Q, R, S, T,
						-- Involved squares
						a2, b2,
						a3, b3, c3, d3, e3,
						a4, b4, c4, d4, e4, f4, g4, h4,
						a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5,
						---- OUTPUTS ----
						acc_a4, acc_b4, acc_c4, acc_d4, acc_e4, acc_f4, acc_g4, acc_h4);
		
		distance_5_I: distance_5
			port map(---- INPUTS ----
						-- Involved tiles
						J, K, L, N, Q, R, S,
						-- Involved squares
						a2, b2,
						a3, b3, c3, d3, e3,
						a4, b4, c4, d4, e4, f4, g4, h4,
						a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5,
						---- OUTPUTS ----
						acc_a5, acc_b5, acc_c5, acc_d5, acc_e5, acc_f5, acc_g5, acc_h5, acc_i5, acc_j5, acc_k5, acc_l5, acc_m5);
		
		acc_a1 <= acc_a2_int OR acc_b2_int OR A;
end vertex_processorArch;