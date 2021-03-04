library ieee,work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.procpak.all;

entity cpu16 is
port ( clk, ce: in std_logic; 
       rst: in std_logic; 
       data : in unsigned(15 downto 0);        
       pin: in unsigned(15 downto 0);       
       adr:  out	unsigned(11 downto 0);
       we: out std_logic;
       datout:  out	unsigned(15 downto 0);
		 padr:  out unsigned(7 downto 0);
       weout, rdout: out std_logic 
	  );
end cpu16;

architecture opis of cpu16 is
 signal code: unsigned(3 downto 0);
 signal pc: unsigned(11 downto 0) := x"000";
 signal spc: unsigned(12 downto 0) := (others => '0'); -- status and program counter
 signal addr, nextaddr: unsigned(11 downto 0) := x"000";
 signal akum: unsigned(15 downto 0);
 signal carry: std_logic := '0';
 type stanje is (reset, zajemi, izvedi);
 signal st: stanje;
 
 type spcRAMtype is array (0 to 15) of unsigned(12 downto 0);
 signal spcRAM: spcRAMtype := (others => (others => '0'));
 signal spcadr, nextspcadr: unsigned(3 downto 0) := "0000";
 
begin
  
 adr <= nextaddr; -- naslovni signal 
 nextaddr <=  x"000" when st=reset else               -- reset
              spc(11 downto 0) when st=izvedi and code=ret else   -- dodatek za return
              pc when st=izvedi else                 -- naslednji ukaz
              data(11 downto 0);                      -- parameter

 spc <= spcRAM(to_integer(spcadr));
 nextspcadr <= spcadr - 1;
				
P: process(clk, ce, rst)
 variable rez: unsigned(16 downto 0); -- delni rezultat vsote/razlike
begin    
 if rst = '1' then    
    st <= reset;
	 pc <= x"000"; 
	 spcadr <= (others => '0');
 elsif rising_edge(clk) and ce='1' then        
  addr <= nextaddr;
  rdout <= '0';
  weout <= '0';
  if st = reset then      -- stanje reset
    addr <= x"000";
	akum <= x"0000";
    st <= zajemi;
  elsif st = zajemi then  -- stanje zajemi
    code <= data(15 downto 12);
    pc <= addr + 1;             
    if (data(15 downto 12)=call) then	   
      spcRAM(to_integer(nextspcadr)) <= carry & (addr + 1); -- carry in naslednji pc(tj. addr+1)
	   spcadr <= nextspcadr;
	 elsif data(15 downto 12)=jmp or  -- pogoj za izvedbo skoka
	   (data(15 downto 12)=jze and akum = x"0000") or
	   (data(15 downto 12)=jcs and carry = '1') then
       st <= zajemi;
	 else
       st <= izvedi;
    end if;
	 
	 if data(15 downto 12)=inp then
	    rdout <= '1';
	 elsif data(15 downto 12)=outp then
	    weout <= '1';
	 end if;
  else                    -- stanje izvedi
    case code is		
		when lda =>
			akum <= data;
			carry <= '0';
      when inp =>
			akum <= pin;
			carry <= '0';
      when add =>
		   rez := ('0' & akum) + ('0' & data);			
			akum <= rez(15 downto 0);
			carry <= rez(16);
		when sbt =>
		   rez := ('0' & akum) - ('0' & data);			
			akum <= rez(15 downto 0);
			carry <= rez(16);
		when nota =>
			akum <= not akum;
			carry <= '0';
		when anda =>
			akum <= akum and data;
			carry <= '0';
		when ora =>
			akum <= akum or data;
			carry <= '0';
		when shl =>
		   rez:= shift_left('0' & akum, to_integer(data(3 downto 0)));
			akum<=rez(15 downto 0);
			carry <= rez(16);			
		when shr =>
		   rez:= shift_right(akum & '0', to_integer(data(3 downto 0)));
			akum <= rez(16 downto 1);
			carry <= rez(0);			
		when ret =>
			carry <= spc(12);
			spcadr <= spcadr + 1;
		when others =>
		   null; 
	 end case;
		 
     st <= zajemi;
    end if;
end if;
end process;

we   <= '1' when (st = zajemi and data(15 downto 12) = sta) else '0';

datout <= akum;
padr <= addr(7 downto 0);

end opis;