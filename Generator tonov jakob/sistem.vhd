-- Projekt: Modul B, 2020
-- Sistem s procesorjem in delilnikom ure

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sistem is
 port (
 
   clk: in std_logic;
   pwm : out std_logic 
	
 );
end sistem;

architecture RTL of sistem is
 -- virtualne tipke, 4-bit
 signal source: std_logic_vector(3 downto 0) := "0000";
 
 -- izhodni register iz CPU, 16-bit
 signal reg16: unsigned(15 downto 0) := "0000000000000000";

 -- povezovalni signali za procesor in vmesnik
 signal pin,pout: unsigned(15 downto 0);
 signal rd,we: std_logic := '0';
 signal adr: unsigned(7 downto 0);
 signal izh1,izh2,izh3,izh4,pwmsignal: std_logic := '0' ;
 signal stevec:  unsigned(15 downto 0):="0000000000000000";
 
 -- komponenta za virtualne tipke
 component vio is
 	port (source : out std_logic_vector(3 downto 0));
 end component;
  
 -- vektor za deljenje ure in notranji urni signal
 --signal d: unsigned(19 downto 0) := (others=>'0');
 --signal clk0: std_logic := '0';
  
begin
 
 -- delilnik, pri 20-bitnem d je izhodna ura: 50 MHz/2^19/2 = 47 Hz
 process(clk)
 begin
 if rising_edge(clk) then
 
	if stevec = reg16 - 1  then  
	
	 stevec <= (others=>'0');
	 
	 pwmsignal <= not pwmsignal; 
	 
	 else
		stevec <= stevec + 1;  
		
  end if;
  
 end if;
 
 end process;
 
 pwm <= pwmsignal;  
 
 -- source nastavljamo v Tools>In System Sources and Probes, odkomentiraj !
--u0: vio port map (source => source);

 -- 16-bitni mikrokrmilnik
 proc: entity work.proc16 port map(
	   clk => clk,
		pin => pin,
		adr => adr,
		pout => pout,
		we => we,
		rd => rd 
 );
 
 -- vhodni izbiralnik za tipke
pin <= (0=>source(0), others=>'0') when adr=1 else
        (0=>source(1), others=>'0') when adr=2 else
		  (0=>source(2), others=>'0') when adr=3 else 
		  (0=>source(3), others=>'0');


 -- CPU izhodni register
 process(clk)
 begin
 if rising_edge(clk) then
   if adr=0 and we='1' then
	  reg16 <= pout(15 downto 0);
	end if;
 end if;
 end process;
 
 -- LED: stanje tipke & izhodni register
 --led <= izh2 & izh1 & "00" & std_logic_vector(reg16);

 -- avtomat za branje tipke 1
	u1: entity work.avt port map(
	   clk => clk,
	   t => source(0), 
	   rd => rd,
	   adr => adr,
		adrin => x"01", 
	   izh => izh1
);
 
 -- avtomat za branje tipke 2
	u2: entity work.avt port map(
	   clk => clk,
	   t => source(1), 
	   rd => rd,
	   adr => adr,
		adrin => x"02", 
	   izh => izh2
); 
 -- avtomat za branje tipke 3
	u3: entity work.avt port map(
	   clk => clk,
	   t => source(2), 
	   rd => rd,
	   adr => adr,
		adrin => x"03", 
	   izh => izh3
);
	-- avtomat za branje tipke 4
	u4: entity work.avt port map(
	   clk => clk,
	   t => source(3),
	   rd => rd,
	   adr => adr,
		adrin => x"04", 
	   izh => izh4
 ); 



end RTL;