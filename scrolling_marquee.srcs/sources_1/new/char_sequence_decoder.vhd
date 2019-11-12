library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity char_sequence_decoder is
Port (input : in std_logic_vector(4 downto 0);
      output : out std_logic_vector(5 downto 0));
end char_sequence_decoder;

architecture DataFlow of char_sequence_decoder is

begin
    
    output <= "011101" when (input = 1) else --t
              "010001" when (input = 2) else --h
              "011000" when (input = 3 or input = 11) else --o
              "010110" when (input = 4) else --m
              "010110" when (input = 5) else --m
              "001010" when (input = 6) else --a
              "011100" when (input = 7) else --s
              "111111" when (input = 8) else --space (no displayed character)
              "001011" when (input = 9) else --b
              "011011" when (input = 10) else --r
              "100000" when (input = 12) else --w
              "100000" when (input = 13) else --w
              "010111" when (input = 14) else --n;
              "111111";

end DataFlow;
