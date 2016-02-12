library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity vertex_selector is
	generic (direction : integer := 0);
	port (----------------
			---- INPUTS ----
			----------------
			last_vertex	  : in STD_LOGIC_VECTOR(8-1 downto 0);	-- 7..row..4 3..col..0
			-- Current player vertices map
			vertices_map : in tpVertices_map;
			-----------------
			---- OUTPUTS ----
			-----------------
			next_vertex : out STD_LOGIC_VECTOR(8-1 downto 0);
			no_vertex	: out STD_LOGIC
	);
end vertex_selector;

architecture vertex_selectorArch of vertex_selector is
	------------
	--- ----> 
	------------
	component vertices_map_masker
		port (----------------
				---- INPUTS ----
				----------------
				vertices_map : in tpVertices_map;
				last_vertex	 : in STD_LOGIC_VECTOR(8-1 downto 0);
				-----------------
				---- OUTPUTS ----
				-----------------
				vertices_map_masked : out tpVertices_map
		);
	end component;
	
	component priority_encoder
		port (----------------
				---- INPUTS ----
				----------------
				vertices_map : in tpVertices_map;
				-----------------
				---- OUTPUTS ----
				-----------------
				row 		 : out STD_LOGIC_VECTOR(4-1 downto 0);
				col 		 : out STD_LOGIC_VECTOR(4-1 downto 0);
				no_vertex : out STD_LOGIC
		);
	end component;
	
	------------
	--- <----
	------------	
	component vertices_map_masker_reversed
		port (----------------
				---- INPUTS ----
				----------------
				vertices_map : in tpVertices_map;
				last_vertex	 : in STD_LOGIC_VECTOR(8-1 downto 0);
				-----------------
				---- OUTPUTS ----
				-----------------
				vertices_map_masked : out tpVertices_map
		);
	end component;
	
	component priority_encoder_reversed
		port (----------------
				---- INPUTS ----
				----------------
				vertices_map : in tpVertices_map;
				-----------------
				---- OUTPUTS ----
				-----------------
				row 		 : out STD_LOGIC_VECTOR(4-1 downto 0);
				col 		 : out STD_LOGIC_VECTOR(4-1 downto 0);
				no_vertex : out STD_LOGIC
		);
	end component;
	
	signal vertices_map_masked: tpVertices_map;
begin	
	right: if direction = 0 generate	
		-- Sets explored vertices to '0'
		vertices_map_masker_I: vertices_map_masker
			port map(---- INPUTS ----
						vertices_map => vertices_map,
						last_vertex	 => last_vertex,
						---- OUTPUTS ----
						vertices_map_masked => vertices_map_masked
			);
					
		-- Select the next vertex in
		priority_encoder_I: priority_encoder
			port map(---- INPUTS ----
						vertices_map => vertices_map_masked,
						---- OUTPUTS ----
						row		 => next_vertex(7 downto 4),
						col		 => next_vertex(3 downto 0),
						no_vertex => no_vertex
			);
	end generate;
	
	left: if direction = 1 generate	
		-- Sets explored vertices to '0'
		vertices_map_masker_reversed_I: vertices_map_masker_reversed
			port map(---- INPUTS ----
						vertices_map => vertices_map,
						last_vertex	 => last_vertex,
						---- OUTPUTS ----
						vertices_map_masked => vertices_map_masked
			);
					
		-- Select the next vertex in
		priority_encoder_reversed_I: priority_encoder_reversed
			port map(---- INPUTS ----
						vertices_map => vertices_map_masked,
						---- OUTPUTS ----
						row		 => next_vertex(7 downto 4),
						col		 => next_vertex(3 downto 0),
						no_vertex => no_vertex
			);
	end generate;
end vertex_selectorArch;