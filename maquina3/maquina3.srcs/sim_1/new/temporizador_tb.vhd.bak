----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.12.2021 10:28:20
-- Design Name: 
-- Module Name: temporizador_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity temporizador_tb is
end temporizador_tb;

architecture Behavioral of temporizador_tb is
    COMPONENT temporizador is
      generic(
      MODULO : positive
      );
      Port ( 
      clk       : in std_logic;  --Reloj
      reset_n   : in std_logic;  --Entrada reset asíncrona
      contado   : out std_logic  --Salida del temporizador, 1 cuando se acaba la cuenta
      );
    end COMPONENT;
    signal clk : std_logic := '0';
    signal reset_n,contado : std_logic;
    constant CLK_PERIOD : time := 10 ns;
begin

uut : temporizador 
generic map(
    MODULO => 10
)
port map (
    clk => clk,
    reset_n => reset_n,
    contado => contado
);

genclk : clk <= not clk after 0.5 * CLK_PERIOD;

stimulus : process
begin

    reset_n <= '0';
    wait for 0.75 * CLK_PERIOD;
    assert contado = '0'
        report "[FALLO] Reset no funciona correctamente"
        severity failure;
        
    reset_n <= '1';
    wait for 9 * CLK_PERIOD;
    assert contado = '1'
        report "[FALLO] El temporizador alcanza la cuenta pero la salida no se activa"
        severity failure;
    
    wait for 1 * CLK_PERIOD;
    assert contado = '0'
        report "[FALLO] El temporizador no se pone a 0 cuando se acaba la cuenta"
        severity failure;
    
    assert false
        report "[EXITO] Se ha completado la simulacion correctamente"
        severity failure; 

end process;

end Behavioral;
