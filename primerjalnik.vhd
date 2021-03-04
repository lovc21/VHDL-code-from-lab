library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity primerjalnik is


port (
	A,B: in signed(15 downto 0); -- Inputi 16 b 
	
	max: out signed(15 downto 0) ; -- največja vrednost
	
	enaka: out std_logic;-- če sta enaka 
	
	nicla: out std_logic-- če sta oba dva niče
	
	);
end primerjalnik ;


architecture struktura_primerjalnika of primerjalnik  is
	signal tmp: signed(15 downto 0); 

	-- začasen signal 
begin

	max <= A when A > B else 
			 B when B > A else 
			 A when A = B ;		  
	
	enaka <= '1' when A = B else '0';

	tmp <= A when A > B else 
			 B when B > A else 
			 B when A = B ;

	
	nicla <= '1' when unsigned(tmp) = 0 else '0';
	
end struktura_primerjalnika;