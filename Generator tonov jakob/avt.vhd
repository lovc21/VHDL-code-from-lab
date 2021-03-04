

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity avt is
 port (
   clk : in std_logic;
   t : in std_logic;
   rd : in std_logic;
   adr, adrin : in unsigned(7 downto 0);
   izh : out std_logic );
end avt;

architecture RTL of avt is
 type t_st is (mir, impulz, spusti);
 signal st : t_st;
begin

process(st)
begin
  case st is
   when mir =>
     izh <= '0';
   when impulz =>
     izh <= '1';
   when others =>
     izh <= '0';
  end case;
end process;

process(clk)
begin
 if rising_edge(clk) then
  case st is
   when mir =>
     if t = '1' then
        st <= impulz;
     end if;
   when impulz =>
     if (rd = '1') and (adr = adrin) then
        st <= spusti;
     end if;
   when others =>
     if t = '0' then
        st <= mir;
     end if;
  end case;
 end if;
end process;

end RTL;

