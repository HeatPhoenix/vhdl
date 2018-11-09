library ieee;
use ieee.std_logic_1164.all;

entity async_dff is
  port (D, clk, reset: in std_logic;
        Q, Qbar:       out std_logic);
end entity async_dff;

architecture behaviour of async_dff is
begin
  async_dff_process: process (clk, reset) is
  variable Qout : std_logic;
  begin
    if (reset='1') then
      Qout := '0';
    elsif (clk'event and clk='1') then
      Qout := D;
    end if;
    Q <= Qout;
    Qbar <= not Qout;
  end process async_dff_process;
end behaviour;
