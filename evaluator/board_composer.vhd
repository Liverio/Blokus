library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity board_composer is
    port (----------------
          ---- INPUTS ----
		  ----------------
		  -- Board from PS			
		  board	: in tpBoard;
		  -----------------
		  ---- OUTPUTS ----
		  -----------------
		  -- Board with forbidden squares info
		  board_forbiddens : out tpBoard
    );
end board_composer;

architecture board_composerArch of board_composer is
    component piece_checker
        port (----------------
              ---- INPUTS ----
              ----------------
              -- Square to check            
              square : in tpSquare;
              -- Neighbors
              north : in tpSquare;
              south : in tpSquare;
              west  : in tpSquare;
              east  : in tpSquare;
              -----------------
              ---- OUTPUTS ----
              -----------------
              output : out tpSquare
       );
    end component;
    
    type tp_map is array(0 to 14-1, 0 to 14-1) of tpSquare;
    signal north, south, west, east: tp_map;
begin
    -- * Occupied squares are marked as FORBIDDEN_BOTH
    -- * Empty squares check its N,S,W,E neighbors to determine whether they are FORBIDDEN_BOTH, FORBIDDEN_HERO, FORBIDDEN_RIVAL or FREE
    forbiddens_board_row: for i in 0 to 14-1 generate
        forbiddens_board_col: for j in 0 to 14-1 generate
            --north(i,j) <= board(i-1)(  j) when i >  0 else SQUARE_FREE;
            --south(i,j) <= board(i+1)(  j) when i < 13 else SQUARE_FREE;
            --west (i,j) <= board(  i)(j-1) when j >  0 else SQUARE_FREE;
            --east (i,j) <= board(  i)(j+1) when j < 13 else SQUARE_FREE;
            moco_0: if i > 0 generate
                north(i,j) <= board(i-1)(  j);
            end generate;
            moco_1: if i = 0 generate
                north(i,j) <= SQUARE_FREE;
            end generate;
            
            moco_2: if i < 13 generate
                south(i,j) <= board(i+1)(  j);
            end generate;
            moco_3: if i = 13 generate
                south(i,j) <= SQUARE_FREE;
            end generate;
            
            moco_4: if j > 0 generate
                west(i,j) <= board(  i)(j-1);
            end generate;
            moco_5: if j = 0 generate
                west(i,j) <= SQUARE_FREE;
            end generate;
            
            moco_6: if j < 13 generate
                east(i,j) <= board(  i)(j+1);
            end generate;
            moco_7: if j = 13 generate
                east(i,j) <= SQUARE_FREE;
            end generate;
            
            piece_checker_I: piece_checker
                port map(---- INPUTS ----
                         board(i)(j),
                         north(i,j),
                         south(i,j),
                         west(i,j),
                         east(i,j),
                         ---- OUTPUTS ----
                         board_forbiddens(i)(j)
                );
        end generate;
    end generate;
end board_composerArch;
