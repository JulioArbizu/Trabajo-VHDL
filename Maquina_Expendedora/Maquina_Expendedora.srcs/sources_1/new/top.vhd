----------------------------------------------------------------------------------
-- Ingenieros: Adrian Rodríguez Fernández y Julio Arbizu García
-- Create Date: 27.11.2021 10:46:32
-- Design Name: top
-- Module Name: top - Behavioral
-- Project Name: Maquina Expendedora
-- Description: 
-- Version 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
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
end top;

architecture Behavioral of top is

begin


end Behavioral;
