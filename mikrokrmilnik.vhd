library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

--jakob dekleva 
-- prva vrednosti ("0001 00000011", "1000 00000100","01000 0000001","0000 00001010","0000 00000101"); 
-- druga vrednosti  ("0001 00000100", "1001 00000101","0101 00000010","0100 00000001","0000 00001010","0000 00000010")
-- tretja vrednosti ("0001 00000100", "1000 00000100","0010 00000100","01000 0000001","0000 00001010"); 
-- četrta vrednosti ("0011 00000000", "1000 00000100", "0111 00000000","0100 00000000", "0000 00000001")

-- prva ukazna u romu  "0001 0000011" 0001 -> izvede zapis  00000011 -> gre  vzame tretjo v romu 
-- negacija komanda ("0000 00000000") na drugem mestu v romu 
-- in komanda      ("1100 00000100") na drugem mestu v romu/ 100 pogleda četrto mesto za zacasniN
-- ali komanda       ("1101 00000100") na drugem mestu v romu/ 100 pogleda četrto mesto za zacasniN

entity mikrokrmilnik is
port (
	clk    :in std_logic ;
	PIN 		:in unsigned(11 downto 0) := "000000000011";
	POUT 	:out unsigned(11 downto 0) := "000000000000"
	);
end entity;

architecture  architecture_mikrokrmilnik of mikrokrmilnik is

signal t : unsigned(3 downto 0) :="0000";

signal adr : unsigned(7 downto 0) := "00000000";

signal data : unsigned(11 downto 0);

type  memory is array (0 to 4) of unsigned(11 downto 0);

signal ROM: memory :=(x"103" ,"110100000100", x"400",x"00C",x"001"); 

signal ukaz : unsigned(3 downto 0);

signal akumulator : unsigned(11 downto 0) := "000000000000";

signal n : unsigned(7 downto 0);

signal we: bit:= '0';

signal delilnik :unsigned (1 downto 0) := "00";

signal zacasniN :unsigned(11 downto 0);  

begin

	data <= ROM(to_integer(adr));
	ukaz <= data(11 downto 8);
	n <= data(7 downto 0);
	zacasniN <= ROM(to_integer(n));
	
	
    process(t,adr,data,ROM,clk,n,akumulator,ukaz,we,delilnik,zacasniN) is
	 
	
	 
    begin
	 
	 
	if rising_edge(clk) then
	
	
	 t <= t + 1; 
	 
	 if ukaz = "0010" then
	 
			we <= '1';
			
		end if;
		
		
	if delilnik = "01" then 
	 
				case ukaz is 
				
					when "0001" => 
							akumulator <= zacasniN;
							adr <= adr +1;
							--we <= '0' ;
				 
					when "0100" => 
							adr <=  n; 
							--we <= '0' ;
					
					when "1000" => 
							akumulator <= akumulator + zacasniN;
							adr <= adr +1;
							--we <= '0' ;
					
					when "1001" =>
							if (akumulator > 0) then 
							akumulator <= akumulator - 2;
							--we <= '0' ;
							end if;
				
					when "0101" => 
							if (akumulator = 0) then
							--we <= '0' ;
							end if; 
							
					when "0010" =>
							ROM(to_integer(n)) <= akumulator;
							adr <= adr + 1;
							--we <= '1';
							
					when "0011" => 
							akumulator <= PIN;
							adr <= adr + 1;
							--we <= '0' ;
							
					when "0111" => 
							POUT <= akumulator; 
							adr <= adr + 1;
							--we <= '0' ;
				
					--mini projekt negacija / ali / in
					
					
					--logična funkcija not
					when "0000" => 
							akumulator <= not akumulator; 
							adr <= adr +1; 
							--we <= '0' ;
							
					--	logična funkcija and	
					when "1100" => 
							akumulator <= akumulator and zacasniN;
							adr <= adr + 1;
						   --we <= '0' ;
							
					--logična funkcija or
					when "1101" => 
							akumulator <= akumulator or zacasniN; 
							adr <= adr + 1; 
							--we <= '0' ;
							
		when others => 
						null;
						--we <= '0' ;
		end case ;

					we <= '0';
					
					else 
			
					delilnik <= delilnik +1 ; 
				
					end if;
					
			end if;
			
	
	 
  
    end process;

end architecture_mikrokrmilnik;