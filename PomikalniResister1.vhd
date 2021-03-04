library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- jakob dekleva 
-- točka 4 

entity PomikalniResister1 is

port ( 
	set   : in std_logic; -- inputi 1 b
	
   clk : in std_logic;  

	izhod   : out std_logic_vector(3 downto 0) -- izhod 4 b 
	
 );
end PomikalniResister1; 

architecture struktura_PomikalniResister1 of PomikalniResister1 is 

signal s3 : std_logic:='0';
signal s2 : std_logic:='0';
signal s1 : std_logic:='0';
signal s0 : std_logic:='1';



	begin 
		process(clk,set)
		
			begin 
				if rising_edge(clk) then
				
		
				s2 <= s3;
				s1 <= s2;
				s0 <= s1; 
				s3 <= s0; 
	 
				end if; 

		
		end process;
			
	izhod <= s3 & s2 & s1 & s0;
	
	end struktura_PomikalniResister1; 