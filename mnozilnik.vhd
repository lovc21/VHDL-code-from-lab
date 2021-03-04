library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- jakob dekleva 

entity mnozilnik is

port ( 
	A : in std_logic_vector(3 downto 0); -- inputi 4 b
	
	B : in std_logic_vector(1 downto 0); -- inputi 2 b
	
	m : out std_logic_vector(5 downto 0) -- izhod 4 b 
	
 );
end mnozilnik; 

architecture struktura_mnozilnik of mnozilnik is 

signal p1 : std_logic_vector (3 downto 0);


	begin 
	
	process(A,B)
	
		begin
		
			if B(0) = '0' then p1 <= "0000" ;
			
			else  p1 <= A;
		
		end if; 
		
	end process; 
	
	m <= ("00" & p1)+('0' & A & '0');		
			
			
	 
	end struktura_mnozilnik; 