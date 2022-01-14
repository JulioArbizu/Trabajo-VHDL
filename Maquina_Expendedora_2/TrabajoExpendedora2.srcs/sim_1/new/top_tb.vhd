
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity top_tb is
end top_tb;

architecture Behavioral of top_tb is
COMPONENT top is
    Port (
        CLK                 : in std_logic;                     -- Señal de reloj
        reset_n             : in std_logic;                     -- Entrada reset activa a nivel bajo
        boton_central       : in std_logic;                     -- Utilaza para seleccion del producto y modo de pago con tarjeta
        moneda_10c          : in std_logic;                     -- Moneda 10 centimos
        moneda_20c          : in std_logic;                     -- Moneda 20 centimos
        moneda_50c          : in std_logic;                     -- Moneda 50 centimos
        moneda_1e           : in std_logic;                     -- Moneda 1 euro
        producto_SW         : in std_logic_vector(7 downto 0);  -- Switches para seleccion numero de producto en BCD
        seven_segment       : out std_logic_vector(12 downto 0); -- Salida a los displays
       -- an                  : out std_logic_vector(6 downto 0); -- Anodos de los displays
        led_pro_entregado   : out std_logic;                    -- true producto entregado, 0 producto no entregado
        led_pro_ok          : out std_logic;                    -- true producto elegido correctamente
        led_trabajando      : out std_logic;                    -- true si la maquina está procesando, o bien esperando al pago, devolviendo o entregando producto
        led_dinero_dev      : out std_logic;                     -- true si se ha devuelto correctamente el pago
        led_standby         : out std_logic                     -- true si se esta en el estado de standby
     );
end COMPONENT;
    signal clk : std_logic := '0';
    signal reset_n, boton_central, moneda_10c, moneda_20c, moneda_50c, moneda_1e: std_logic;
    signal led_pro_entregado, led_pro_ok, led_trabajando, led_dinero_dev, led_standby : std_logic;
    signal producto_SW : std_logic_vector(7 downto 0);
    signal seven_segment: std_logic_vector(12 downto 0);
       
    constant CLK_PERIOD : time := 10 ns;  
begin

genclk : clk <= not clk after 0.5 * CLK_PERIOD;

uut: top port map (
        CLK                 => clk,
        reset_n             => reset_n,
        boton_central       => boton_central,
        moneda_10c          => moneda_10c,
        moneda_20c          => moneda_20c,
        moneda_50c          => moneda_50c,
        moneda_1e           => moneda_1e,
        producto_SW         => producto_SW,
        seven_segment       => seven_segment,
        led_pro_entregado   => led_pro_entregado,
        led_pro_ok          => led_pro_ok,
        led_trabajando      => led_trabajando,
        led_dinero_dev      => led_dinero_dev,
        led_standby         => led_standby
);

estimulos : process 
begin


    reset_n <= '1' after 0.25 * CLK_PERIOD;
    wait for 1 * CLK_PERIOD;
    assert led_trabajando = '1'
        report "[ERROR] Reset no funciona correctamente"
        severity warning;
    reset_n <= '0';
    
    wait for 2000 ms; --Espera al temporizador que representa a la maquina devolviendo el dinero  
    wait for 1 * CLK_PERIOD;
    assert led_dinero_dev = '1'
        report "[ERROR]: Error al devolver el dinero"
        severity warning;
        
    wait for 4000 ms; --Espera al temporizador que representa a la maquina devolviendo el dinero  
    wait for 1 * CLK_PERIOD;
    assert led_standby = '1'
        report "[ERROR]: Error al volver al standby desde devolver dinero"
        severity warning;
       
       wait for 1 * CLK_PERIOD;
       producto_SW <= ("11111111");
       wait for 0.01*CLK_PERIOD;
       boton_central<= '1';
       wait for 1 * CLK_PERIOD;
       assert led_standby = '1'
        report "[ERROR] No funciona correctamente la seleccion del producto, codigo incorrecto ha sido detectado como correcto"
        severity warning;
        
        wait for 1*CLK_PERIOD;
        producto_SW <= ("00010000");
        wait for 0.01*CLK_PERIOD;
        boton_central<= '1';
        wait for 1 * CLK_PERIOD;
        assert led_pro_ok = '1'
        report "[ERROR] No funciona correctamente la seleccion del producto, codigo incorrecto ha sido detectado como correcto"
        severity warning;
        
        moneda_50c <= '1';
        wait for 1*CLK_PERIOD;
        moneda_50c <='0';
        assert led_pro_ok = '1'
        report "[ERROR] Se introdujeron 50c y se aceptó el pago incorrectmanete"
        severity warning;
        moneda_1e <= '1';
        
        wait for 1*CLK_PERIOD;
        assert led_trabajando = '1'
            report "[ERROR] No trabaja la maquina al introducir el dinero"
            severity warning;
        wait for 4000 ms;            
        assert led_pro_entregado = '1'
            report "[ERROR] No se ha encendido el led de producto entregado"
            severity warning;
        assert led_dinero_dev = '1'
            report "[ERROR] No se ha encendido el led de dinero devuelto"
            severity warning;          
            
        wait for 2000 ms;
        assert led_standby = '1'
            report "[ERROR] No se ha vuelto al standby"
            severity warning; 
        
      assert false
        report "[EXITO]: Simulacion Completada"
        severity failure;

end process;


        

end Behavioral;
