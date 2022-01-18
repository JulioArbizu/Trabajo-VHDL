library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IntroducirProducto is
    Port (
    clk             : in std_logic;                     -- Señal de reloj
    boton_central   : in std_logic;                     -- Boton central, señal que llega desde el bloque antirebotes
    SW              : in std_logic_vector(7 downto 0);  -- Switches
    producto_ok     : out std_logic                     -- 1 si el producto es correcto, 0 si no es codigo BCD correcto
    );
end IntroducirProducto;

architecture Behavioral of IntroducirProducto is
    signal comprobacion_ok : std_logic;
begin

    comprobacion : process(sw)
        variable comprobacion1, comprobacion2 : boolean := false;
    begin
        --4 primeros bits--
        case(SW(7 downto 4)) is
            -- Comprobamos si los primeros cuatro digitos corresponden a un numero en BCD --
            when "0000" | "0001" | "0010" | "0011" =>
                comprobacion1 := true;
            when others =>
                comprobacion1 := false;
        end case;
        
        --4 siguientes bits--
        case(SW(3 downto 0)) is
            -- Comprobamos si los siguientes cuatro digitos corresponden a un numero en BCD --
            when "0000" | "0001" | "0010" | "0011" | "0100" | "0101" | "0110" | "0111" | "1000" | "1001" =>
                comprobacion2 := true;
            when others =>
                comprobacion2 := false;
        end case;
        -- Si ambas comprobaciones son correctas el codigo BCD introducido es válido
        if (comprobacion1 and comprobacion2) then
            if (SW /= "00000000") then
            comprobacion_ok <= '1';
            end if;
        else
            comprobacion_ok <= '0';
        end if;        
    end process;

    salidas : process (clk,boton_central)
    begin
        --Hacemos la logica de la salida producto_ok--
            if (boton_central = '1' and comprobacion_ok = '1') then
            producto_ok <= '1';
            else
            producto_ok <= '0';
            end if;
    end process;

end Behavioral;
