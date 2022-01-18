
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity maquina is
    Port ( 
    producto_ok         : in std_logic;
    dinero_ok           : in std_logic;
    clk                 : in std_logic;
    clk_2Hz             : in std_logic;
    reset               : in std_logic;
    dinero_devuelto     : out std_logic;
    led_standby         : out std_logic;
    led_prod_entregado  : out std_logic;
    led_trabajando      : out std_logic;
    led_prod_ok         : out std_logic;
    led_dinero_dev      : out std_logic  
    );
end maquina;

architecture Structural of maquina is
      signal temporizador2s, temporizador4s : std_logic;
      signal reset_temp2s, reset_temp4s : std_logic;
      signal dinero_devuelto_o : std_logic;
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

    COMPONENT fsm is
    port (
        CLK                     : in std_logic;                   -- Señal de reloj
        reset                 : in std_logic;                   -- Entrada reset activa a nivel bajo
        producto_ok             : in std_logic;                   -- Entrada de que el producto se ha seleccionado correctamente
        dinero_ok               : in std_logic;                   -- Entrada de que se ha superado 1 euro
        temporizador2s          : in std_logic;                   -- Entrada del temporizador
        temporizador4s          : in std_logic;                   -- Entrada del temporizador
        dinero_devuelto         : out std_logic;                  -- Salida que reprenta que se ha devuelto el producto
        reset_temporizador2s   : out std_logic;                  -- Salida para activar el temporizador de 2 segundos
        reset_temporizador4s   : out std_logic;                  -- Salida para activar el temporizador de 4 segundos
        led_pro_entregado       : out std_logic;                  -- true producto entregado, 0 producto no entregado
        led_pro_ok              : out std_logic;                  -- true producto elegido correctamente
        led_trabajando          : out std_logic;                  -- true si la maquina está procesando, o bien esperando al pago, devolviendo o entregando producto
        led_dinero_dev          : out std_logic;                  -- true si se ha devuelto correctamente el pago
        led_standby             : out std_logic                   -- true si se esta en el estado de standby
     );
    end COMPONENT;

begin

    temporizador2segundos : temporizador 
    generic map(
        MODULO => 5
    )
    port map (
        clk => clk_2Hz,
        reset => reset_temp2s,
        contado => temporizador2s
    );
    temporizador4segundos : temporizador 
    generic map(
        MODULO => 9
    )
    port map (
        clk => clk_2Hz,
        reset => reset_temp4s,
        contado => temporizador4s
    );
    fsm_maquina : fsm port map (
        CLK => clk,
        reset => reset,
        producto_ok => producto_ok,
        dinero_ok => dinero_ok,
        temporizador2s => temporizador2s,
        temporizador4s => temporizador4s,
        dinero_devuelto => dinero_devuelto,
        reset_temporizador2s => reset_temp2s,
        reset_temporizador4s => reset_temp4s,
        led_pro_entregado => led_prod_entregado,
        led_pro_ok => led_prod_ok,
        led_trabajando => led_trabajando,
        led_dinero_dev => led_dinero_dev,
        led_standby => led_standby
     );
     
end;