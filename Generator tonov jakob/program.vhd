library ieee, work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.procpak.all;

entity program is
    Port (
		address	: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		clken		: IN STD_LOGIC  := '1';
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
end program;

architecture Behavioral of program is
  
 type memory is array(0 to 4095) of unsigned(15 downto 0);
 signal m : memory := (
0=> lda & x"01e",
1=> sta & x"01d",
2=> inp & x"001",
3=> jze & x"008",
4=> lda & x"01d",
5=> add & x"01f",
6=> sta & x"01d",
7=> jmp & x"008",
8=> inp & x"002",
9=> jze & x"00e",
10=> lda & x"01d",
11=> add & x"020",
12=> sta & x"01d",
13=> jmp & x"00e",
14=> inp & x"003",
15=> jze & x"014",
16=> lda & x"01d",
17=> add & x"021",
18=> sta & x"01d",
19=> jmp & x"014",
20=> inp & x"004",
21=> jze & x"01a",
22=> lda & x"01d",
23=> add & x"022",
24=> sta & x"01d",
25=> jmp & x"01a",
26=> lda & x"01d",
27=> outp & x"000",
28=> jmp & x"000",
29=> x"0000",
30=> x"0000",
31=> x"3a98",
32=> x"2710",
33=> x"1388",
34=> x"09c4",
others => x"0000"
);

begin

 p: process(clock)
 begin
   if rising_edge(clock) then
	  if clken='1' then
		q <= STD_LOGIC_VECTOR(m(to_integer(unsigned(address))));
  
      if wren = '1' then
        m(to_integer(unsigned(address))) <= unsigned(data);
      end if;
	  end if;
   end if;
 end process;

end Behavioral;
