library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity temporizador is
  generic(
  MODULO : positive
  );
  Port ( 
  clk           : in std_logic;  --Reloj
  reset         : in std_logic;  --Entrada reset asíncrona
  contado       : out std_logic  --Salida del temporizador, 1 cuando se acaba la cuenta
  );
end temporizador;

architecture Behavioral of temporizador is

begin
process(reset, clk)
    subtype count_t is natural range 0 to MODULO - 1;
    variable count : count_t;
begin
    if reset = '1' then
        count := 0;
    elsif rising_edge (clk) then
        count := (count+1)mod MODULO;
    end if;
    
    -- Si la cuenta llega a MODULO - 1 significa que ha terminado de contar los ciclos de reloj necesarios --
    if (count = MODULO - 1) then
        contado <= '1';
    else
        contado <= '0';
    end if;
end process;
end Behavioral;
