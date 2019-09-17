library IEEE;								
use IEEE.std_logic_1164.ALL;				
											
entity INV is	  			
	port ( X:  in STD_LOGIC;
		  nX: out STD_LOGIC);	
end INV;

architecture comportamental of INV is		
begin
	nX <= not (X);
end architecture; 