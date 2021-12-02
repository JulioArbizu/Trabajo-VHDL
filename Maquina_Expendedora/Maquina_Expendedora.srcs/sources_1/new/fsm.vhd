library IEEE;
use IEEE.std_logic_1164.all;

entity fsm is
    port (
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
end fsm;

architecture behavioral of fsm is
    type STATES is (S0, S1, S2, S3);
    signal current_state: STATES := S0;
    signal next_state: STATES;
begin
    state_register: process (reset_n, CLK)
    begin
        if reset_n = '0' then
            current_state <= S0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    nextstate_decod: process (boton_central, current_state)
    begin
        next_state <= current_state;
        case current_state is
           when S0 =>
             --if PUSHBUTTON = '1' then
             --next_state <= S1;
             --end if;
           when S1 =>
             --if PUSHBUTTON = '1' then
             --next_state <= S2;
             --end if;
           when S2 =>
             --if PUSHBUTTON = '1' then
             --next_state <= S3;
             --end if;
           when S3 =>
             --if PUSHBUTTON = '1' then
             --next_state <= S0;
             --end if;
           when others =>
             --next_state <= S0;
        end case;
    end process;
    
    output_decod: process (current_state)
    begin
        --LIGHT <= (OTHERS => '0');
        case current_state is
         when S0 =>
           --LIGHT(0) <= '1';
         when S1 =>
            --LIGHT(1) <= '1';
         when S2 =>
            --LIGHT(2) <= '1';
         when S3 =>
            --LIGHT(3) <= '1';
         when others =>
            --LIGHT <= (OTHERS => '0');
        end case;
    end process;
end behavioral;
