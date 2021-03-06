library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture behaviour of testbench is
  component pipelined_mult is
    port (A, X: in std_logic_vector(1 downto 0);
	clk, reset: in std_logic;
	P: out std_logic_vector(3 downto 0));
  end component;

  signal A, X: std_logic_vector(1 downto 0);
  signal P: std_logic_vector(3 downto 0);
  signal clk, reset: std_logic;
begin
  clk_process: process
  begin
	clk <= '0';
	wait for 2 ns;
 	clk <= '1';
	wait for 3 ns;
  end process;
  A_process: process
  begin
	A <= "00";
	wait for 25 ns;
	A <= "01";
	wait for 25 ns;
	A <= "10";
	wait for 25 ns;
	A <= "11";
	wait for 25 ns;
  end process;
  X_process: process
  begin
	X <= "00";
	wait for 5 ns;
	X <= "01";
	wait for 5 ns;
	X <= "10";
	wait for 5 ns;
	X <= "11";
	wait for 5 ns;
  end process;
  reset_process: process
  begin
	reset <= '0';
	wait for 99 ns;
	reset <= '1';
	wait for 1 ns;
  end process;
  PM1: pipelined_mult port map(A=>A, X=>X, clk=>clk, reset=>reset, P=>P);
end behaviour;
