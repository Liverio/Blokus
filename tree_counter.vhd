library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
use work.types.ALL;

entity treeCounter is
    port(input:  in  tpAccessibility_map;
         output: out STD_LOGIC_VECTOR(7-1 downto 0));
end treeCounter;

architecture treeCounterArch of treeCounter is
	component adder
		generic (input_width: positive := 1);
		port(a, b: in  STD_LOGIC_VECTOR(input_width-1 downto 0);
			  add : out STD_LOGIC_VECTOR((input_width+1)-1 downto 0)			  
		);
	end component;
	
	type tpLvl1_inputs is array(0 to 196-1) of STD_LOGIC_VECTOR(1-1 downto 0); 
	signal lvl1_inputs: tpLvl1_inputs;
	type tpLvl1 is array(0 to 98-1) of STD_LOGIC_VECTOR(2-1 downto 0);
	signal lvl1: tpLvl1;
	type tpLvl2 is array(0 to 49-1) of STD_LOGIC_VECTOR(3-1 downto 0);
	signal lvl2: tpLvl2;
	type tpLvl3 is array(0 to 25-1) of STD_LOGIC_VECTOR(4-1 downto 0);
	signal lvl3: tpLvl3;
	type tpLvl4 is array(0 to 13-1) of STD_LOGIC_VECTOR(5-1 downto 0);
	signal lvl4: tpLvl4;
	type tpLvl5 is array(0 to 7-1) of STD_LOGIC_VECTOR(6-1 downto 0);
	signal lvl5: tpLvl5;
	type tpLvl6 is array(0 to 4-1) of STD_LOGIC_VECTOR(7-1 downto 0);
	signal lvl6: tpLvl6;
	type tpLvl7 is array(0 to 2-1) of STD_LOGIC_VECTOR(8-1 downto 0);
	signal lvl7: tpLvl7;

	signal add: STD_LOGIC_VECTOR(9-1 downto 0);
begin	
	-- Type conversion
	y: for i in 0 to 14-1 generate
		x: for j in 0 to 14-1 generate
			lvl1_inputs(14*i+j) <= conv_std_logic_vector(input(i, j), 1);
		end generate;
	end generate;
	
	-- Level 1: 98 2-bit adders
	lvl1_adders: for i in 0 to 98-1 generate
						adder_2bit: adder generic map(1) port map(lvl1_inputs((2*i)+1), lvl1_inputs(2*i), lvl1(i));						
	end generate;
	
	-- Level 2: 49 3-bit adders
	lvl2_adders: for i in 0 to 49-1 generate
						adder_3bit: adder generic map(2) port map(lvl1((2*i)+1), lvl1(2*i), lvl2(i));
	end generate;
	
	-- Level 3: 25 4-bit adders
	lvl3_adders: for i in 0 to 25-1 generate
						not_last: if i < 24 generate
							adder_4bit: adder generic map(3) port map(lvl2((2*i)+1), lvl2(2*i), lvl3(i));
						end generate;
						last: if i = 24 generate
							adder_4bit: adder generic map(3) port map("000", lvl2(2*i), lvl3(i));
						end generate;
	end generate;
	
	-- Level 4: 13 5-bit adders
	lvl4_adders: for i in 0 to 13-1 generate
						not_last: if i < 12 generate
							adder_5bit: adder generic map(4) port map(lvl3((2*i)+1), lvl3(2*i), lvl4(i));
						end generate;
						last: if i = 12 generate
							adder_5bit: adder generic map(4) port map("0000", lvl3(2*i), lvl4(i));
						end generate;
	end generate;
	
	-- Level 5: 7 6-bit adders
	lvl5_adders: for i in 0 to 7-1 generate
						not_last: if i < 6 generate
							adder_6bit: adder generic map(5) port map(lvl4((2*i)+1), lvl4(2*i), lvl5(i));
						end generate;
						last: if i = 6 generate
							adder_6bit: adder generic map(5) port map("00000", lvl4(2*i), lvl5(i));
						end generate;
	end generate;
	
	-- Level 6: 4 7-bit adders
	lvl6_adders: for i in 0 to 4-1 generate
						not_last: if i < 3 generate
							adder_7bit: adder generic map(6) port map(lvl5((2*i)+1), lvl5(2*i), lvl6(i));
						end generate;
						last: if i = 3 generate
							adder_7bit: adder generic map(6) port map("000000", lvl5(2*i), lvl6(i));
						end generate;
	end generate;
	
	lvl7_adders: for i in 0 to 2-1 generate
						adder_8bit: adder generic map(7) port map(lvl6((2*i)+1), lvl6(2*i), lvl7(i));
	end generate;

	adder_9bit: adder generic map(8) port map(lvl7(1), lvl7(0), add);
	
	output <= add(7-1 downto 0);

