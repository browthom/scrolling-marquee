library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity top_level is
Port (clk : in std_logic;
      seg_out : out std_logic_vector(7 downto 0);
      anode_out : out std_logic_vector(3 downto 0));
end top_level;

architecture Behavioral of top_level is

component delay_enable is
port (clk, reset, invert : in std_logic;
      delay_value : in natural range 0 to 1000000000;
	  enable : out std_logic);
end component;

component count_to_eighteen is
port (clk, reset, enable, enable_auto_reset : in std_logic;
	  output : out std_logic_vector (4 downto 0));
end component;

component count_up_and_delay is
port (clk : in std_logic;
      delay_value : in natural range 0 to 1000;
      count_value : in natural range 0 to 1000;
	  output : out std_logic_vector (4 downto 0));
end component;

component var_clock_divider is
port (clk : in std_logic;
	  divider : in natural range 0 to 1000000000;
      clk_out : out std_logic);
end component;

component seven_segment_decoder is
port (input : in std_logic_vector (5 downto 0);
	  enable : in std_logic;
      seg_out : out std_logic_vector (7 downto 0));
end component;

component char_sequence_decoder is
port (input : in std_logic_vector(4 downto 0);
      output : out std_logic_vector(5 downto 0));
end component;

component buffer_6_bit is
port (clk : in std_logic;
      input : in std_logic_vector(5 downto 0);
      output : out std_logic_vector(5 downto 0));
end component;

component multiplexer_seven_segment_display is
port ( clk : in std_logic;
	   input_1, input_2, input_3, input_4 : in std_logic_vector (7 downto 0);
       seg_out : out std_logic_vector (7 downto 0);
	   anode_out : out std_logic_vector (3 downto 0));
end component;

signal count_to_18_output : std_logic_vector(4 downto 0);
signal clk_count_to_18, clk_char_seq : std_logic;
signal seg_a_input, seg_b_input, seg_c_input, seg_d_input : std_logic_vector(5 downto 0);
signal seg_a_to_mux, seg_b_to_mux, seg_c_to_mux, seg_d_to_mux : std_logic_vector(7 downto 0);
signal mux_sel : std_logic_vector(1 downto 0);
signal mux_clk_div : std_logic;
signal reset_signal : std_logic;

signal clk_div : std_logic;
--signal clk_div_delay : std_logic;

signal count_value : natural range 0 to 1000 := 18;
signal delay_value : natural range 0 to 1000 := 3;

signal seg_a_disable, seg_b_disable, seg_c_disable, seg_d_disable : std_logic;

begin

--reset_signal <= '1' when count_to_18_output = "10010" else
--                '0';
                
U5: var_clock_divider port map (clk => clk,
                                divider => 30000000,
                                clk_out => clk_div);
                                      
count_18: count_up_and_delay port map (clk => clk_div,
                                       delay_value => delay_value,
                                       count_value => count_value,
                                       output => count_to_18_output);

U1: char_sequence_decoder port map (input => count_to_18_output,
                                    output => seg_d_input);
      
buffer_a: buffer_6_bit port map (clk => clk_div,
                                 input => seg_d_input,
                                 output => seg_c_input);
buffer_b: buffer_6_bit port map (clk => clk_div,
                                 input => seg_c_input,
                                 output => seg_b_input);
buffer_c: buffer_6_bit port map (clk => clk_div,
                                 input => seg_b_input,
                                 output => seg_a_input);
                                 
seg_a_disable <= '0' when seg_a_input = "0000" else
                 '1';
seg_b_disable <= '0' when seg_b_input = "0000" else
                 '1'; 
seg_c_disable <= '0' when seg_c_input = "0000" else
                 '1';       
seg_d_disable <= '0' when seg_d_input = "0000" else
                 '1';
                 
SEG_A: seven_segment_decoder port map (input => seg_a_input,
                                       enable => seg_a_disable,
                                       seg_out => seg_a_to_mux);
SEG_B: seven_segment_decoder port map (input => seg_b_input,
                                       enable => seg_b_disable,
                                       seg_out => seg_b_to_mux);
SEG_C: seven_segment_decoder port map (input => seg_c_input,
                                       enable => seg_c_disable,
                                       seg_out => seg_c_to_mux);
SEG_D: seven_segment_decoder port map (input => seg_d_input,
                                       enable => seg_d_disable,
                                       seg_out => seg_d_to_mux);

M1: multiplexer_seven_segment_display port map (clk => clk,
                                                input_1 => seg_d_to_mux,
                                                input_2 => seg_c_to_mux,
                                                input_3 => seg_b_to_mux,
                                                input_4 => seg_a_to_mux,
                                                seg_out => seg_out,
                                                anode_out => anode_out);

end Behavioral;
