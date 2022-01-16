----------------------------------------------------------------------------------
-- Ingenieros: Adrian Rodr�guez Fern�ndez y Julio Arbizu Garc�a
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
        CLK                 : in std_logic;                     -- Se�al de reloj
        reset               : in std_logic;                   -- Entrada reset activa a nivel alto
        boton_central       : in std_logic;                     -- Utilaza para seleccion del producto y modo de pago con tarjeta
        moneda_10c          : in std_logic;                     -- Moneda 10 centimos
        moneda_20c          : in std_logic;                     -- Moneda 20 centimos
        moneda_50c          : in std_logic;                     -- Moneda 50 centimos
        moneda_1e           : in std_logic;                     -- Moneda 1 euro
        producto_SW         : in std_logic_vector(7 downto 0);  -- Switches para seleccion numero de producto en BCD
        seven_segment       : out std_logic_vector(6 downto 0); -- Salida a los displays
        punto               : out std_logic;                    -- Salida para representar el punto decimal en el dinero
        select_SW1          : out std_logic;                    -- Salida para representar las unidades del producto
        select_SW2          : out std_logic;                    -- Salida para representar las decenas del producto                    
        select_decenas      : out std_logic;                    -- Salida para representar las decenas (centimos) del dinero
        select_centenas     : out std_logic;                    -- Salida para representar las centenas (euros) del dinero
        select_unidades     : out std_logic;                    -- Salida para representar las unidades (centimos) del dinero
        led_pro_entregado   : out std_logic;                    -- true producto entregado, 0 producto no entregado
        led_pro_ok          : out std_logic;                    -- true producto elegido correctamente
        led_trabajando      : out std_logic;                    -- true si la maquina est� procesando, o bien esperando al pago, devolviendo o entregando producto
        led_dinero_dev      : out std_logic;                     -- true si se ha devuelto correctamente el pago
        led_standby         : out std_logic                     -- true si se esta en el estado de standby
     );
end top;

architecture Behavioral of top is

--------------- COMPONENTES --------------
COMPONENT antirebotes is
    port(
    ------------------------------ ENTRADAS ----------------------------------------
        CLK                     : in std_logic;                     -- Se�al de reloj
        reset_in             : in std_logic;                     -- Entrada reset activa a nivel bajo
        boton_central_in       : in std_logic;                     -- Utilaza para seleccion del producto y modo de pago con tarjeta
        moneda_10c_in          : in std_logic;                     -- Moneda 10 centimos
        moneda_20c_in          : in std_logic;                     -- Moneda 20 centimos
        moneda_50c_in          : in std_logic;                     -- Moneda 50 centimos
        moneda_1e_in           : in std_logic;                     -- Moneda 1 euro
        --------------------------- SALIDAS -----------------------------------------
        reset_out              : out std_logic;                     
        boton_central_out       : out std_logic;                     
        moneda_10c_out          : out std_logic;                     
        moneda_20c_out          : out std_logic;                     
        moneda_50c_out          : out std_logic;                     
        moneda_1e_out           : out std_logic
                        
    );      
end COMPONENT;

COMPONENT maquina is
    Port ( 
    producto_ok : in std_logic;
    dinero_ok : in std_logic;
    clk : in std_logic;
    clk_2Hz : in std_logic;
    reset : in std_logic;
    dinero_devuelto : out std_logic;
    led_standby : out std_logic;
    led_prod_entregado : out std_logic;
    led_trabajando : out std_logic;
    led_prod_ok : out std_logic;
    led_dinero_dev : out std_logic  
    );
end COMPONENT;

COMPONENT IntroducirProducto is
    Port (
    clk : in std_logic;                             -- Se�al de reloj
    boton_central : in std_logic;                   -- Boton central, se�al que llega desde el bloque antirebotes
    SW : in std_logic_vector(7 downto 0);           -- Switches
    producto_ok : out std_logic                    -- 1 si el producto es correcto, 0 si no es codigo BCD correcto
    );
