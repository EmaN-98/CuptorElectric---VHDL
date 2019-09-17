library IEEE;								
use IEEE.STD_LOGIC_1164.ALL;				
											
entity SAU is	  			
	port ( A, B:  in STD_LOGIC;
		      Y: out STD_LOGIC);	
end SAU;

architecture comportamental of SAU is		 
begin
	Y <= A or B;
end architecture;	