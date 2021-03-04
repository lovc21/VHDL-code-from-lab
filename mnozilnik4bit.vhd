library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- jakob dekleva 

entity mnozilnik4bit is

port ( 
	A : in std_logic_vector(3 downto 0); -- inputi 4 b
	
	B : in std_logic_vector(3 downto 0); -- inputi 2 b
	
	m : out std_logic_vector(7 downto 0) -- izhod 4 b 
	
 );
end mnozilnik4bit; 

architecture struktura_mnozilnik4bit of mnozilnik4bit is 

signal p1 : std_logic_vector (7 downto 0);
signal p2 : std_logic_vector (7 downto 0);
signal p3 : std_logic_vector (7 downto 0);
signal p4 : std_logic_vector (7 downto 0);


	begin 
	
	process(A,B)
	
		begin
		
			if B(0) = '0' then p1 <= "00000000" ;
			
			else  p1 <= ("0000" & A);
			
			if B(1) = '0' then p2 <= "00000000" ;
			
			else  p2 <= (("000" & A) & '0');
			
			if B(2) = '0' then p3 <= "00000000" ;
			
			else  p3 <= (("00" & A) & "00");
			
			if B(3) = '0' then p4 <= "00000000" ;
			
			else  p4 <= (("0" & A) & "000");		
		
		end if; 
		end if;
		end if;
		end if;
		
	end process; 
	
	m <= p1 + p2 + p3 + p4;		
			
	end struktura_mnozilnik4bit; 