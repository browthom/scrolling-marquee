library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity buffer_6_bit is
Port (clk : in std_logic;
      input : in std_logic_vector(5 downto 0);
      output : out std_logic_vector(5 downto 0));
end buffer_6_bit;

architecture Behavioral of buffer_6_bit is

signal temp : std_logic_vector(5 downto 0) := (others => '0');

begin
    process(clk)
        begin
            if rising_edge(clk) then
                temp <= input;
            end if;
        end process;
        
output <= temp;

end Behavioral;
