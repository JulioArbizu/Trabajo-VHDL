


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package mi_paquete is
    procedure test_Reset(constant CLK_PERIOD : time; constant TEMPORIZADOR : time; signal reset_n : inout std_logic; signal led_trabajando : inout std_logic; signal boton_central : inout std_logic; signal led_dinero_dev : inout std_logic; signal led_standby : inout std_logic);
end mi_paquete;

package body mi_paquete is
--------------------------------------------------------TEST DE RESET---------------------------------------------------------------------------------------------
    procedure test_Reset (constant CLK_PERIOD : time; constant TEMPORIZADOR : time; signal reset_n : inout std_logic; signal led_trabajando : inout std_logic; signal boton_central : inout std_logic; signal led_dinero_dev : inout std_logic; signal led_standby : inout std_logic) is
    begin
    reset_n <= '0' after 0.25 * CLK_PERIOD, '1' after 0.75 * CLK_PERIOD;
    wait for 0.3 * CLK_PERIOD;
    wait for 0.1 * CLK_PERIOD;
    assert led_trabajando = '1'
        report "[FALLO] Reset no funciona correctamente"
        severity warning;
    
    wait for TEMPORIZADOR; --Espera al temporizador que representa a la maquina devolviendo el dinero
    wait for 0.75 * CLK_PERIOD;
    assert led_dinero_dev = '1'
        report "[FALLO]: Error al devolver el dinero durante el reset"
        severity warning;
    
    wait for 1 * CLK_PERIOD;
    assert led_standby = '1'
        report "[FALLO]: Error al volver al standby"
        severity warning;
    end procedure test_Reset;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------


end;