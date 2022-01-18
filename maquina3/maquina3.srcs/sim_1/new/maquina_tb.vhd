
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity maquina_tb is
end maquina_tb;


architecture Behavioral of maquina_tb is

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

signal clk, clk_2Hz : std_logic := '0';
signal producto_ok, dinero_ok, reset, dinero_devuelto, led_standby, led_prod_entregado, led_trabajando, led_prod_ok, led_dinero_dev : std_logic;
constant CLK_PERIOD : time := 10 ns;
begin

uut : maquina port map (
    producto_ok => producto_ok, dinero_ok => dinero_ok, clk => clk, clk_2Hz => clk_2Hz, reset => reset, dinero_devuelto => dinero_devuelto,
    led_standby => led_standby, led_prod_entregado => led_prod_entregado, led_trabajando => led_trabajando,
    led_prod_ok => led_prod_ok, led_dinero_dev => led_dinero_dev
);

clk_gen : clk <= not clk after 0.5 * CLK_PERIOD;
clk2HZ_gen : clk_2Hz <= not clk_2Hz after 250 ms;

stimulus : process
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

   
   wait for 2000 ms;
   wait for 2* CLK_PERIOD;  
   assert led_dinero_dev = '1'
        report "[FALLO] Error devolviendo el dinero desde el reset"
        severity warning;
   
   wait for 4000 ms;    
   wait for CLK_PERIOD;
   assert led_standby = '1'
     report "[FALLO] Error volviendo al standby"      
     severity warning;
   ---------------------------------------------------------------------------------------------------------------------------
  
   ------------------------------------------- SECUENCIA NORMAL -------------------------------------------------------------- 
   producto_ok <= '1';
   wait for 5 * CLK_PERIOD;
   assert led_prod_ok = '1'
        report "[FALLO] Error seleccionando el producto"
        severity warning;
    wait for CLK_PERIOD;
    
    dinero_ok <= '1';
    wait for CLK_PERIOD;
    assert led_trabajando = '1'
        report "[FALLO] Error pagando el producto"
        severity warning;
    wait for 2*CLK_PERIOD;
    
    wait for 4000 ms;
    producto_ok <= '0';
    dinero_ok <= '0';
    assert led_prod_entregado = '1'
        report "[FALLO] Error entregando el producto"
        severity warning;
     assert led_dinero_dev = '1'
        report "[FALLO] Error devolviendo el dinero"
        severity warning;
     wait for 2 * CLK_PERIOD;
     
     wait for 2000 ms;
     wait for CLK_PERIOD;
     assert led_standby = '1'
        report "[FALLO] Error volviendo al standby"
        severity warning;
           
           
   wait for 2 * CLK_PERIOD;    
   assert false
        report "[EXITO] Simulacion completada correctamente"
        severity failure;

end process;

end Behavioral;
