library ieee;
use ieee.std_logic_1164.all;

entity clock is
  port (clk1, clk2 : out std_logic);
end entity clock;

architecture behaviour of clock is
begin
  clock_process: process is
  begin
    clk1 <= '0', '1' after 5 ns, '0' after 15 ns;
    clk2 <= '0', '1' after 5 ns, '0' after 10 ns, '1' after 15 ns;
    wait for 20 ns;
  end process clock_process;
end behaviour;