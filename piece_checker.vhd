library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.types.ALL;

entity piece_checker is
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
end piece_checker;

architecture piece_checkerArch of piece_checker is
    signal hero_piece, rival_piece: STD_LOGIC;
begin
    hero_piece  <= '1' when north = SQUARE_HERO OR
                            south = SQUARE_HERO OR
                            west  = SQUARE_HERO OR
                            east  = SQUARE_HERO else
                   '0';
                   
    rival_piece  <= '1' when north = SQUARE_RIVAL OR
                             south = SQUARE_RIVAL OR
                             west  = SQUARE_RIVAL OR
                             east  = SQUARE_RIVAL else
                    '0';

    output <= FORBIDDEN_BOTH  when square /= SQUARE_FREE                   else
              FORBIDDEN_BOTH  when hero_piece  = '1' AND rival_piece = '1' else
              FORBIDDEN_HERO  when hero_piece  = '1'                       else
              FORBIDDEN_RIVAL when rival_piece = '1'                       else
              FREE;
end piece_checkerArch;