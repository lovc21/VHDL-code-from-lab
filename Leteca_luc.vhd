library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Leteca_luc is
port (
    clk    :in std_logic;
    led    :out unsigned(7 downto 0)
);
end entity;

architecture  architecture_Leteca_luc of Leteca_luc is

	signal st: unsigned(1 downto 0) :="00";
	signal st1: unsigned(24 downto 0) :="0000000000000000000000000";
	signal smer:    std_logic :='0';

begin
    process(clk,st,st1) is
    begin
	 
    if rising_edge(clk) then
        st1 <= st1 + 1;

    if st1 = "1000000000000000000000000" then
        if smer = '1' then
           st <= st - 1;
       elsif smer = '0' then
           st <= st + 1;
       end if;
    end if;

    end if;
	 
	 
	  if st = "00" then smer <= '0';
	 
	elsif st = "11" then smer <= '1';
	 
    end if;

            if st = "00" then led <="00011000";
				
            elsif st ="01" then led <="00111100";
				
            elsif st = "10" then led <="01111110";
				
            elsif st = "11" then led <="11111111";
				
            end if; 

    end process;

end architecture_Leteca_luc;
