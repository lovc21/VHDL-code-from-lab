library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

--jakob dekleva 

entity vmesnikZAtipke is
port (
	clk    :in std_logic ;
	t		:in std_logic;
	setadr : in unsigned(7 downto 0);
	rd		:in std_logic ;
	adr   :in unsigned(7 downto 0);
	izh	:out std_logic 
	);
end entity;

architecture  architecture_vmesnikZAtipke of vmesnikZAtipke is

type stanje is (mir, impulz, spusti);

signal st: stanje;



begin
	
    process(st,t,setadr,rd,adr) is
	 
    begin
	 
	if rising_edge(clk) then
		case st is 
		
			when mir => 
				if t = '1' then 
				st <= impulz; 
				end if; 
				
			when impulz => 
				if (rd = '1'  and  (adr = setadr) )then 
						st <= spusti; 
				end if;
	
			when spusti => 
				if t = '0' then 
					st <= mir; 
				end if; 
				
		end case; 
			
	
	 end if;
	 
  	if st = impulz then 
		izh <= '1';
	else
		izh <= '0';
	end if; 	
 
	 
    end process;
	 

	 
	 
end architecture_vmesnikZAtipke;