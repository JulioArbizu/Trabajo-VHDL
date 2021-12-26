----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.12.2021 09:50:00
-- Design Name: 
-- Module Name: temporizador - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity maquina is
    Port ( 
    producto_ok : in std_logic;
    dinero_ok : in std_logic;
    clk : in std_logic;
    clk_1Hz : in std_logic;
    dinero : in unsigned;
    reset_n : in std_logic;
    producto_entregado : out std_logic;
    dinero_devuelto : out std_logic;
    led_standby : out std_logic;
    led_prod_entregado : out std_logic;
    led_trabajando : out std_logic;
    led_prod_ok : out std_logic;
    led_dinero_dev : out std_logic  
    );
end maquina;

architecture Structural of maquina is

begin

end;