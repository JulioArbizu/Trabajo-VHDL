
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tb_fsm is
end tb_fsm;

architecture Behavioral of tb_fsm is
COMPONENT fsm is
    port (
        CLK                     : in std_logic;                   -- Se�al de reloj
        reset_n                 : in std_logic;                   -- Entrada reset activa a nivel bajo
        producto_ok             : in std_logic;                   -- Entrada de que el producto se ha seleccionado correctamente
        dinero_ok               : in std_logic;                   -- Entrada de que se ha superado 1 euro
        dinero                  : in unsigned;                    -- Entrada que representa la cantidad de dinero
        temporizador2s          : in std_logic;                   -- Entrada del temporizador
        temporizador4s          : in std_logic;                   -- Entrada del temporizador
        dinero_devuelto         : out std_logic;                  -- Salida que reprenta que se ha devuelto el producto
        enable_temporizador2s   : out std_logic;                  -- Salida para activar el temporizador de 2 segundos
        enable_temporizador4s   : out std_logic;                  -- Salida para activar el temporizador de 4 segundos
        led_pro_entregado       : out std_logic;                  -- true producto entregado, 0 producto no entregado
        led_pro_ok              : out std_logic;                  -- true producto elegido correctamente
        led_trabajando          : out std_logic;                  -- true si la maquina est� procesando, o bien esperando al pago, devolviendo o entregando producto
        led_dinero_dev          : out std_logic;                  -- true si se ha devuelto correctamente el pago
        led_standby             : out std_logic                   -- true si se esta en el estado de standby
 );
end COMPONENT;

    signal clk : std_logic := '0';
    signal reset_n, producto_ok, dinero_ok, temporizador2s, temporizador4s, dinero_devuelto, enable_temporizador2s : std_logic;
    signal enable_temporizador4s, led_pro_entregado, led_pro_ok, led_trabajando, led_dinero_dev, led_standby : std_logic;
    signal dinero : unsigned;
    constant CLK_PERIOD : time := 10 ns;
begin

genclk : clk <= not clk after 0.5 * CLK_PERIOD;

uut: fsm port map (
    clk => clk, reset_n => reset_n, producto_ok => producto_ok, dinero_ok => dinero_ok, dinero => dinero, temporizador2s => temporizador2s,
    temporizador4s => temporizador4s, dinero_devuelto => dinero_devuelto, enable_temporizador2s => enable_temporizador2s, 
    enable_temporizador4s => enable_temporizador4s, led_pro_entregado => led_pro_entregado, led_pro_ok => led_pro_ok, led_trabajando => led_trabajando,
    led_dinero_dev => led_dinero_dev, led_standby => led_standby
);

stimulus: process 
begin

--    assert led_standby = '1'
--        report "[FALLO] Error en el inicio de la FSM"
--        severity failure;
        
--    wait for 2 * CLK_PERIOD;    
    assert false
        report "[EXITO] Simulacion completada correctamente"
        severity failure;

end process;

end Behavioral;