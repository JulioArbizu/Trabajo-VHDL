
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segmentDriver is
  Port ( 
  SW : in std_logic_vector(7 downto 0);
  dinero_decenas : in std_logic_vector(3 downto 0);
  dinero_centenas : in std_logic_vector(3 downto 0);
  clk : in std_logic;
  seven_segments : out std_logic_vector(6 downto 0);
  punto : out std_logic;
  select_SW1 : out std_logic;
  select_SW2 : out std_logic;
  select_decenas : out std_logic;
  select_centenas : out std_logic;
  select_unidades : out std_logic
  );
end segmentDriver;

architecture Behavioral of segmentDriver is

    COMPONENT decoder7segments IS
        PORT (
            code : IN std_logic_vector(3 DOWNTO 0);
            led : OUT std_logic_vector(6 DOWNTO 0)
        );
    END COMPONENT decoder7segments;
    
    COMPONENT temporizador is
      generic(
      MODULO : positive
      );
      Port ( 
      clk       : in std_logic;  --Reloj
      reset   : in std_logic;  --Entrada reset asíncrona
      contado   : out std_logic  --Salida del temporizador, 1 cuando se acaba la cuenta
      );
    end COMPONENT;

    signal temperary_data : std_logic_vector(3 downto 0);
    signal clk_10kHz : std_logic;

begin

    decoder7segments_uut : decoder7segments port map(
        code => temperary_data,
        led => seven_segments
    );
    
    clock10kHz : temporizador generic map(
        MODULO => 10000
    )
    port map(
        clk => clk,
        reset => '0',
        contado => clk_10kHz
    );

    process(clk_10kHz)
        variable seleccion_display : std_logic_vector(2 downto 0);
    begin
        if rising_edge(clk_10kHz) then
            case seleccion_display is
            
            when "000" => temperary_data <= SW(3 downto 0);
                select_SW1 <= '0';
                select_SW2 <= '1';
                select_decenas <= '1';
                select_centenas <= '1';
                select_unidades <= '1';
                punto <= '1';
               seleccion_display := seleccion_display + '1';
               
            when "001" => temperary_data <= SW(7 downto 4);
                select_SW1 <= '1';
                select_SW2 <= '0';
                select_decenas <= '1';
                select_centenas <= '1';
                select_unidades <= '1';
                punto <= '1';
               seleccion_display := seleccion_display + '1';
               
            when "010" => temperary_data <= "0000";
                select_SW1 <= '1';
                select_SW2 <= '1';
                select_decenas <= '1';
                select_centenas <= '1';
                select_unidades <= '0';
                punto <= '1';
               seleccion_display := seleccion_display + '1';
        
            when "011" => temperary_data <= dinero_decenas;
                select_SW1 <= '1';
                select_SW2 <= '1';
                select_decenas <= '0';
                select_centenas <= '1';
                select_unidades <= '1';
                punto <= '1';
               seleccion_display := seleccion_display + '1';
               
            when "100" => temperary_data <= dinero_centenas;
                select_SW1 <= '1';
                select_SW2 <= '1';
                select_decenas <= '1';
                select_centenas <= '0';
                select_unidades <= '1';
                punto <= '0';
               seleccion_display := "000";
               
            when others => temperary_data <= "1111";
                select_SW1 <= '0';
                select_SW2 <= '0';
                select_decenas <= '0';
                select_centenas <= '0';
                select_unidades <= '0';
                punto <= '1';
             seleccion_display := "000";
          end case;   
        end if;
    end process;

end Behavioral;
