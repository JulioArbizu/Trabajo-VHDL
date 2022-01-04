library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity contarDinero is
	port (
      CLK:       in std_logic;
      reset:     in std_logic;
      moneda10c: in std_logic;
      moneda20c: in std_logic;
      moneda50c: in std_logic;
      moneda1e:  in std_logic; 
	  dinero_ok  out std_logic;
      dinero:    out std_logic_vector (9 downto 0)
    );
    
end contarDinero;

architecture BEHAVIORAL of contarDinero is

begin


   
  process(reset,moneda10c,moneda20c,moneda50c,moneda1e)
    variable cont : integer :=0;
  	begin
  	     if reset='1' then
  	     cont := 0;
  	     elsif rising_edge(moneda10c) then
  	     cont := cont +10;
  	     elsif rising_edge(moneda20c) then
  	     cont := cont +20;
  	     elsif rising_edge(moneda50c) then
  	     cont := cont +50;
  	     elsif rising_edge(moneda1e) then
  	     cont := cont +100;
  	     else
  	     end if;

		 if cont > 100 then
		 dinero_ok <= '1';
		 else
		 dinero_ok <= '0';
		 end if ;

    dinero <= std_logic_vector(to_unsigned(cont,dinero'length));
    end process;
  
end BEHAVIORAL;
    