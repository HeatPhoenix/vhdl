library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port (A, B, C_in, clk, reset: in std_logic;
        C, C_out: out std_logic);
end entity full_adder;

architecture behaviour of full_adder is
  component half_adder is
    port (A, B: in std_logic; C, C_out: out std_logic);
  end component;

  component async_dff is
    port (D, dff_clk, dff_reset: in std_logic;
        Q, Qbar:       out std_logic);
  end component;
  signal S1, S2, S3, S4 : std_logic;
begin
  HA1: half_adder port map (A=>A, B=>B, C=>S1, C_out=>S2);
  HA2: half_adder port map (A=>S1, B=>C_in, C=>C, C_out=>S3);
  DFF: async_dff port map (D=>S4, dff_clk=>clk, dff_reset=>reset);
  S4 <= S2 or S3;
end behaviour;