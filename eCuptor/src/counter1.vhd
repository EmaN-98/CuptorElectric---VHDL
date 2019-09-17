library IEEE;
use IEEE.std_logic_1164.all;   
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity COUNTn is 
	
	generic( n : natural :=2 );
 port(
		DIN	: in std_logic_vector(n-1 downto 0);
		CLK	: in std_logic;
		LOAD : in std_logic;
		DOUT : out std_logic_vector(n-1 downto 0)
	);

end COUNTn;

architecture behavior of COUNTn is

begin
  	
  	clk_proc:process(CLK)
  	variable COUNT:STD_LOGIC_VECTOR(7 downto 0) := "00000000";
  	begin 
  		if (CLK'EVENT AND CLK = '1') then
  			if LOAD = '1' then
  				COUNT := DIN;
  			else COUNT := COUNT + 1;
  			end if;
  		end if;
  		DOUT <= COUNT after 50 ns;
  	end process clk_proc;

end behavior;
