
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity fsm_tb is
end fsm_tb;

architecture Behavioral of fsm_tb is
COMPONENT fsm is
    port (
        CLK                     : in std_logic;                   -- Señal de reloj
        reset                 : in std_logic;                   -- Entrada reset activa a nivel alto
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

    signal clk : std_logic := '0';
    signal reset, producto_ok, dinero_ok, temporizador2s, temporizador4s, dinero_devuelto, reset_temporizador2s : std_logic;
    signal reset_temporizador4s, led_pro_entregado, led_pro_ok, led_trabajando, led_dinero_dev, led_standby : std_logic;
    --signal dinero : unsigned;
    constant CLK_PERIOD : time := 10 ns;
begin

uut: fsm port map (
    CLK => clk, reset => reset, producto_ok => producto_ok, dinero_ok => dinero_ok, temporizador2s => temporizador2s,
    temporizador4s => temporizador4s, dinero_devuelto => dinero_devuelto, reset_temporizador2s => reset_temporizador2s, 
    reset_temporizador4s => reset_temporizador4s, led_pro_entregado => led_pro_entregado, led_pro_ok => led_pro_ok, led_trabajando => led_trabajando,
    led_dinero_dev => led_dinero_dev, led_standby => led_standby
);

genclk : clk <= not clk after 0.5 * CLK_PERIOD;

stimulus: process 
begin
    
    ----------------------------------------------- RESETEO ---------------------------------------------------
    wait for 0.2 * CLK_PERIOD;
    assert led_standby = '1'
        report "[FALLO] Error en el inicio de la FSM"
        severity failure;
   
   reset <= '1';
   wait for 0.5*CLK_PERIOD;
   reset <= '0';
   assert led_trabajando = '1'
        report "[FALLO] Error en el reset"
        severity failure;
   wait for CLK_PERIOD;

   temporizador2s <= '1';
   wait for CLK_PERIOD;
   temporizador2s <= '0';     
   assert led_dinero_dev = '1'
        report "[FALLO] Error devolviendo el dinero desde el reset"
        severity failure;
   
   wait for CLK_PERIOD;     
   temporizador4s <= '1';     
   wait for CLK_PERIOD;
   assert led_standby = '1'
     report "[FALLO] Error volviendo al standby"      
     severity failure;
   temporizador4s <= '0';
   ---------------------------------------------------------------------------------------------------------------------------
  
   ------------------------------------------- SECUENCIA NORMAL -------------------------------------------------------------- 
   producto_ok <= '1';
   wait for CLK_PERIOD;
   assert led_pro_ok = '1'
        report "[FALLO] Error seleccionando el producto"
        severity failure;
    wait for CLK_PERIOD;
    
    dinero_ok <= '1';
    wait for CLK_PERIOD;
    assert led_trabajando = '1'
        report "[FALLO] Error pagando el producto"
        severity failure;
    wait for 2*CLK_PERIOD;
    
    temporizador4s <= '1';
    wait for CLK_PERIOD;
    assert led_pro_entregado = '1'
        report "[FALLO] Error entregando el producto"
        severity failure;
     assert led_dinero_dev = '1'
        report "[FALLO] Error devolviendo el dinero"
        severity failure;
     wait for 2 * CLK_PERIOD;
     
     temporizador2s <= '1';
     wait for CLK_PERIOD;
     assert led_standby = '1'
        report "[FALLO] Error volviendo al standby"
        severity failure;
           
           
   wait for 2 * CLK_PERIOD;    
   assert false
        report "[EXITO] Simulacion completada correctamente"
        severity failure;

end process;

end Behavioral;
