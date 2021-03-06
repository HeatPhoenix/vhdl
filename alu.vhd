library ieee;
use ieee.math_real.all;

entity alu is
  port (S, T: in bit_vector(7 downto 0);
	D: out bit_vector(7 downto 0));
end entity alu;

architecture behaviour of alu is
    function to_integer(input : bit_vector) return integer is
	variable output : integer;
	begin
	    output := 0;
	    for i in input'range loop
		output := output + (input(i) * (2.0**i));
	    end loop;
	    return output;
	end to_integer;
    signal s1, s2, s3: integer;
begin
    s1 <= to_integer(S);
    s2 <= to_integer(T);
    s3 <= s1 + s2;
    D <= to_vector(s3);
end behaviour;
