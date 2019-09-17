   library IEEE;
use IEEE.std_logic_1164.all;


entity entProiect is
  port(
       Clock : in std_ulogic;
       IA : out std_ulogic;   
       Resett : in STD_LOGIC;
       Temp : in STD_LOGIC_VECTOR(7 downto 0);
       START : in std_ulogic; 
       PI : out std_ulogic;	
       OPRIRE : out std_ulogic;	 
       C : out std_ulogic;			
	   SIGURANTA : out std_ulogic;	 
	   VALOARE_NEPERMISA: out std_ulogic
	   
      
  );
end entProiect;

architecture archProiect of entProiect is

   component ANDn is	  					   	 
	   GENERIC (nr : INTEGER := 2);
	PORT (intrari : IN STD_LOGIC_VECTOR(1 TO nr);
		  iesire : OUT STD_LOGIC);
   end component;
   
 	
   
   component compare is
	   port( num1 : in std_logic_vector(7 downto 0);  
      		num2 : in std_logic_vector(7 downto 0);  
      		less : out std_logic;   
      		equal : out std_logic;  
      		greater : out std_logic);
   end component;
   
   component Num is
	  
 	port( Reset	: in std_logic;
	 	CLK	: in std_logic;
	 	EN: in std_logic;
		 Cnt_out : out std_logic_vector(7 downto 0));
	end component;


	signal NEET, NET1, NETL1, NETE1, NETG1, IA2, PI2, NETL2, NETE2, NETG2, NETV, NETcount0, NETcount1, NETcount2, NETcount3, NETcount4,
	NETcount5, NETcount6, NETcount7, NSTART, NETL3, NETG3, NETE3, NNETE3, NET02, NET30, NET05, NET06, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, 
	S0, S1, S2, S3, S4, S5, S6, S7, NQ0, NQ5, NQ7, NQ6, NNET06, NS1, NS3, NS4, NS5, NS6, NS7, NNET30: std_logic;	 
	
begin	
	
	
  	 NET1 <= Clock and START;
A1 : compare
	port map( num1=> "01100011" ,
			num2(0)=> Temp(0), num2(1)=> Temp(1), num2(2)=> Temp(2), num2(3)=> Temp(3), num2(4)=> Temp(4), num2(5)=> Temp(5), num2(6)=> Temp(6), num2(7)=> Temp(7),
			less=> NETL1, greater=> NETG1, equal => NETE1 );  -- verifica daca temp este mai mare de 100 grade
						
A2 : compare
	port map( num1=> "11001001" ,
			num2(0)=> Temp(0), num2(1)=> Temp(1), num2(2)=> Temp(2), num2(3)=> Temp(3), num2(4)=> Temp(4), num2(5)=> Temp(5), num2(6)=> Temp(6), num2(7)=> Temp(7),
			less=> NETL2, greater=> NETG2, equal => NETE2 );  -- verifica daca temp este mai mica de 200 grade
			
  
    NETV <= NETL1 and NETG2;	 --verifica daca temp este mai mare decat 100 si mai mica decat 200
  
	VALOARE_NEPERMISA <= not(NETV);
	
	NNETE3 <= not(NETE3);
	
	NEET <= NET1 and NETV;
	

A3 : Num					 
	port map( Reset=> Resett, CLK=> NEET, EN=> NNETE3, Cnt_out(0)=> NETcount0, Cnt_out(1)=> NETcount1, Cnt_out(2)=> NETcount2,
	Cnt_out(3)=> NETcount3, Cnt_out(4)=> NETcount4, Cnt_out(5)=> NETcount5, Cnt_out(6)=> NETcount6, Cnt_out(7)=> NETcount7);
	
 

A4: compare
	port map(num1(0)=>NETcount0, num1(1)=>NETcount1, num1(2)=>NETcount2, num1(3)=>NETcount3, num1(4)=>NETcount4, num1(5)=>NETcount5, num1(6)=>NETcount6, num1(7)=>NETcount7,
	num2(0)=> Temp(0), num2(1)=> Temp(1), num2(2)=> Temp(2), num2(3)=> Temp(3), num2(4)=> Temp(4), num2(5)=> Temp(5), num2(6)=> Temp(6), num2(7)=> Temp(7),
	less=> NETL3, greater=> NETG3, equal=> NETE3);
	
    PI2 <= not(NETE3) and START and NETV;
	PI <=PI2;
	IA2 <= NETE3 and (not(NET06)) and (not(NET30));	
	IA<=IA2;
	
	
	
A5 : ANDn
	generic map(nr=>3)
  port map( intrari(1) => NSTART , intrari(2) => Clock , intrari(3) => IA2, iesire => NET02 );

A6 : Num
	port map( Reset=> Resett, CLK=> NET02, EN=> NNET30, Cnt_out(0)=> Q0, Cnt_out(1)=> Q1, Cnt_out(2)=> Q2,
	Cnt_out(3)=> Q3, Cnt_out(4)=> Q4, Cnt_out(5)=> Q5, Cnt_out(6)=> Q6, Cnt_out(7)=> Q7);
	
	
	NNET30 <= not(NET30);
	
	NQ0 <= not(Q0);
	NQ5 <= not(Q5);
	NQ6 <= not(Q6);
	NQ7 <= not(Q7);		
	
A7 : ANDn
	generic map(nr=>8)
  port map( intrari(1) => NQ0 , intrari(2) => Q1 , intrari(3) => Q2, intrari(4) => Q3, intrari(5) => Q4, intrari(6) => NQ5,
  intrari(7) => NQ6, intrari(8) => NQ7, iesire => NET30 ); 
  
  	
	C <= NNET30 and IA2 and (not(PI2)) and (not(START));
	OPRIRE <= NET30;


A8 : ANDn
	generic map(nr=>3)
	port map(intrari(1) => Clock, intrari(2) =>START, intrari(3) => IA2, iesire => NET05);
	
	
	NNET06 <= not(NET06);		  
	NSTART <= not(START);
	
A9 : Num
	port map( Reset=> Resett, CLK=> NET05, EN=> NNET06, Cnt_out(0)=> S0, Cnt_out(1)=> S1, Cnt_out(2)=> S2,
	Cnt_out(3)=> S3, Cnt_out(4)=> S4, Cnt_out(5)=> S5, Cnt_out(6)=> S6, Cnt_out(7)=> S7);
	
	
	NS1 <= not(S1);
	NS3 <= not(S3);
	NS4 <= not(S4);
	NS5 <= not(S5);
	NS6 <= not(S6);
	NS7 <= not(S7);
	
A10 : ANDn
generic map(nr=>8)
	port map(intrari(1) => S0, intrari(2) => NS1, intrari(3) => S2, intrari(4) => NS3, intrari(5) => NS4, intrari(6) => NS5,
	intrari(7) => NS6, intrari(8) => NS7, iesire => NET06);
	
	
	SIGURANTA <= NET06;
 																									

end archProiect;