library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
  port (A, B: in std_logic;
        C, C_out: out std_logic);
end entity half_adder;

architecture behaviour of half_adder is
begin
  half_adder_process: process (A, B) is
  begin
    C <= A xor B;
    C_out <= A and B;
  end process half_adder_process;
end behaviour;