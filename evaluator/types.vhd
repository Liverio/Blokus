library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

package types is
	--------------------
	------ PLAYER ------
	--------------------
	type color is (Blue, Green);
	subtype tpPlayer is STD_LOGIC;
	constant HERO : STD_LOGIC := '0';
	constant RIVAL: STD_LOGIC := '1';
	
	
	---------------------
	------- BOARD -------
	---------------------
	subtype tpSquare is STD_LOGIC_VECTOR(1 downto 0);
	
	-- Board encoding for vertices dectection
	constant SQUARE_FREE				 : STD_LOGIC_VECTOR(2-1 downto 0) := "00";
	constant SQUARE_RIVAL			 : STD_LOGIC_VECTOR(2-1 downto 0) := "01";
	constant SQUARE_HERO				 : STD_LOGIC_VECTOR(2-1 downto 0) := "10";
	
	-- Board encoding for accessibility evaluation
	constant FREE				 : STD_LOGIC_VECTOR(2-1 downto 0) := "00";
	constant FORBIDDEN_RIVAL : STD_LOGIC_VECTOR(2-1 downto 0) := "01";
	constant FORBIDDEN_HERO	 : STD_LOGIC_VECTOR(2-1 downto 0) := "10";
	constant FORBIDDEN_BOTH  : STD_LOGIC_VECTOR(2-1 downto 0) := "11";
	
	type tpBoardRow is array(0 to 14-1) of tpSquare;
	type tpBoard is array(0 to 14-1) of tpBoardRow;

	--------------------
	----- VERTICES -----
	--------------------
	-- 13x13 map (w/o boundary vertices)
	type tpVertices_row is array(0 to 13-1) of STD_LOGIC;
	type tpVertices_map is array(0 to 13-1) of tpVertices_row;
	type tpVertices_type_map is array(0 to 13-1, 0 to 13-1) of STD_LOGIC_VECTOR(2-1 downto 0);
	
	--------------------------
	----- TILE POSITIONS -----
	--------------------------
	subtype tpPosition is STD_LOGIC_VECTOR(4-1 downto 0);
	type tpPiecesPositions is array(0 to 5-1) of tpPosition;
	type tpForbiddenPositions is array(0 to 12-1) of tpPosition;
	
	-----------------------
	-- PROCESSING WINDOW --
	-----------------------
	type tpProcessingWindow is array(-4 to 4, -4 to 4) of STD_LOGIC;
	
	----------------------------------------
	-- OVERLAPPING AND ACCESSIBILITY MAPS --
	----------------------------------------
	type tpAccessibility_map is array(0 to 14-1, 0 to 14-1) of STD_LOGIC;	
	type tpWorkMode_accessibilityMap is (EVALUATION_MODE, OVERLAPPING_MODE);
	
	---------------------
	-- MOVE REORDERING --
	---------------------
	constant last_level_sorted : integer := 4;
	type tp_array_movements is array(0 to last_level_sorted-1) of STD_LOGIC_VECTOR(16-1 downto 0);
	
	----------------------
	-- MAX_SIZE CHECKER --
	----------------------
	type tp_size is (SIZE_5, SIZE_4, LESS_THAN_4);
	
	--------------------------
	-- LEGAL MOVES CHECKING --
	--------------------------
	-- U
	constant v0u00, v1u00, v2u00, v3u00: natural := 0;
	constant v0u01, v1u01, v2u01, v3u01: natural := 1;
	-- T
	constant v0t00, v1t00, v2t00, v3t00: natural := 2;
	constant v0t01, v1t01, v2t10, v3t01: natural := 3;
	constant v0t10, v1t10, v2t11, v3t10: natural := 4;
	constant v0t11, v1t11, v2t20, v3t20: natural := 5;
	constant v0t20, v1t20, v2t21, v3t30: natural := 6;
	constant v0t21, v1t21, v2t30, v3t31: natural := 7;
	constant v0t30, v1t30, v2t40, v3t40: natural := 8;
	constant v0t31, v1t31, v2t41, v3t41: natural := 9;
	constant v0t40, v1t40, v2t50, v3t50: natural := 10;
	constant v0t50, v1t41, v2t51, v3t51: natural := 11;
	constant v0t51, v1t50, v2t60, v3t60: natural := 12;
	constant v0t60, v1t60, v2t61, v3t61: natural := 13;
	constant v0t61, v1t70, v2t70, v3t70: natural := 14;
	constant v0t70, v1t71, v2t71, v3t71: natural := 15;
	-- S
	constant v0s00, v1s00, v2s00, v3s00: natural := 16;
	constant v0s10, v1s01, v2s10, v3s01: natural := 17;
	constant v0s11, v1s10, v2s11, v3s10: natural := 18;
	constant v0s20, v1s20, v2s20, v3s20: natural := 19;
	constant v0s21, v1s30, v2s21, v3s30: natural := 20;
	constant v0s30, v1s31, v2s30, v3s31: natural := 21;
	-- R
	constant v0r00, v1r00, v2r00, v3r00: natural := 22;
	constant v0r10, v1r01, v2r10, v3r01: natural := 23;
	constant v0r11, v1r02, v2r11, v3r10: natural := 24;
	constant v0r12, v1r10, v2r20, v3r20: natural := 25;
	constant v0r20, v1r20, v2r21, v3r30: natural := 26;
	constant v0r21, v1r30, v2r22, v3r31: natural := 27;
	constant v0r30, v1r31, v2r30, v3r32: natural := 28;
	-- Q
	constant v0q00, v1q00, v2q00, v3q00: natural := 29;
	constant v0q10, v1q10, v2q10, v3q01: natural := 30;
	constant v0q20, v1q20, v2q11, v3q10: natural := 31;
	constant v0q21, v1q30, v2q20, v3q20: natural := 32;
	constant v0q30, v1q31, v2q30, v3q30: natural := 33;
	-- P
	constant v0p00, v1p00, v2p00, v3p00: natural := 34;
	constant v0p20, v1p20, v2p01, v3p01: natural := 35;
	constant v0p21, v1p30, v2p20, v3p20: natural := 36;
	constant v0p30, v1p31, v2p30, v3p21: natural := 37;
	constant v0p40, v1p40, v2p31, v3p30: natural := 38;
	constant v0p41, v1p41, v2p40, v3p40: natural := 39;
	-- O
	constant v0o00, v1o00, v2o00, v3o00: natural := 40;
	constant v0o01, v1o10, v2o10, v3o01: natural := 41;
	constant v0o10, v1o11, v2o11, v3o10: natural := 42;
	constant v0o20, v1o20, v2o20, v3o20: natural := 43;
	constant v0o21, v1o21, v2o30, v3o30: natural := 44;
	constant v0o30, v1o30, v2o40, v3o40: natural := 45;
	constant v0o31, v1o31, v2o41, v3o50: natural := 46;
	constant v0o40, v1o40, v2o50, v3o51: natural := 47;
	constant v0o50, v1o41, v2o60, v3o60: natural := 48;
	constant v0o51, v1o50, v2o61, v3o61: natural := 49;
	constant v0o60, v1o60, v2o70, v3o70: natural := 50;
	constant v0o70, v1o70, v2o71, v3o71: natural := 51;
	-- N
	constant v0n00, v1n00, v2n00, v3n00: natural := 52;
	constant v0n10, v1n01, v2n01, v3n10: natural := 53;
	constant v0n11, v1n10, v2n10, v3n11: natural := 54;
	constant v0n20, v1n20, v2n20, v3n20: natural := 55;
	constant v0n60, v1n60, v2n21, v3n21: natural := 56;
	constant v0n61, v1n61, v2n60, v3n60: natural := 57;
	-- M
	constant v0m00, v1m00, v2m00, v3m00: natural := 58;
	constant v0m10, v1m10, v2m01, v3m10: natural := 59;
	constant v0m20, v1m20, v2m10, v3m11: natural := 60;
	constant v0m30, v1m30, v2m20, v3m20: natural := 61;
	constant v0m40, v1m40, v2m30, v3m21: natural := 62;
	constant v0m41, v1m50, v2m31, v3m30: natural := 63;
	constant v0m50, v1m51, v2m40, v3m40: natural := 64;
	constant v0m60, v1m60, v2m50, v3m50: natural := 65;
	constant v0m70, v1m61, v2m60, v3m60: natural := 66;
	constant v0m71, v1m70, v2m70, v3m70: natural := 67;
	-- L
	constant v0l00, v1l00, v2l00, v3l00: natural := 68;
	constant v0l01, v1l10, v2l01, v3l10: natural := 69;
	constant v0l10, v1l11, v2l10, v3l11: natural := 70;
	constant v0l20, v1l20, v2l20, v3l20: natural := 71;
	constant v0l30, v1l21, v2l30, v3l21: natural := 72;
	constant v0l31, v1l30, v2l31, v3l30: natural := 73;
	constant v0l40, v1l40, v2l40, v3l40: natural := 74;
	constant v0l41, v1l50, v2l41, v3l50: natural := 75;
	constant v0l50, v1l51, v2l50, v3l51: natural := 76;
	constant v0l60, v1l60, v2l60, v3l60: natural := 77;
	constant v0l70, v1l61, v2l70, v3l61: natural := 78;
	constant v0l71, v1l70, v2l71, v3l70: natural := 79;
	-- K
	constant v0k00, v1k00, v2k00, v3k00: natural := 80;
	constant v0k10, v1k10, v2k01, v3k10: natural := 81;
	constant v0k20, v1k20, v2k10, v3k11: natural := 82;
	constant v0k30, v1k30, v2k20, v3k20: natural := 83;
	constant v0k40, v1k40, v2k30, v3k21: natural := 84;
	constant v0k41, v1k50, v2k31, v3k30: natural := 85;
	constant v0k50, v1k51, v2k40, v3k40: natural := 86;
	constant v0k60, v1k60, v2k50, v3k50: natural := 87;
	constant v0k70, v1k61, v2k60, v3k60: natural := 88;
	constant v0k71, v1k70, v2k70, v3k70: natural := 89;
	-- J
	constant v0j00, v1j00, v2j00, v3j00: natural := 90;
	constant v0j20, v1j20, v2j20, v3j20: natural := 91;
	-- I
	constant v0i00, v1i00, v2i00, v3i00: natural := 92;
	constant v0i10, v1i01, v2i10, v3i01: natural := 93;
	constant v0i11, v1i10, v2i11, v3i10: natural := 94;
	constant v0i20, v1i20, v2i20, v3i20: natural := 95;
	constant v0i21, v1i30, v2i21, v3i30: natural := 96;
	constant v0i30, v1i31, v2i30, v3i31: natural := 97;
	-- H
	constant v0h00, v1h00, v2h00, v3h00: natural := 98;
	-- G
	constant v0g00, v1g00, v2g00, v3g00: natural := 99;
	constant v0g01, v1g10, v2g10, v3g01: natural := 100;
	constant v0g10, v1g11, v2g11, v3g10: natural := 101;
	constant v0g20, v1g20, v2g20, v3g20: natural := 102;
	constant v0g21, v1g21, v2g60, v3g60: natural := 103;
	constant v0g60, v1g60, v2g61, v3g61: natural := 104;
	-- F
	constant v0f00, v1f00, v2f00, v3f00: natural := 105;
	constant v0f10, v1f10, v2f01, v3f10: natural := 106;
	constant v0f20, v1f20, v2f10, v3f11: natural := 107;
	constant v0f30, v1f30, v2f20, v3f20: natural := 108;
	constant v0f40, v1f40, v2f30, v3f21: natural := 109;
	constant v0f41, v1f50, v2f31, v3f30: natural := 110;
	constant v0f50, v1f51, v2f40, v3f40: natural := 111;
	constant v0f60, v1f60, v2f50, v3f50: natural := 112;
	constant v0f70, v1f61, v2f60, v3f60: natural := 113;
	constant v0f71, v1f70, v2f70, v3f70: natural := 114;
	-- E
	constant v0e00, v1e00, v2e00, v3e00: natural := 115;
	constant v0e20, v1e20, v2e20, v3e20: natural := 116;
	-- D
	constant v0d00, v1d00, v2d00, v3d00: natural := 117;
	constant v0d10, v1d10, v2d10, v3d01: natural := 118;
	constant v0d20, v1d20, v2d11, v3d10: natural := 119;
	constant v0d21, v1d30, v2d20, v3d20: natural := 120;
	constant v0d30, v1d31, v2d30, v3d30: natural := 121;
	-- C
	constant v0c00, v1c00, v2c00, v3c00: natural := 122;
	constant v0c20, v1c20, v2c20, v3c20: natural := 123;
	-- B
	constant v0b00, v1b00, v2b00, v3b00: natural := 124;
	constant v0b20, v1b20, v2b20, v3b20: natural := 125;
	-- A
	constant v0a00, v1a00, v2a00, v3a00: natural := 126;
											
									
	
	type move_source is (TREE_MOVE, CHOSEN_MOVE, RIVAL_MOVE);
	
	----------------------
	---- INPUT/OUTPUT ----
	----------------------
	-- Team code
	constant ascii_U: STD_LOGIC_VECTOR(8-1 downto 0) := conv_std_logic_vector(85, 8);
	constant ascii_Z: STD_LOGIC_VECTOR(8-1 downto 0) := conv_std_logic_vector(90, 8);
	-- #Code
	constant ascii_0: STD_LOGIC_VECTOR(8-1 downto 0) := conv_std_logic_vector(48, 8);
	constant ascii_1: STD_LOGIC_VECTOR(8-1 downto 0) := conv_std_logic_vector(49, 8);
	constant ascii_2: STD_LOGIC_VECTOR(8-1 downto 0) := conv_std_logic_vector(50, 8);
	constant ascii_3: STD_LOGIC_VECTOR(8-1 downto 0) := conv_std_logic_vector(51, 8);
	constant ascii_4: STD_LOGIC_VECTOR(8-1 downto 0) := conv_std_logic_vector(52, 8);
	-- Blue selection
	constant ascii_5: STD_LOGIC_VECTOR(8-1 downto 0) := conv_std_logic_vector(53, 8);
	-- Termination
	constant ascii_9: STD_LOGIC_VECTOR(8-1 downto 0) := conv_std_logic_vector(57, 8);
	
	---------------
	---- TILES ----
	---------------
	constant tile_u: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(0, 5);
	constant tile_t: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(1, 5);
	constant tile_s: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(2, 5);
	constant tile_r: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(3, 5);
	constant tile_q: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(4, 5);
	constant tile_p: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(5, 5);
	constant tile_o: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(6, 5);
	constant tile_n: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(7, 5);
	constant tile_m: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(8, 5);
	constant tile_l: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(9, 5);
	constant tile_k: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(10, 5);
	constant tile_j: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(11, 5);
	constant tile_i: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(12, 5);
	constant tile_h: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(13, 5);
	constant tile_g: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(14, 5);
	constant tile_f: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(15, 5);
	constant tile_e: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(16, 5);
	constant tile_d: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(17, 5);
	constant tile_c: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(18, 5);
	constant tile_b: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(19, 5);
	constant tile_a: STD_LOGIC_VECTOR(5-1 downto 0) := conv_std_logic_vector(20, 5);
end types;