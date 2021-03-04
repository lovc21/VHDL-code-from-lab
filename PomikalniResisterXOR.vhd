library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- jakob dekleva 
-- točka 3  

entity PomikalniResisterXOR is

port ( 
	set   : in std_logic; -- inputi 1 b
	
   clk : in std_logic;  

	izhod   : out std_logic_vector(3 downto 0) -- izhod 4 b 
	
 );
end PomikalniResisterXOR; 

architecture struktura_PomikalniResisterXOR of PomikalniResisterXOR is 

signal s3 : std_logic;
signal s2 : std_logic;
signal s1 : std_logic;
signal s0 : std_logic;



	begin 
		process(clk,set)
		
			begin 
				if rising_edge(clk) then
				if set =  '1' then 
				
				s0 <= '1';
				s1 <= '0';
				s2 <= '0';
				s3 <= '0';
				
				else 
				s3 <= s3 xor s0;
				s2 <= s3;
				s1 <= s2;
				s0 <= s1; 
				 
				end if; 
				end if; 

		
		end process;
		
		
	izhod <= s3 & s2 & s1 & s0;
	end struktura_PomikalniResisterXOR; 