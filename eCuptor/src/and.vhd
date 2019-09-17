LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY ANDn IS
GENERIC (nr : INTEGER := 2);
PORT (intrari : IN STD_LOGIC_VECTOR(1 TO nr);
iesire : OUT STD_LOGIC);
END ANDn;

ARCHITECTURE dataflow OF ANDn IS
SIGNAL t : STD_LOGIC_VECTOR(1 TO nr);
BEGIN
t <= (OTHERS => '1');
iesire <= '1' WHEN intrari = t ELSE '0';
END dataflow;