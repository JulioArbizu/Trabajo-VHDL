library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity contarDinero is
	port (
      CLK:       in std_logic;
      devolver:  in std_logic;
      moneda10c: in std_logic;
      moneda20c: in std_logic;
      moneda50c: in std_logic;
      moneda1e:  in std_logic; 
      dinero:    out std_logic_vector (9 downto 0)
    );
    
end contarDinero;

architecture BEHAVIORAL of contarDinero is

begin

  variable cont : integer :=0;
   
  process(devolver,moneda10c,moneda20c,moneda50c,moneda1e)
  	begin
      cont := cont +10 when rising_edge(moneda10c) else
        cont := cont +20 when rising_edge(moneda20c) else
          cont := cont +50 when rising_edge(moneda50c) else
            cont := cont +100 when rising_edge(moneda1e)else
              cont := 0 when rising_edge(devolver)else 
                unaffected;
    end process;
  dinero <= std_logic_vector'value(cont);
end BEHAVIORAL;
    