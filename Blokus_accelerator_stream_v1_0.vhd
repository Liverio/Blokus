library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;
library UNISIM;
use UNISIM.vcomponents.all;

entity Blokus_accelerator_stream_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 4;

		-- Parameters of Axi Slave Bus Interface S00_AXIS
		C_S00_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Master Bus Interface M00_AXIS
		C_M00_AXIS_TDATA_WIDTH	: integer	:= 32;
		C_M00_AXIS_START_COUNT	: integer	:= 32
	);
	port (
		-- Users to add ports here
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S00_AXIS
		s00_axis_aclk	: in std_logic;
		s00_axis_aresetn	: in std_logic;
		s00_axis_tready	: out std_logic;
		s00_axis_tdata	: in std_logic_vector(C_S00_AXIS_TDATA_WIDTH-1 downto 0);
		s00_axis_tstrb	: in std_logic_vector((C_S00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s00_axis_tlast	: in std_logic;
		s00_axis_tvalid	: in std_logic;

		-- Ports of Axi Master Bus Interface M00_AXIS
		m00_axis_aclk	: in std_logic;
		m00_axis_aresetn	: in std_logic;
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
		m00_axis_tstrb	: out std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		m00_axis_tlast	: out std_logic;
		m00_axis_tready	: in std_logic
	);
end Blokus_accelerator_stream_v1_0;

architecture arch_imp of Blokus_accelerator_stream_v1_0 is
	-- component declaration
	component Blokus_accelerator_stream_v1_0_S00_AXI is
		generic (
            C_S_AXI_DATA_WIDTH	: integer	:= 32;
            C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
			-- Evaluation
            acc_hero, acc_rival : in STD_LOGIC_VECTOR(7-1 downto 0);
            acc_done            : in STD_LOGIC;
            game_time           : in STD_LOGIC_VECTOR(64-1 downto 0);
            -- Timer
            playing : out STD_LOGIC;
            S_AXI_ACLK	: in std_logic;
            S_AXI_ARESETN	: in std_logic;
            S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
            S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
            S_AXI_AWVALID	: in std_logic;
            S_AXI_AWREADY	: out std_logic;
            S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
            S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
            S_AXI_WVALID	: in std_logic;
            S_AXI_WREADY	: out std_logic;
            S_AXI_BRESP	: out std_logic_vector(1 downto 0);
            S_AXI_BVALID	: out std_logic;
            S_AXI_BREADY	: in std_logic;
            S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
            S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
            S_AXI_ARVALID	: in std_logic;
            S_AXI_ARREADY	: out std_logic;
            S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
            S_AXI_RRESP	: out std_logic_vector(1 downto 0);
            S_AXI_RVALID	: out std_logic;
            S_AXI_RREADY	: in std_logic
		);
	end component Blokus_accelerator_stream_v1_0_S00_AXI;

	component Blokus_accelerator_stream_v1_0_S00_AXIS is
		generic (
		  C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
            S_AXIS_ACLK	    : in std_logic;
            S_AXIS_ARESETN	: in std_logic;
            S_AXIS_TREADY	: out std_logic;
            S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
            S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
            S_AXIS_TLAST	: in std_logic;
            S_AXIS_TVALID	: in std_logic;
            -- Added ports
            data	 : OUT STD_LOGIC_VECTOR(C_S_AXIS_TDATA_WIDTH-1 downto 0);
            new_data : OUT STD_LOGIC
		);
	end component Blokus_accelerator_stream_v1_0_S00_AXIS;

	component Blokus_accelerator_stream_v1_0_M00_AXIS is
		generic (
            C_M_AXIS_TDATA_WIDTH	: integer	:= 32;
            C_M_START_COUNT	: integer	:= 32
		);
		port (
            M_AXIS_ACLK	: in std_logic;
            M_AXIS_ARESETN	: in std_logic;
            M_AXIS_TVALID	: out std_logic;
            M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
            M_AXIS_TSTRB	: out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
            M_AXIS_TLAST	: out std_logic;
            M_AXIS_TREADY	: in std_logic;
            -- Added ports            
            overlapping_map : in tpAccessibility_map;
            send_map        : in STD_LOGIC
		);
	end component Blokus_accelerator_stream_v1_0_M00_AXIS;
	
	component board_storage
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
              player      : out STD_LOGIC;
			  create_map  : out STD_LOGIC
		);
	end component;
	
	component board_composer
        port (----------------
              ---- INPUTS ----
              ----------------
              -- Board from PS            
              board    : in tpBoard;
              -----------------
              ---- OUTPUTS ----
              -----------------
              -- Board with forbidden squares info
              board_forbiddens : out tpBoard
        );
    end component;
    
    component evaluator
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
              evaluation_done  : out STD_LOGIC;
              send_map         : out STD_LOGIC;
              overlapping_map  : out tpAccessibility_map;
              acc_hero         : out STD_LOGIC_VECTOR(7-1 downto 0);
              acc_rival        : out STD_LOGIC_VECTOR(7-1 downto 0)
        );
    end component;
    
    component counter
        generic (bits: positive);
        port (clk, rst: in STD_LOGIC;
              rst2 : in STD_LOGIC;
              inc : in STD_LOGIC;
              count : out STD_LOGIC_VECTOR(bits-1 downto 0)
        );
    end component;
    
    component clk_wiz_0 
        port (clk_in1  : in STD_LOGIC;
              clk_out1 : out STD_LOGIC
        );
    end component;
   
    -- Board storage
    signal new_data_in: STD_LOGIC;
    signal data_in: STD_LOGIC_VECTOR(32-1 downto 0);
    signal tiles_hero : STD_LOGIC_VECTOR(21-1 downto 0);
    signal tiles_rival: STD_LOGIC_VECTOR(21-1 downto 0);
    signal work_mode: tpWorkMode_accessibilityMap;
    signal player: tpPlayer;
    signal create_map : STD_LOGIC;
    
    -- Board composer
    signal board           : tpBoard;
    signal board_forbiddens: tpBoard;
    
    -- Evaluator
    signal rst: STD_LOGIC;   
    signal evaluation_done: STD_LOGIC;
    signal send_map: STD_LOGIC;
    signal overlapping_map: tpAccessibility_map;
    signal acc_hero : STD_LOGIC_VECTOR(7-1 downto 0);
    signal acc_rival: STD_LOGIC_VECTOR(7-1 downto 0);
    
    -- Time measurement
    signal rst_game_timer: STD_LOGIC;
    signal inc_game_timer: STD_LOGIC;
    signal playing: STD_LOGIC;
    signal game_time: STD_LOGIC_VECTOR(64-1 downto 0);
    type states is (IDLE, GAME_IN_PROGRESS);
    signal currentState, nextState: states;
    
    -- MMCM
    signal clk: STD_LOGIC;        -- DCM clock output (clk @25MHz)    
