library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_7segment is
Port ( SW1,SW2 : in STD_LOGIC_VECTOR (3 downto 0);
Seven_Segment : out STD_LOGIC_VECTOR (8 downto 0)); --D2 D1 gfedcba
end bcd_7segment;

architecture Behavioral of bcd_7segment is

begin

process(SW1,SW2)
begin

case SW1 is
    when "0000" =>
    Seven_Segment <= "010000001";  --0
    when "0001" =>
    Seven_Segment <= "011001111";  --1
    when "0010" =>
    Seven_Segment <= "010010010";  --2
    when "0011" =>
    Seven_Segment <= "010000110";  --3
    when "0100" =>
    Seven_Segment <= "011001100";  --4
    when "0101" =>
    Seven_Segment <= "010100100";  --5
    when "0110" =>
    Seven_Segment <= "010100000";  --6
    when "0111" =>
    Seven_Segment <= "010001111";  --7
    when "1000" =>
    Seven_Segment <= "010000000";  --8
    when "1001" =>
    Seven_Segment <= "010000100";  --9
    when others =>
    Seven_Segment <= "011111110"; 
end case;

case SW2 is
    when "0000" =>
    Seven_Segment <= "100000001";  --0
    when "0001" =>
    Seven_Segment <= "101001111";  --1
    when "0010" =>
    Seven_Segment <= "100010010";  --2
    when "0011" =>
    Seven_Segment <= "100000110";  --3
    when "0100" =>
    Seven_Segment <= "101001100";  --4
    when "0101" =>
    Seven_Segment <= "100100100";  --5
    when "0110" =>
    Seven_Segment <= "100100000";  --6
    when "0111" =>
    Seven_Segment <= "100001111";  --7
    when "1000" =>
    Seven_Segment <= "100000000";  --8
    when "1001" =>
    Seven_Segment <= "100000100";  --9
    when others =>
    Seven_Segment <= "101111110"; 
    end case;

end process;

end Behavioral;