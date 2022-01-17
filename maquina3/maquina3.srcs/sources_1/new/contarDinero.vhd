library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity contarDinero is
	port (
      CLK:        in std_logic;
      reset:      in std_logic;
      moneda10c:  in std_logic;
      moneda20c:  in std_logic;
      moneda50c:  in std_logic;
      moneda1e:   in std_logic; 
	  dinero_ok:  out std_logic;
      dinero_decenas:      out std_logic_vector (3 downto 0);
      dinero_centenas:     out std_logic_vector (3 downto 0)
    );
    
end contarDinero;

architecture BEHAVIORAL of contarDinero is

begin


   
   process(reset,CLK)
    variable cont : integer :=0;
    variable centenas  : integer :=0;
    variable decenas  : integer :=0;
    variable aux : integer  :=0;
  	begin
  	     if reset='1' then
  	     cont := 0;
  	     elsif rising_edge(CLK) then
  	         if moneda10c = '1' then
  	         cont := cont +1;
  	         elsif  moneda20c = '1' then
  	         cont := cont +2;
  	         elsif  moneda50c = '1' then
  	         cont := cont +5;
  	         elsif  moneda1e = '1' then
  	         cont := cont +10;
  	         end if;
  	     end if;

		 if cont > 10 then
		 dinero_ok <= '1';
		 else
		 dinero_ok <= '0';
		 end if ;
    
   aux := cont;
   decenas := aux mod 10;
   aux := aux/10;
   centenas := aux mod 10;
   
    dinero_decenas   <= std_logic_vector(to_unsigned(decenas ,dinero_decenas'length));
    dinero_centenas  <= std_logic_vector(to_unsigned(centenas,dinero_centenas'length));
    end process;
  
end BEHAVIORAL;
    