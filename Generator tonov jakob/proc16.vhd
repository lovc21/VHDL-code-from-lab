library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity proc16 is
  Port ( clk : in std_logic;         
         pin : in unsigned (15 downto 0);  -- input port
         adr : out unsigned (7 downto 0);
         pout: out unsigned (15 downto 0);
         we, rd: out std_logic
		 );
end proc16;

architecture Opis of proc16 is  
 constant ce: std_logic := '1';
 constant rst: std_logic := '0';
 
 signal datacpu: unsigned(15 downto 0);
 signal address: unsigned (11 downto 0);
 signal wren: std_logic;
 
 signal dataram: std_logic_vector(15 downto 0);
begin

 pout <= datacpu;
 
 ram: entity work.program port map (
   clock => clk,
	clken => ce, 
   address => std_logic_vector(address), 
	data => std_logic_vector(datacpu), 
	wren => wren, 
	q => dataram);
 
 cpu: entity work.cpu16 port map (
   clk => clk,
	ce => ce,
	rst => rst,
	data => unsigned(dataram),
	pin => pin,	
   adr => address, 
	we => wren,
	datout => datacpu,
   padr=> adr,
	weout => we,
	rdout => rd
 );
 
end Opis;