library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

--jakob dekleva 



entity matricni_prikazovalnik is
port (
	clk    :in std_logic ;
	num    :in unsigned(3 downto 0) :="0000" ; 
	dout :out unsigned(7 downto 0)
);
end entity;

architecture  architecture_matricni_prikazovalnik of matricni_prikazovalnik is

signal st : unsigned(2 downto 0) :="000";

signal t : unsigned(4 downto 0);

signal s : unsigned(2 downto 0);

signal adr : unsigned(14 downto 0):= "000000000000000";

signal delilnik : unsigned(16 downto 0):= "00000000000000000";

type  memory is array (0 to 80) of unsigned(4 downto 0);
 
signal ROM: memory ; 

begin

	--0
	
	ROM(0) <= "11111";
	ROM(1) <= "10001";
	ROM(2) <= "10001";
	ROM(3) <= "10001";
	ROM(4) <= "10001";
	ROM(5) <= "10001";
	ROM(6) <= "11111";
	
	ROM(7) <= "00000";
	
	--1
	
	ROM(8) <= "00100";
	ROM(9) <= "01100";
	ROM(10) <= "10100";
	ROM(11) <= "00100";
	ROM(12) <= "00100";
	ROM(13) <= "00100";
	ROM(14) <= "11111";
	
	ROM(15) <= "00000";
	
	--2
	
	ROM(16) <= "01110";
	ROM(17) <= "10001";
	ROM(18) <= "00001";
	ROM(19) <= "00110";
	ROM(20) <= "01000";
	ROM(21) <= "10000";
	ROM(22) <= "11111"; 
	
	ROM(23) <= "00000";
	
	--3
	
	ROM(24) <= "11111";
	ROM(25) <= "10001";
	ROM(26) <= "00001";
	ROM(27) <= "11111";
	ROM(28) <= "00001";
	ROM(29) <= "10001";
	ROM(30) <= "11111";
	
	ROM(31) <= "00000";
	
	--4
	
	ROM(32) <= "00010"; 
	ROM(33) <= "00110";
	ROM(34) <= "01010"; 
	ROM(35) <= "10010"; 
	ROM(36) <= "11111";
	ROM(37) <= "00010";
	ROM(38) <= "00010";
	
	ROM(39) <= "00000";
	
	--5 
	
	ROM(40) <= "11111"; 
	ROM(41) <= "10000"; 
	ROM(42) <= "10000";
	ROM(43) <= "11111"; 
	ROM(44) <= "00001";
	ROM(45) <= "00001"; 
	ROM(46) <= "11111"; 
	
	ROM(47) <= "00000";
	
	--6
	
	ROM(48) <= "11111";
	ROM(49) <= "10000";
	ROM(50) <= "10000"; 
	ROM(51) <= "11111"; 
	ROM(52) <= "10001"; 
	ROM(53) <= "10001"; 
	ROM(54) <= "11111"; 
	
	ROM(55) <= "00000";
	
	--7
	
	ROM(56) <= "11111"; 
	ROM(57) <= "00001";
	ROM(58) <= "00010";
	ROM(59) <= "00100";
	ROM(60) <= "01000";
	ROM(61) <= "10000";
	ROM(62) <= "10000";
	
	ROM(63) <= "00000";
	
	--8
	
	ROM(64) <= "11111";
	ROM(65) <= "10001";
	ROM(66) <= "10001";
	ROM(67) <= "11111";
	ROM(68) <= "10001";
	ROM(69) <= "10001";
	ROM(70) <= "11111";
	
	ROM(71) <= "00000";
	
	--9
	
	ROM(72) <= "11111";
	ROM(73) <= "10001";
	ROM(74) <= "10001"; 
	ROM(75) <= "11111"; 
	ROM(76) <= "00001"; 
	ROM(78) <= "00001"; 
	ROM(79) <= "11111";
	
	ROM(80) <= "00000";
	
    process(t,st,s,clk,num) is
	 
    begin
	 
	 if rising_edge(clk) then
	 
		delilnik <= delilnik +1; 
		
		 if delilnik = "00000000000000000" then
		 
			 if st /= "110" then 
			 
				st <= st +1;
				adr <= adr+1;
			
			else 
			
				st <= "000";
				adr <= adr +2;
			end if ;
		
		end if;
		
	end if;
	
	case num is 
		when "0000"  =>
			t <= ROM(to_integer(st));
			
		when "0001" => 
			t <= ROM(to_integer(st)+8);
			
		when "0010" => 
			t <= ROM(to_integer(st)+16);
		
		when "0011" => 
			t <= ROM(to_integer(st)+24);
		
		when "0100" => 
			t <= ROM(to_integer(st)+ 32);
			
		when "0101" => 
			t <= ROM(to_integer(st)+40);
		
		when "0110" => 
			t <= ROM(to_integer(st)+48);
			
		when "0111" => 
			t <= ROM(to_integer(st)+56);
		
		when "1000" => 
			t <= ROM(to_integer(st)+64);
			
		when "1001" => 
			t <= ROM(to_integer(st)+72);
			
		when others => null;
		
		end case;
	
    end process;
	 
	
		s <= 7 - st;	
	
	dout <= s & t;	
	
	
end architecture_matricni_prikazovalnik;