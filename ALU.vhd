library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- jakob dekleva 

entity ALU is

port ( 
	A,B : in std_logic_vector(3 downto 0); -- inputi 4 b
	
	OP : in std_logic_vector(1 downto 0);			--določanje operacije 2b
	
	rez : out std_logic_vector(4 downto 0) -- izhod 4 b 
 );
end ALU; 

architecture struktura_ALU of ALU is 

	signal izhod_alu : std_logic_vector (4 downto 0);
	
	
	begin 
		process(A,B,OP)
		begin 
			case(OP) is
			
			when "00" => izhod_ALU <=  std_logic_vector(('0' & unsigned(A)) + ('0' & unsigned(B)) ); -- seštevanje 
			
			when "01" => izhod_ALU <= std_logic_vector(('0' &  unsigned(A)) - ('0' & unsigned(B)) ); -- odštevanje 
			
			when "10" => izhod_ALU <= A and B & '0'; --and 
			
			when "11" => izhod_ALU <= A or B & '0' ; --or 
			
			when others => izhod_ALU <= (others => 'X');
			
			end case; 
			
	end process; 
	
	rez <= izhod_ALU; 
	
	end struktura_ALU; 