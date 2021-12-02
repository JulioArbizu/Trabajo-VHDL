
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.mi_paquete.all;


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
        display             : out std_logic_vector(6 downto 0); -- Salida a los displays
        an                  : out std_logic_vector(6 downto 0); -- Anodos de los displays
        led_cant_dinero     : out std_logic_vector(9 downto 0); -- Cantidad de dinero en led, 10 leds encendidos es 1 euro, 0 leds encendido 0 euros
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
    signal display, an: std_logic_vector(6 downto 0);
    signal led_cant_dinero : std_logic_vector(9 downto 0);
       
    constant CLK_PERIOD : time := 10 ns;
    constant TEMPORIZADOR : time := 20 ns;   
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
        display             => display,
        an                  => an,
        led_cant_dinero     => led_cant_dinero,
        led_pro_entregado   => led_pro_entregado,
        led_pro_ok          => led_pro_ok,
        led_trabajando      => led_trabajando,
        led_dinero_dev      => led_dinero_dev,
        led_standby         => led_standby
);

estimulos : process 
begin


      test_Reset(CLK_PERIOD=>CLK_PERIOD, TEMPORIZADOR=>TEMPORIZADOR, reset_n=>reset_n,led_trabajando=>led_trabajando,boton_central=>boton_central,led_dinero_dev=>led_dinero_dev, led_standby=>led_standby);

    

      assert false
        report "[EXITO]: Simulacion Completada"
        severity failure;

end process;


        

end Behavioral;
