library ieee;
use ieee.numeric_bit.all;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity alu is
  port (en: bit;
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
    function to_bitvector(input : integer) return bit_vector is
	variable output : bit_vector(7 downto 0);
	variable input_cpy : integer;
    begin
	output := "00000000";
	input_cpy := input;
	for i in 7 downto 0 loop
	    if(input_cpy >= 2 ** i) then
		input_cpy := input_cpy - 2 ** i;
		output(i) := '1';
	    end if;
	end loop;
	return output;
    end to_bitvector;
begin
 alu_process: process(S, T, en)
    variable s1, s2, s3: integer;
 begin
    if(en = '1') then
      s1 := to_integer(S);
      s2 := to_integer(T);
      s3 := s1 + s2;
      D <= to_bitvector(s3);
    end if;
 end process;    
end behaviour;
