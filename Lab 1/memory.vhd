library ieee;
use ieee.math_real.all;

entity memory is
  port (store, en, store_reg: in bit;
	loc: in bit_vector(3 downto 0);
	imm, reg_input: in bit_vector(7 downto 0);
	output: out bit_vector(7 downto 0));
end entity memory;

architecture behaviour of memory is
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
    type memory_array is array (0 to 15) of bit_vector(7 downto 0);
    signal mem : memory_array;
begin
    memory_process: process (en, store, loc, imm, reg_input)
    begin
	if(en = '1') then
		if(store = '1') then
			mem(to_integer(loc)) <= imm;
		elsif(store_reg = '1') then
			mem(to_integer(loc)) <= reg_input;
		else
			output <= mem(to_integer(loc));
		end if;
	end if;
 -- TODO add memory declarations
    end process;
end behaviour;
