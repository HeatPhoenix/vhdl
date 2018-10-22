library ieee;
use ieee.math_real.all;

entity registers is
  port (store, clk, en: in bit;
	loc: in bit_vector(3 downto 0);
	input: in bit_vector(7 downto 0);
	output_s, output_t: out bit_vector(7 downto 0));
end entity registers;

architecture behaviour of registers is
    function to_integer(input : bit_vector) return integer is
	variable output : integer;
    begin
	output := 0;
	for i in input'range loop
	    if(input(i) = '1') then
		output := (output + 2 ** i);
	    end if;
	end loop;
	return output;
    end to_integer;
    type register_array is array (0 to 15) of bit_vector(7 downto 0);
    signal reg : register_array;
begin
    register_process: process (clk, en, store, loc, imm)
    begin
	if(rising_edge(clk) and en = '1') then
		if(store = '1') then
			reg(to_integer(loc)) <= imm;
		else
			output <= reg(to_integer(loc));
		end if;
	end if;
 -- TODO add register declarations
    end process;
end registers;
