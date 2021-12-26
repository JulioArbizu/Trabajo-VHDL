library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_1164.all;

entity fsm is
    port (
        CLK                     : in std_logic;                   -- Señal de reloj
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
        led_trabajando          : out std_logic;                  -- true si la maquina está procesando, o bien esperando al pago, devolviendo o entregando producto
        led_dinero_dev          : out std_logic;                  -- true si se ha devuelto correctamente el pago
        led_standby             : out std_logic                   -- true si se esta en el estado de standby
 );
end fsm;

architecture behavioral of fsm is
    type STATES is (S0_Standby, S1_ProdSelecc, S2_Entregando, S3_Finalizado, S4_Devolviendo, S5_Devuelto);
    signal current_state: STATES := S0_Standby;
    signal next_state: STATES;
begin
    state_register: process (reset_n, CLK)
    begin
        if reset_n = '0' then
            current_state <= S4_Devolviendo;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    nextstate_decod: process (producto_ok,dinero_ok,temporizador2s, temporizador4s, current_state)
    begin
        next_state <= current_state;
        case current_state is
           when S0_Standby =>
             if producto_ok = '1' then
                next_state <= S1_ProdSelecc;
             end if;
           when S1_ProdSelecc =>
             if dinero_ok = '1' then
                next_state <= S2_Entregando;
             end if;
           when S2_Entregando =>
             if temporizador4s = '1' then
                next_state <= S3_Finalizado;
             end if;
           when S3_Finalizado =>
             if temporizador2s = '1' then
                next_state <= S0_Standby;
             end if;
            when S4_Devolviendo =>
             if temporizador2s = '1' then
                next_state <= S4_Devolviendo;
             end if;
            when S5_Devuelto =>
             if temporizador2s = '1' then
                next_state <= S0_Standby;
             end if;
           when others =>
            next_state <= S4_Devolviendo;
        end case;
    end process;
    
    output_decod: process (current_state)
    begin
        case current_state is
         when S0_Standby =>
            dinero_devuelto <= '0';
            enable_temporizador2s <= '0';
            enable_temporizador4s <= '0';
            led_pro_entregado <= '0';
            led_pro_ok <= '0';
            led_trabajando <= '0';
            led_dinero_dev <= '0';
            led_standby <= '1';
         when S1_ProdSelecc =>
            dinero_devuelto <= '0';
            enable_temporizador2s <= '0';
            enable_temporizador4s <= '0';
            led_pro_entregado <= '0';
            led_pro_ok <= '1';
            led_trabajando <= '0';
            led_dinero_dev <= '0';
            led_standby <= '0';
         when S2_Entregando =>
            dinero_devuelto <= '0';
            enable_temporizador2s <= '0';
            enable_temporizador4s <= '1';
            led_pro_entregado <= '0';
            led_pro_ok <= '0';
            led_trabajando <= '1';
            led_dinero_dev <= '0';
            led_standby <= '0';
         when S3_Finalizado =>
            dinero_devuelto <= '0';
            enable_temporizador2s <= '1';
            enable_temporizador4s <= '0';
            led_pro_entregado <= '1';
            led_pro_ok <= '0';
            led_trabajando <= '0';
            led_dinero_dev <= '1';
            led_standby <= '0';
         when S4_Devolviendo =>
            dinero_devuelto <= '0';
            enable_temporizador2s <= '1';
            enable_temporizador4s <= '0';
            led_pro_entregado <= '0';
            led_pro_ok <= '0';
            led_trabajando <= '1';
            led_dinero_dev <= '0';
            led_standby <= '0';
        when S5_Devuelto =>
            dinero_devuelto <= '0';
            enable_temporizador2s <= '1';
            enable_temporizador4s <= '0';
            led_pro_entregado <= '0';
            led_pro_ok <= '0';
            led_trabajando <= '0';
            led_dinero_dev <= '1';
            led_standby <= '0';
         when others =>
            dinero_devuelto <= '0';
            enable_temporizador2s <= '0';
            enable_temporizador4s <= '0';
            led_pro_entregado <= '1';
            led_pro_ok <= '1';
            led_trabajando <= '1';
            led_dinero_dev <= '1';
            led_standby <= '1';          
        end case;
    end process;
end behavioral;
