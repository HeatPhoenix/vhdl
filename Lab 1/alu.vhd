library ieee;
use ieee.numeric_bit.all;

entity alu is
  port (enable: bit;
	S, T: in bit_vector(7 downto 0);
	D: out bit_vector(7 downto 0));
end entity alu;

architecture behaviour of alu is
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
    signal s1, s2, s3: integer;
begin
 alu_process: process(S, T, enable)
 begin
    s1 <= to_integer(S);
    s2 <= to_integer(T);
    s3 <= s1 + s2;
    if(enable = '1') then
       D <= to_unsigned(s3, 4);
    end if;
 end process;    
end behaviour;