begin
    -- Instantiation of Axi Bus Interface S00_AXI
    Blokus_accelerator_stream_v1_0_S00_AXI_inst : Blokus_accelerator_stream_v1_0_S00_AXI
        generic map (
            C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
            C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
        )
        port map (
            S_AXI_ACLK	=> s00_axi_aclk,
            S_AXI_ARESETN	=> s00_axi_aresetn,
            S_AXI_AWADDR	=> s00_axi_awaddr,
            S_AXI_AWPROT	=> s00_axi_awprot,
            S_AXI_AWVALID	=> s00_axi_awvalid,
            S_AXI_AWREADY	=> s00_axi_awready,
            S_AXI_WDATA	=> s00_axi_wdata,
            S_AXI_WSTRB	=> s00_axi_wstrb,
            S_AXI_WVALID	=> s00_axi_wvalid,
            S_AXI_WREADY	=> s00_axi_wready,
            S_AXI_BRESP	=> s00_axi_bresp,
            S_AXI_BVALID	=> s00_axi_bvalid,
            S_AXI_BREADY	=> s00_axi_bready,
            S_AXI_ARADDR	=> s00_axi_araddr,
            S_AXI_ARPROT	=> s00_axi_arprot,
            S_AXI_ARVALID	=> s00_axi_arvalid,
            S_AXI_ARREADY	=> s00_axi_arready,
            S_AXI_RDATA	=> s00_axi_rdata,
            S_AXI_RRESP	=> s00_axi_rresp,
            S_AXI_RVALID	=> s00_axi_rvalid,
            S_AXI_RREADY	=> s00_axi_rready,
			-- Added ports
			acc_hero  => acc_hero,
		    acc_rival => acc_rival,
		    acc_done  => evaluation_done,
			game_time => game_time,
			playing   => playing
        );
    
    -- Instantiation of Axi Bus Interface S00_AXIS
    Blokus_accelerator_stream_v1_0_S00_AXIS_inst : Blokus_accelerator_stream_v1_0_S00_AXIS
        generic map (
            C_S_AXIS_TDATA_WIDTH	=> C_S00_AXIS_TDATA_WIDTH
        )
        port map (
            S_AXIS_ACLK	=> s00_axis_aclk,
            S_AXIS_ARESETN	=> s00_axis_aresetn,
            S_AXIS_TREADY	=> s00_axis_tready,
            S_AXIS_TDATA	=> s00_axis_tdata,
            S_AXIS_TSTRB	=> s00_axis_tstrb,
            S_AXIS_TLAST	=> s00_axis_tlast,
            S_AXIS_TVALID	=> s00_axis_tvalid,
            -- Added ports
            data      => data_in,
            new_data  => new_data_in
        );
    
    -- Instantiation of Axi Bus Interface M00_AXIS
    Blokus_accelerator_stream_v1_0_M00_AXIS_inst : Blokus_accelerator_stream_v1_0_M00_AXIS
        generic map (
            C_M_AXIS_TDATA_WIDTH	=> C_M00_AXIS_TDATA_WIDTH,
            C_M_START_COUNT	=> C_M00_AXIS_START_COUNT
        )
        port map (
            M_AXIS_ACLK	=> m00_axis_aclk,
            M_AXIS_ARESETN	=> m00_axis_aresetn,
            M_AXIS_TVALID	=> m00_axis_tvalid,
            M_AXIS_TDATA	=> m00_axis_tdata,
            M_AXIS_TSTRB	=> m00_axis_tstrb,
            M_AXIS_TLAST	=> m00_axis_tlast,
            M_AXIS_TREADY	=> m00_axis_tready,
            -- Added ports
            overlapping_map => overlapping_map,
            send_map        => send_map
        );

	-- Add user logic here
	-- 25 MHz clock for accessibility modules
    clk_wiz_0_I: clk_wiz_0
        port map(-- Clock in port
                 s00_axis_aclk,
                 -- Clock out ports
                 clk);        
   
    rst <= NOT(s00_axi_aresetn);
    
    board_storage_I: board_storage
		port map(---- INPUTS ----
				 s00_axis_aclk, rst,
				 new_data_in,
				 data_in,
				 ---- OUTPUTS ----
				 board,
				 tiles_hero,
				 tiles_rival,
				 work_mode,
				 player,
				 create_map
		);

    board_composer_I: board_composer
        port map(---- INPUTS ----         
                 -- Board input from PS          
                 board,
                 ---- OUTPUTS ----         
                 board_forbiddens
        );        

	evaluator_I: evaluator
        port map(---- INPUTS ----            
                 s00_axi_aclk,
                 clk, rst,
                 -- Info from PS
                 board,
                 board_forbiddens,
                 tiles_hero, tiles_rival,
                 create_map,
                 work_mode,
                 player,
                 ---- OUTPUTS ----
                 -- Accessibility output
                 evaluation_done,
                 send_map,
                 overlapping_map,                
                 acc_hero, acc_rival
        );
    
    -- Time measurement
    game_timer: counter generic map(64)
        port map(s00_axi_aclk, rst, rst_game_timer, inc_game_timer, game_time);
    
    -- Timer FSM
    timer_FSM: process(currentState, playing) is
    begin
        -- Defaults                
        rst_game_timer <= '0';
        inc_game_timer <= '0';
        nextState <= currentState;
              
        case currentState is
            when IDLE =>
                if playing = '1' then
                    rst_game_timer <= '1';
                    nextState <= GAME_IN_PROGRESS;
                end if;
            when GAME_IN_PROGRESS =>
                inc_game_timer <= '1';
                if playing = '0' then                    
                    nextState <= IDLE;
                end if;
        end case;
    end process;
    
    state: process (s00_axis_aclk)
    begin              
        if s00_axis_aclk'EVENT and s00_axis_aclk = '1' then
            if rst = '1' then
                currentState <= IDLE;
            else
                currentState <= nextState;
            end if;
        end if;
    end process state;
	-- User logic ends
end arch_imp;