--		output <= 	 conv_std_logic_vector(input(0), 7) + conv_std_logic_vector(input(1),7) +
--						 conv_std_logic_vector(input(2), 7) + conv_std_logic_vector(input(3),7) +
--						 conv_std_logic_vector(input(4), 7) + conv_std_logic_vector(input(5),7) +
--						 conv_std_logic_vector(input(6), 7) + conv_std_logic_vector(input(7),7) +
--						 conv_std_logic_vector(input(8), 7) + conv_std_logic_vector(input(9),7) +
--						 conv_std_logic_vector(input(10), 7) + conv_std_logic_vector(input(11),7) +
--						 conv_std_logic_vector(input(12), 7) + conv_std_logic_vector(input(13),7) +
--						 conv_std_logic_vector(input(14), 7) + conv_std_logic_vector(input(15),7) +
--						 conv_std_logic_vector(input(16), 7) + conv_std_logic_vector(input(17),7) +
--						 conv_std_logic_vector(input(18), 7) + conv_std_logic_vector(input(19),7) +
--						 conv_std_logic_vector(input(20), 7) + conv_std_logic_vector(input(21),7) +
--						 conv_std_logic_vector(input(22), 7) + conv_std_logic_vector(input(23),7) +
--						 conv_std_logic_vector(input(24), 7) + conv_std_logic_vector(input(25),7) +
--						 conv_std_logic_vector(input(26), 7) + conv_std_logic_vector(input(27),7) +
--						 conv_std_logic_vector(input(28), 7) + conv_std_logic_vector(input(29),7) +
--						 conv_std_logic_vector(input(30), 7) + conv_std_logic_vector(input(31),7) +
--						 conv_std_logic_vector(input(32), 7) + conv_std_logic_vector(input(33),7) +
--						 conv_std_logic_vector(input(34), 7) + conv_std_logic_vector(input(35),7) +
--						 conv_std_logic_vector(input(36), 7) + conv_std_logic_vector(input(37),7) +
--						 conv_std_logic_vector(input(38), 7) + conv_std_logic_vector(input(39),7) +
--						 conv_std_logic_vector(input(40), 7) + conv_std_logic_vector(input(41),7) +
--						 conv_std_logic_vector(input(42), 7) + conv_std_logic_vector(input(43),7) +
--						 conv_std_logic_vector(input(44), 7) + conv_std_logic_vector(input(45),7) +
--						 conv_std_logic_vector(input(46), 7) + conv_std_logic_vector(input(47),7) +
--						 conv_std_logic_vector(input(48), 7) + conv_std_logic_vector(input(49),7) +
--						 conv_std_logic_vector(input(50), 7) + conv_std_logic_vector(input(51),7) +
--						 conv_std_logic_vector(input(52), 7) + conv_std_logic_vector(input(53),7) +
--						 conv_std_logic_vector(input(54), 7) + conv_std_logic_vector(input(55),7) +
--						 conv_std_logic_vector(input(56), 7) + conv_std_logic_vector(input(57),7) +
--						 conv_std_logic_vector(input(58), 7) + conv_std_logic_vector(input(59),7) +
--						 conv_std_logic_vector(input(60), 7) + conv_std_logic_vector(input(61),7) +
--						 conv_std_logic_vector(input(62), 7) + conv_std_logic_vector(input(63),7) +
--						 conv_std_logic_vector(input(64), 7) + conv_std_logic_vector(input(65),7) +
--						 conv_std_logic_vector(input(66), 7) + conv_std_logic_vector(input(67),7) +
--						 conv_std_logic_vector(input(68), 7) + conv_std_logic_vector(input(69),7) +
--						 conv_std_logic_vector(input(70), 7) + conv_std_logic_vector(input(71),7) +
--						 conv_std_logic_vector(input(72), 7) + conv_std_logic_vector(input(73),7) +
--						 conv_std_logic_vector(input(74), 7) + conv_std_logic_vector(input(75),7) +
--						 conv_std_logic_vector(input(76), 7) + conv_std_logic_vector(input(77),7) +
--						 conv_std_logic_vector(input(78), 7) + conv_std_logic_vector(input(79),7) +
--						 conv_std_logic_vector(input(80), 7) + conv_std_logic_vector(input(81),7) +
--						 conv_std_logic_vector(input(82), 7) + conv_std_logic_vector(input(83),7) +
--						 conv_std_logic_vector(input(84), 7) + conv_std_logic_vector(input(85),7) +
--						 conv_std_logic_vector(input(86), 7) + conv_std_logic_vector(input(87),7) +
--						 conv_std_logic_vector(input(88), 7) + conv_std_logic_vector(input(89),7) +
--						 conv_std_logic_vector(input(90), 7) + conv_std_logic_vector(input(91),7) +
--						 conv_std_logic_vector(input(92), 7) + conv_std_logic_vector(input(93),7) +
--						 conv_std_logic_vector(input(94), 7) + conv_std_logic_vector(input(95),7) +
--						 conv_std_logic_vector(input(96), 7) + conv_std_logic_vector(input(97),7) +
--						 conv_std_logic_vector(input(98), 7) + conv_std_logic_vector(input(99),7) +
--						 conv_std_logic_vector(input(100), 7) + conv_std_logic_vector(input(101),7) +
--						 conv_std_logic_vector(input(102), 7) + conv_std_logic_vector(input(103),7) +
--						 conv_std_logic_vector(input(104), 7) + conv_std_logic_vector(input(105),7) +
--						 conv_std_logic_vector(input(106), 7) + conv_std_logic_vector(input(107),7) +
--						 conv_std_logic_vector(input(108), 7) + conv_std_logic_vector(input(109),7) +
--						 conv_std_logic_vector(input(110), 7) + conv_std_logic_vector(input(111),7) +
--						 conv_std_logic_vector(input(112), 7) + conv_std_logic_vector(input(113),7) +
--						 conv_std_logic_vector(input(114), 7) + conv_std_logic_vector(input(115),7) +
--						 conv_std_logic_vector(input(116), 7) + conv_std_logic_vector(input(117),7) +
--						 conv_std_logic_vector(input(118), 7) + conv_std_logic_vector(input(119),7) +
--						 conv_std_logic_vector(input(120), 7) + conv_std_logic_vector(input(121),7) +
--						 conv_std_logic_vector(input(122), 7) + conv_std_logic_vector(input(123),7) +
--						 conv_std_logic_vector(input(124), 7) + conv_std_logic_vector(input(125),7) +
--						 conv_std_logic_vector(input(126), 7) + conv_std_logic_vector(input(127),7) +
--						 conv_std_logic_vector(input(128), 7) + conv_std_logic_vector(input(129),7) +
--						 conv_std_logic_vector(input(130), 7) + conv_std_logic_vector(input(131),7) +
--						 conv_std_logic_vector(input(132), 7) + conv_std_logic_vector(input(133),7) +
--						 conv_std_logic_vector(input(134), 7) + conv_std_logic_vector(input(135),7) +
--						 conv_std_logic_vector(input(136), 7) + conv_std_logic_vector(input(137),7) +
--						 conv_std_logic_vector(input(138), 7) + conv_std_logic_vector(input(139),7) +
--						 conv_std_logic_vector(input(140), 7) + conv_std_logic_vector(input(141),7) +
--						 conv_std_logic_vector(input(142), 7) + conv_std_logic_vector(input(143),7) +
--						 conv_std_logic_vector(input(144), 7) + conv_std_logic_vector(input(145),7) +
--						 conv_std_logic_vector(input(146), 7) + conv_std_logic_vector(input(147),7) +
--						 conv_std_logic_vector(input(148), 7) + conv_std_logic_vector(input(149),7) +
--						 conv_std_logic_vector(input(150), 7) + conv_std_logic_vector(input(151),7) +
--						 conv_std_logic_vector(input(152), 7) + conv_std_logic_vector(input(153),7) +
--						 conv_std_logic_vector(input(154), 7) + conv_std_logic_vector(input(155),7) +
--						 conv_std_logic_vector(input(156), 7) + conv_std_logic_vector(input(157),7) +
--						 conv_std_logic_vector(input(158), 7) + conv_std_logic_vector(input(159),7) +
--						 conv_std_logic_vector(input(160), 7) + conv_std_logic_vector(input(161),7) +
--						 conv_std_logic_vector(input(162), 7) + conv_std_logic_vector(input(163),7) +
--						 conv_std_logic_vector(input(164), 7) + conv_std_logic_vector(input(165),7) +
--						 conv_std_logic_vector(input(166), 7) + conv_std_logic_vector(input(167),7) +
--						 conv_std_logic_vector(input(168), 7) + conv_std_logic_vector(input(169),7) +
--						 conv_std_logic_vector(input(170), 7) + conv_std_logic_vector(input(171),7) +
--						 conv_std_logic_vector(input(172), 7) + conv_std_logic_vector(input(173),7) +
--						 conv_std_logic_vector(input(174), 7) + conv_std_logic_vector(input(175),7) +
--						 conv_std_logic_vector(input(176), 7) + conv_std_logic_vector(input(177),7) +
--						 conv_std_logic_vector(input(178), 7) + conv_std_logic_vector(input(179),7) +
--						 conv_std_logic_vector(input(180), 7) + conv_std_logic_vector(input(181),7) +
--						 conv_std_logic_vector(input(182), 7) + conv_std_logic_vector(input(183),7) +
--						 conv_std_logic_vector(input(184), 7) + conv_std_logic_vector(input(185),7) +
--						 conv_std_logic_vector(input(186), 7) + conv_std_logic_vector(input(187),7) +
--						 conv_std_logic_vector(input(188), 7) + conv_std_logic_vector(input(189),7) +
--						 conv_std_logic_vector(input(190), 7) + conv_std_logic_vector(input(191),7) +
--						 conv_std_logic_vector(input(192), 7) + conv_std_logic_vector(input(193),7) +
--						 conv_std_logic_vector(input(194), 7) + conv_std_logic_vector(input(195),7);
end treeCounterArch;