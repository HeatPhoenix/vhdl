library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture behaviour of testbench is
  component pipelined_mult is
  	port (A, X: in std_logic_vector(31 downto 0);
		clk, reset: in std_logic;
		P: out std_logic_vector(31 downto 0));
  end component;
  signal clk, reset: std_logic;
  signal A, X, P: std_logic_vector(31 downto 0);
begin
  clk_process: process
  begin
	clk <= '0';
	wait for 5 ns;
 	clk <= '1';
	wait for 5 ns;
  end process;
  input_process: process
  begin
	A <= "00000000000000000000000000000001";
	X <= "00000000000000000000000000001111";
	wait for 500 ns;
  end process;
  pm : pipelined_mult port map(A=>A, X=>X, clk=>clk, reset=>reset, P=>P);
end behaviour;
