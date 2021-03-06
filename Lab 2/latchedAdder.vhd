library ieee;
use ieee.std_logic_1164.all;

entity latched_adder is
  port (A, And_in, B, C_in, clk, reset: in std_logic;
        CQ, CoutQ, A_out: out std_logic);
end entity latched_adder;

architecture behaviour of latched_adder is
  component full_adder is
    port (A, B, C_in: in std_logic; C, C_out: out std_logic);
  end component;
  component async_dff is
    port (D, clk, reset: in std_logic; Q, Qbar: out std_logic);
  end component;
  signal S1, S2 : std_logic;
begin
  FA1: full_adder port map (A=>A, B=>B, C_in=>C_in, C=>S1, C_out=>S2);
  REG1: async_dff port map (D=>S1, clk=>clk, reset=>reset, Q=>CQ);
  REG2: async_dff port map (D=>S2, clk=>clk, reset=>reset, Q=>CoutQ);
end behaviour;

architecture latched_and of latched_adder is
  component full_adder is
    port (A, B, C_in: in std_logic; C, C_out: out std_logic);
  end component;
  component async_dff is
    port (D, clk, reset: in std_logic; Q, Qbar: out std_logic);
  end component;
  signal S1, S2, S3 : std_logic;
begin
  S3 <= A and And_in;
  BUF1: async_dff port map (D=>A, clk=>clk, reset=>reset, Q=>A_out);
  FA1: full_adder port map (A=>S3, B=>B, C_in=>C_in, C=>S1, C_out=>S2);
  REG1: async_dff port map (D=>S1, clk=>clk, reset=>reset, Q=>CQ);
  REG2: async_dff port map (D=>S2, clk=>clk, reset=>reset, Q=>CoutQ);
end latched_and;

architecture latched_nand of latched_adder is
  component full_adder is
    port (A, B, C_in: in std_logic; C, C_out: out std_logic);
  end component;
  component async_dff is
    port (D, clk, reset: in std_logic; Q, Qbar: out std_logic);
  end component;
  signal S1, S2, S3 : std_logic;
begin
  S3 <= A nand And_in;
  BUF1: async_dff port map (D=>A, clk=>clk, reset=>reset, Q=>A_out);
  FA1: full_adder port map (A=>S3, B=>B, C_in=>C_in, C=>S1, C_out=>S2);
  REG1: async_dff port map (D=>S1, clk=>clk, reset=>reset, Q=>CQ);
  REG2: async_dff port map (D=>S2, clk=>clk, reset=>reset, Q=>CoutQ);
end latched_nand;
