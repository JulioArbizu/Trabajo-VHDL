library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_7segment is
Port (
    SW1 : in STD_LOGIC_VECTOR (3 downto 0);
    SW2 : in STD_LOGIC_VECTOR (3 downto 0);
    dinero : in STD_LOGIC_VECTOR (9 downto 0);
    Seven_Segment : out STD_LOGIC_VECTOR (8 downto 0) --D8 D7 D4 D3 D2 D1 gfedcba
); 
end bcd_7segment;

architecture Behavioral of bcd_7segment is

begin

process(SW1,SW2)
begin

case SW1 is
    when "0000" =>
    Seven_Segment <= "0100000000001";  --0
    when "0001" =>
    Seven_Segment <= "0100001001111";  --1
    when "0010" =>
    Seven_Segment <= "0100000010010";  --2
    when "0011" =>
    Seven_Segment <= "0100000000110";  --3
    when "0100" =>
    Seven_Segment <= "0100001001100";  --4
    when "0101" =>
    Seven_Segment <= "0100000100100";  --5
    when "0110" =>
    Seven_Segment <= "0100000100000";  --6
    when "0111" =>
    Seven_Segment <= "0100000001111";  --7
    when "1000" =>
    Seven_Segment <= "0100000000000";  --8
    when "1001" =>
    Seven_Segment <= "0100000000100";  --9
    when others =>
    Seven_Segment <= "0100001111110"; 
end case;

case SW2 is
    when "0000" =>
    Seven_Segment <= "1000000000001";  --0
    when "0001" =>
    Seven_Segment <= "1000001001111";  --1
    when "0010" =>
    Seven_Segment <= "1000000010010";  --2
    when "0011" =>
    Seven_Segment <= "1000000000110";  --3
    when "0100" =>
    Seven_Segment <= "1000001001100";  --4
    when "0101" =>
    Seven_Segment <= "1000000100100";  --5
    when "0110" =>
    Seven_Segment <= "1000000100000";  --6
    when "0111" =>
    Seven_Segment <= "1000000001111";  --7
    when "1000" =>
    Seven_Segment <= "1000000000000";  --8
    when "1001" =>
    Seven_Segment <= "1000000000100";  --9
    when others =>
    Seven_Segment <= "1000001111110"; 
    end case;

case dinero is
    when "0000000000" =>
    Seven_Segment <= "0000000000001";  --0
    when "x4x" =>
    Seven_Segment <= "1000001001111";  --1
    when "0010" =>
    Seven_Segment <= "1000000010010";  --2
    when "0011" =>
    Seven_Segment <= "1000000000110";  --3
    when "0100" =>
    Seven_Segment <= "1000001001100";  --4
    when "0101" =>
    Seven_Segment <= "1000000100100";  --5
    when "0110" =>
    Seven_Segment <= "1000000100000";  --6
    when "0111" =>
    Seven_Segment <= "1000000001111";  --7
    when "1000" =>
    Seven_Segment <= "1000000000000";  --8
    when "1001" =>
    Seven_Segment <= "1000000000100";  --9
    when others =>
    Seven_Segment <= "1000001111110"; 
    end case;

end process;

end Behavioral;