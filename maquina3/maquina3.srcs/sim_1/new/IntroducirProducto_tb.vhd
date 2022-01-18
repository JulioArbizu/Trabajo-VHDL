


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IntroducirProducto_tb is
end IntroducirProducto_tb;

architecture Behavioral of IntroducirProducto_tb is
    COMPONENT IntroducirProducto is 
    Port (
    clk : in std_logic;
    boton_central : in std_logic; 
    SW : in std_logic_vector(7 downto 0);
    producto_ok : out std_logic
    );
    end COMPONENT;
    signal clk : std_logic := '0';
    signal boton_central : std_logic;
    signal SW : std_logic_vector(7 downto 0);
    signal producto_ok : std_logic;
    
    constant CLK_PERIOD : time := 10 ns;
begin

genclk : clk <= not clk after 0.5 * CLK_PERIOD;
    
uut : IntroducirProducto PORT MAP(
    clk => clk,
    boton_central => boton_central,
    SW => SW,
    producto_ok => producto_ok
);

estimulos : process
begin
    wait for 0.25*CLK_PERIOD;
    SW <= "11111111";
    wait for 0.5*CLK_PERIOD;
    assert producto_ok = '0'
        report "[ERROR] Se ha activado la salida sin activar el boton"
        severity failure;
        
    SW <= "00010010";
    boton_central <= '1';
    wait for 0.5*CLK_PERIOD;
    boton_central <= '0';
    assert producto_ok = '1'
        report "[ERROR] Se ha introducido un codigo correcto y la salida no se ha activado"
        severity failure;   
        
    SW <= "11010000";
    boton_central <= '1';
    wait for 1*CLK_PERIOD;
    boton_central <= '0';
    assert producto_ok = '0'
        report "[ERROR] Se ha introducido un codigo incorrecto y la salida se ha activado"
        severity failure;  
        
    SW <= "00010111";
    boton_central <= '1';
    wait for 0.5*CLK_PERIOD;
    boton_central <= '0';
    assert producto_ok = '1'
        report "[ERROR] Se ha introducido un codigo correcto y la salida no se ha activado"
        severity failure;      
        
    assert false
        report "[EXITO] Se ha completado la simulacion correctamente"
        severity failure;          
    

end process;

end Behavioral;
