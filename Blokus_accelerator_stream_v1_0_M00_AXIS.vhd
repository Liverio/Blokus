library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.types.ALL;

entity Blokus_accelerator_stream_v1_0_M00_AXIS is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
		C_M_AXIS_TDATA_WIDTH	: integer	:= 32;
		-- Start count is the numeber of clock cycles the master will wait before initiating/issuing any transaction.
		--C_M_START_COUNT	: integer	:= 32
		C_M_START_COUNT	: integer	:= 32
	);
	port (
		-- Users to add ports here
        overlapping_map : in tpAccessibility_map;        
        send_map        : in STD_LOGIC;
		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global ports
		M_AXIS_ACLK	: in std_logic;
		-- 
		M_AXIS_ARESETN	: in std_logic;
		-- Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
		M_AXIS_TVALID	: out std_logic;
		-- TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
		M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
		-- TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
		M_AXIS_TSTRB	: out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
		-- TLAST indicates the boundary of a packet.
		M_AXIS_TLAST	: out std_logic;
		-- TREADY indicates that the slave can accept a transfer in the current cycle.
		M_AXIS_TREADY	: in std_logic
	);
end Blokus_accelerator_stream_v1_0_M00_AXIS;

architecture implementation of Blokus_accelerator_stream_v1_0_M00_AXIS is
	signal data: STD_LOGIC_VECTOR(32*7-1 downto 0);
	
	type state is (INIT, INIT_2, IDLE, WAIT_DMA_READY, SENDING);                              
	signal fsm_cs, fsm_ns: state;
		
    signal count_cs, count_ns: STD_LOGIC_VECTOR(3-1 downto 0);
begin
    -- Type conversion and zeroes padding
    row: for i in 0 to 14-1 generate
        col: for j in 0 to 14-1 generate
            data(14*i + j) <= overlapping_map(i, j);
        end generate;
    end generate;
    data(32*7-1 downto 14*14) <= (others=>'0');        
    
    -- I/O Connections assignments
	M_AXIS_TSTRB <= (others => '1');
	M_AXIS_TDATA <= data(32-1 + 32*conv_integer(count_cs) downto 32*conv_integer(count_cs));
    
    process(count_cs, fsm_cs, M_AXIS_TREADY)                                                                        
    begin
        M_AXIS_TVALID <= '0';
        M_AXIS_TLAST  <= '0';
        count_ns <= count_cs;
        fsm_ns <= fsm_cs;
                                                                                               
        case fsm_cs is                                                              
            when INIT =>
                -- Send four dummy data beats
                if M_AXIS_TREADY = '1' then
                    M_AXIS_TVALID <= '1';
                    count_ns <= count_cs + 1;             
                    fsm_ns <= INIT_2;
                end if;
                
            when INIT_2=>
                M_AXIS_TVALID <= '1';
                if conv_integer(count_cs) < 3 then
                    count_ns <= count_cs + 1;
                else
                    count_ns <= (others => '0');
                    fsm_ns <= IDLE;
                end if;
            
            when IDLE =>
                if send_map = '1' then
                    fsm_ns <= WAIT_DMA_READY;
                end if;
                
            when WAIT_DMA_READY =>
                if M_AXIS_TREADY = '1' then
                    fsm_ns <= SENDING;
                end if;
                
            when SENDING =>
                if M_AXIS_TREADY = '1' then
                    M_AXIS_TVALID <= '1';
                    if count_cs = 6 then
                        M_AXIS_TLAST <= '1';
                        count_ns <= (others => '0');                        
                        fsm_ns <= IDLE;
                    else
                        count_ns <= count_cs + 1;                        
                    end if;
                end if;                
        end case;
    end process;
    
    process(M_AXIS_ACLK)                                                                        
    begin                                                                                       
        if rising_edge(M_AXIS_ACLK) then                                                       
            if M_AXIS_ARESETN = '0' then                         
                fsm_cs <= INIT;
                count_cs <= (others => '0');                
            else
                fsm_cs <= fsm_ns;
                count_cs <= count_ns;                
            end if;
        end if;
    end process;
end implementation;
