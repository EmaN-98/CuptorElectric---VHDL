 library ieee;
 use ieee.std_logic_1164.all;
 use ieee.std_logic_arith.all;
 use ieee.std_logic_unsigned.all;
 
 entity Num is  
	
	 port(CLK, EN, Reset: in std_logic;
	 Cnt_out: out STD_LOGIC_VECTOR(7 downto 0));
 end Num;
 
 architecture arch_Numarator of Num is	

 signal Cnt: std_logic_vector(7 downto 0);
 begin
	 process(CLK, Reset)  
	 
	 begin
		 
		 if (Reset='1') then 
			 Cnt <= "00000000";	
		 elsif (CLK'event and CLK='1') then
			 if (EN='1') then 
				Cnt <= Cnt+1;
			 end if;			
		 end if;
	
	 end process;	   
	 Cnt_out <= Cnt;
	end arch_Numarator;