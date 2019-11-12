library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clk_delay_and_count_up_tb is
end clk_delay_and_count_up_tb;

architecture Behavioral of clk_delay_and_count_up_tb is

component clk_delay is
port (clk, reset : in std_logic;
      delay_value : in natural range 1 to 100;
	  clk_out : out std_logic);
end component;

component count_to_eighteen is
port (clk, reset : in std_logic;
	  output : out std_logic_vector (4 downto 0));
end component;

signal clk, reset : std_logic := '0';
signal clk_out : std_logic;
signal delay_value : natural range 1 to 100 := 5;
signal output : std_logic_vector (4 downto 0);

begin

U1: clk_delay port map (clk => clk,
						reset => reset,
						delay_value => delay_value,
						clk_out => clk_out);

U2: count_to_eighteen port map (clk => clk,
                                reset => reset,
	                            output => output);

    clock: process
        begin
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
        end process;
        
--    test: process
--        begin
--            wait for 25 ns;
--			reset <= '1';
--			wait for 10 ns;
--			reset <= '0';
--			wait for 100 ns;
--			reset <= '1';
--			wait for 10 ns;
--			reset <= '0';
--			wait;
--        end process;

end Behavioral;
