library ieee;
use ieee.std_logic_1164.all;

entity pipelined_mult is
  port (A, X: in std_logic_vector(31 downto 0);
	clk, reset: in std_logic;
	P: out std_logic_vector(31 downto 0));
end entity pipelined_mult;

architecture behaviour of pipelined_mult is
  component latched_adder is
    port (A, And_in, B, C_in, clk, reset: in std_logic; CQ, CoutQ, A_out: out std_logic);
  end component;
  component async_dff is
    port (D, clk, reset: in std_logic; Q, Qbar: out std_logic);
  end component;
  signal inter_add : std_logic;
  type intermediate_signals is array (0 to 31) of std_logic_vector(31 downto 0);
  type intermediate_dff_signals is array (0 to 31) of std_logic_vector(30 downto 0);
  signal inter_loop_latch, inter_loop_sum_out, inter_loop_carry_out: intermediate_signals;
  signal dff_array : intermediate_dff_signals;
begin
  outerloop : for i in 0 to 31 generate
  begin
	sumloop: for j in 0 to 31 generate -- The block of full adders in the 5x5 example on the top left
  	begin
		first : if (i = 0 and j < 31) generate -- Take first inputs, excvluding the last adder
  			for fa: latched_adder use entity WORK.latched_adder(latched_and);
  		begin
			fa: latched_adder port map(
				A=>A(j),
				And_in=>X(i),
				B=>'0',
				C_in=>'0',
				clk=>clk,
				reset=>reset,
				CQ=>inter_loop_sum_out(i)(j),
				CoutQ=>inter_loop_carry_out(i)(j),
				A_out=>inter_loop_latch(i)(j)
			);
		end generate first;
		first_nand : if (i = 0 and j = 31) generate -- Last adder which takes direct input
  			for fa: latched_adder use entity WORK.latched_adder(latched_nand);
  		begin
			fa: latched_adder port map(
				A=>A(j),
				And_in=>X(i),
				B=>'0',
				C_in=>'0',
				clk=>clk,
				reset=>reset,
				CQ=>inter_loop_sum_out(i)(j),
				CoutQ=>inter_loop_carry_out(i)(j),
				A_out=>inter_loop_latch(i)(j)
			);
		end generate first_nand;
		other_and : if (i > 0 and i < 31 and j < 31) generate -- Intermediate full adders with and gates
  			for fa: latched_adder use entity WORK.latched_adder(latched_and);
  		begin
			fa: latched_adder port map(
				A=>inter_loop_latch(i-1)(j),
				And_in=>dff_array(i-1)(i-1),
				B=>inter_loop_carry_out(i-1)(j),
				C_in=>inter_loop_sum_out(i-1)(j + 1),
				clk=>clk,
				reset=>reset,
				CQ=>inter_loop_sum_out(i)(j),
				CoutQ=>inter_loop_carry_out(i)(j),
				A_out=>inter_loop_latch(i)(j)
			);
		end generate other_and;
		other_nand : if (i > 0 and i < 31 and j = 31) generate -- Intermediate full adders with nand gates
  			for fa: latched_adder use entity WORK.latched_adder(latched_nand);
  		begin
			fa: latched_adder port map(
				A=>inter_loop_latch(i-1)(j),
				And_in=>dff_array(i-1)(i-1),
				B=>inter_loop_carry_out(i-1)(j),
				C_in=>'0',
				clk=>clk,
				reset=>reset,
				CQ=>inter_loop_sum_out(i)(j),
				CoutQ=>inter_loop_carry_out(i)(j),
				A_out=>inter_loop_latch(i)(j)
			);
		end generate other_nand;
		last_nand : if (i = 31 and j < 31) generate -- Last row of adders where the most are nand gates
  			for fa: latched_adder use entity WORK.latched_adder(latched_nand);
  		begin
			fa: latched_adder port map(
				A=>inter_loop_latch(i-1)(j),
				And_in=>dff_array(i-1)(i-1),
				B=>inter_loop_carry_out(i-1)(j),
				C_in=>inter_loop_sum_out(i-1)(j + 1),
				clk=>clk,
				reset=>reset,
				CQ=>inter_loop_sum_out(i)(j),
				CoutQ=>inter_loop_carry_out(i)(j),
				A_out=>inter_loop_latch(i)(j)
			);
		end generate last_nand;
		last_and : if (i = 31 and j = 31) generate -- Last row of adders where the last is an and gate
  			for fa: latched_adder use entity WORK.latched_adder(latched_and);
  		begin
			fa: latched_adder port map(
				A=>inter_loop_latch(i-1)(j),
				And_in=>dff_array(i-1)(i-1),
				B=>inter_loop_carry_out(i-1)(j),
				C_in=>'0',
				clk=>clk,
				reset=>reset,
				CQ=>inter_loop_sum_out(i)(j),
				CoutQ=>inter_loop_carry_out(i)(j),
				A_out=>inter_loop_latch(i)(j)
			);
		end generate last_and;
	end generate sumloop;
	latchloop: for j in 0 to 30 generate
  	begin -- something goes wrong here, check FA of level 4 or 5 input in simulation
		input_latch : if(i = 0) generate
		begin
			input_dff: async_dff port map (D=>X(j + 1), clk=>clk, reset=>reset, Q=>dff_array(i)(j));
		end generate input_latch;
		sum_latch : if(i > 0 and j = 0) generate
		begin
			input_dff: async_dff port map (D=>inter_loop_sum_out(i - 1)(0), clk=>clk, reset=>reset, Q=>dff_array(i)(j));
		end generate sum_latch;
		intermediate_latch : if(i > 0 and j > i) generate
		begin
			input_dff: async_dff port map (D=>dff_array(i - 1)(j), clk=>clk, reset=>reset, Q=>dff_array(i)(j));
		end generate intermediate_latch;
		intermediate_sum_latch : if(i > 0 and j > 0 and j <= i) generate
		begin
			input_dff: async_dff port map (D=>dff_array(i - 1)(j - 1), clk=>clk, reset=>reset, Q=>dff_array(i)(j));
		end generate intermediate_sum_latch;
	end generate latchloop;
  end generate outerloop;
end behaviour;
