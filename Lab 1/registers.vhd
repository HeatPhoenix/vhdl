library ieee;
use ieee.math_real.all;

entity registers is
  port (store, en, output: in bit;
	loc, loc_s, loc_t: in bit_vector(3 downto 0);
	mem_input, alu_input: in bit_vector(7 downto 0);
	output_d, output_s, output_t: out bit_vector(7 downto 0));
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
    register_process: process (en, store, loc, loc_s, loc_t, mem_input, alu_input)
    begin
	if(en = '1') then
		if(store = '1') then
			reg(to_integer(loc)) <= mem_input;
		elsif(output = '1') then
			output_d <= reg(to_integer(loc));
		else
			output_s <= reg(to_integer(loc_s));
			output_t <= reg(to_integer(loc_t));
			reg(to_integer(loc)) <= alu_input;
		end if;
	end if;
 -- TODO add register declarations
    end process;
end ;
