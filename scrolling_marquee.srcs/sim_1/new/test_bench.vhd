library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity test_bench is
end test_bench;

architecture Behavioral of test_bench is

component clk_delay is
port (clk, reset : in std_logic;
	  delay : in natural range 1 to 1000000000;
	  clk_out : out std_logic);
end component;

signal clk, reset : std_logic := '0';
signal clk_out : std_logic;
signal count : natural range 0 to 1000 := 0;

begin

U1: clk_delay port map (clk => clk,
                        reset => reset,
                        delay => 10,
                        clk_out => clk_out);
                        
    clock: process
        begin
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
        end process;
        
    process(clk)
        begin
            if count = 1000 then
                reset <= '1';
                count <= 0;
            elsif count < 1000 then
                reset <= '0';
                count <= count + 1;
            end if;
        end process;

end Behavioral;