end COMPONENT;

COMPONENT temporizador is
  generic(
  MODULO : positive
  );
  Port ( 
  clk       : in std_logic;  --Reloj
  reset     : in std_logic;  --Entrada reset as�ncrona
  contado   : out std_logic  --Salida del temporizador, 1 cuando se acaba la cuenta
  );
end COMPONENT;

component  contarDinero is
	port (
      CLK:        in std_logic;
      reset:      in std_logic;
      moneda10c:  in std_logic;
      moneda20c:  in std_logic;
      moneda50c:  in std_logic;
      moneda1e:   in std_logic; 
	  dinero_ok:  out std_logic;
      dinero_decenas:      out std_logic_vector (3 downto 0);
      dinero_centenas:     out std_logic_vector (3 downto 0)
    );
end component ;

COMPONENT segmentDriver is
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
end COMPONENT;
 
-------------- SE�ALES -------------------
    signal reset_i, boton_central_i, moneda_10c_i, moneda_20c_i, moneda_50c_i, moneda_1e_i : std_logic;
    signal productoOK_i, dineroOK_i : std_logic;
    signal dinero_decenas_i,dinero_centenas_i : std_logic_vector(3 downto 0);
    signal dinero_devuelto_i : std_logic;
    signal clk_2Hz_i : std_logic;

begin
antirrebotes_c : antirebotes PORT MAP(
        CLK => CLK,
        reset_in => reset,
        boton_central_in => boton_central,
        moneda_10c_in => moneda_10c,
        moneda_20c_in => moneda_20c,
        moneda_50c_in => moneda_50c,
        moneda_1e_in => moneda_1e,
        --------------------------- SALIDAS -----------------------------------------
        reset_out => reset_i,                     
        boton_central_out => boton_central_i,                     
        moneda_10c_out => moneda_10c_i,                     
        moneda_20c_out => moneda_20c_i,                     
        moneda_50c_out => moneda_50c_i,                      
        moneda_1e_out  => moneda_1e_i 
);

introducirProducto_c : IntroducirProducto PORT MAP(
    clk => CLK, 
    boton_central => boton_central_i,
    SW => producto_SW,
    producto_ok => productoOK_i
);

monedero : contarDinero PORT MAP(
      CLK => CLK,
      reset => dinero_devuelto_i,
      moneda10c => moneda_10c_i,
      moneda20c => moneda_20c_i,
      moneda50c => moneda_50c_i,
      moneda1e => moneda_1e_i, 
      dinero_ok => dineroOK_i,
      dinero_decenas => dinero_decenas_i,
      dinero_centenas => dinero_centenas_i 
);

segmentDriver_c : segmentDriver Port map ( 
  SW => producto_SW,
  dinero_decenas => dinero_decenas_i,
  dinero_centenas => dinero_centenas_i,
  clk => clk,
  seven_segments => seven_segment,
  punto => punto,
  select_SW1 => select_SW1,
  select_SW2 => select_SW2,
  select_decenas => select_decenas,
  select_centenas => select_centenas,
  select_unidades  => select_unidades
  );

maquina_c : maquina PORT MAP(
    producto_ok => productoOK_i,
    dinero_ok => dineroOK_i,
    clk => CLK,
    clk_2Hz => clk_2Hz_i,
    reset => reset_i,
    dinero_devuelto => dinero_devuelto_i,
    led_standby => led_standby,
    led_prod_entregado => led_pro_entregado,
    led_trabajando => led_trabajando,
    led_prod_ok => led_pro_ok,
    led_dinero_dev => led_dinero_dev 
);

clk2HZ : temporizador GENERIC MAP (
    MODULO => 50000000
    )
    PORT MAP(
    clk => CLK,
    reset => reset_i,
    contado => clk_2Hz_i
    );


end Behavioral;
