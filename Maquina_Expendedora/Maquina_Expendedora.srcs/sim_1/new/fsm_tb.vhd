
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity fsm_tb is
end fsm_tb;

architecture Behavioral of fsm_tb is
COMPONENT fsm is
    Port (
        CLK                 : in std_logic;                     -- Señal de reloj
        reset_n             : in std_logic;                     -- Entrada reset activa a nivel bajo
        boton_central       : in std_logic;                     -- Utilaza para seleccion del producto y modo de pago con tarjeta
        moneda_10c          : in std_logic;                     -- Moneda 10 centimos
        moneda_20c          : in std_logic;                     -- Moneda 20 centimos
        moneda_50c          : in std_logic;                     -- Moneda 50 centimos
        moneda_1e           : in std_logic;                     -- Moneda 1 euro
        tarjeta             : in std_logic;                     -- Entrada NFC
        producto_SW         : in std_logic_vector(7 downto 0);  -- Switches para seleccion numero de producto en BCD
        sw_pago             : in std_logic;                     -- Switch para elegir pago con tarjeta (false) o efectivo (true)
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
    signal reset_n, boton_central, moneda_10c, moneda_20c, moneda_50c, moneda_1e,sw_pago : std_logic;
    signal tarjeta, led_pro_entregado, led_pro_ok, led_trabajando, led_dinero_dev, led_standby : std_logic;
    signal producto_SW : std_logic_vector(3 downto 0);
    signal display, an: std_logic_vector(6 downto 0);
    signal led_cant_dinero : std_logic_vector(9 downto 0);
       
    constant CLK_PERIOD : time := 10 ns;    
begin

genclk : clk <= not clk after 0.5 * CLK_PERIOD;

uut: fsm port map (
        CLK                 => clk,
        reset_n             => reset_n,
        boton_central       => boton_central,
        moneda_10c          => moneda_10c,
        moneda_20c          => moneda_20c,
        moneda_50c          => moneda_50c,
        moneda_1e           => moneda_1e,
        tarjeta             => tarjeta,
        producto_SW         => producto_SW,
        sw_pago             => sw_pago,
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
    reset_n <= '0' after 0.25 * CLK_PERIOD, '1' after 0.75 * CLK_PERIOD;
    wait for 0.1 * CLK_PERIOD;
    assert led_trabajando = '1'
        report "[FALLO] Reset no funciona correctamente"
        severity failure;
    
    

    assert false
        report "[EXITO]: Simulacion Completada"
        severity failure;
    end process;


end Behavioral;
