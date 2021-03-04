library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

--jakob dekleva 

entity Sinusni_generator is
port (
	 m 		:in unsigned(3 downto 0);
    clk    :in std_logic
    --amp    :out signed(7 downto 0)
);
end entity;

architecture  architecture_Sinusni_generator of Sinusni_generator is

-- (X"00", X"30", X"5A", X"76", X"7F", X"76", X"5A", X"31", X"00", X"-30", X"-5A", X"-76", X"-7F", X"-76", X"-5A", X"-30")

	signal a : unsigned(3 downto 0) :="0000";
	signal notranji : unsigned(3 downto 0) :="0000";
	signal prehod : std_logic :='0';
	type  rom16u8 is array (0 to 15) of signed(7 downto 0);
	signal sin : rom16u8 ; 
	signal r:signed(8 downto 0);
	signal ofset:signed(8 downto 0);
	signal izhod: signed(7 downto 0);



begin
	sin(0) <= X"00" ;
	sin(1) <=  X"30";
	sin(2) <= X"5A" ;
	sin(3) <= X"76" ;
	sin(4) <= X"7F" ;
	sin(5) <=X"76" ;
	sin(6) <=  X"5A";
	sin(7) <= X"31";
	sin(8) <= X"00";
	sin(9) <= -X"30";
	sin(10) <= - X"5A";
	sin(11) <= - X"76";
	sin(12) <= - X"7F";
	sin(13) <= - X"76";
	sin(14) <= - X"5A";
	sin(15) <= - X"30";
	
    process(clk,prehod,notranji,m,a,ofset,r,izhod) is
    begin
	 
    if rising_edge(clk) then
	 
	 notranji <= notranji + 1;
		  
		if notranji >= m  then
			notranji <= "0000";
			end if; 
			
			if prehod = '1' then

			a <= a + 1;
			
			end if; 
			
	 end if;
		  
		if notranji = m  then
			prehod <= '1';
			else prehod <= '0';
			
			end if; 	
			
	r <= resize(sin(to_integer(a)),9) + resize(ofset,9);
	
		if r > X"7F" then 
		
			izhod <= X"7F";
			
		elsif r < -X"80"then 
		
			izhod <= -X"80";
			
		else izhod <= resize(r,8);
		
		end if; 
		
    end process;
	 
	 



end architecture_Sinusni_generator;