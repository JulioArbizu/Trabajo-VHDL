
library IEEE; 
 use IEEE.STD_LOGIC_1164.ALL; 
 use IEEE.numeric_std.all; 
  
 entity display   is 
 Port ( 
     SW                    : in STD_LOGIC_VECTOR (7 downto 0); 
     dinero_decenas        : in STD_LOGIC_VECTOR (9 downto 0); 
     dinero_centenas       : in STD_LOGIC_VECTOR (9 downto 0); 
     Seven_Segment         : out STD_LOGIC_VECTOR (12 downto 0)--D8 D7 D3 DP D2 D1 gfedcba 
 );  
 end display; 
  
 architecture Behavioral of display is 
  
 begin 
  
 process(SW,dinero_centenas ,dinero_decenas ) 
  
begin 
  Seven_Segment <= "-----10000001";
  Seven_Segment <= "--11---------";
  
 case SW (3 downto 0) is 
     when "0000" => 
     Seven_Segment <= "-1----0000001";  --0 
     when "0001" => 
     Seven_Segment <= "-1----1001111";  --1 
     when "0010" => 
     Seven_Segment <= "-1----0010010";  --2 
     when "0011" => 
     Seven_Segment <= "-1----0000110";  --3 
     when "0100" => 
     Seven_Segment <= "-1----1001100";  --4 
     when "0101" => 
     Seven_Segment <= "-1----0100100";  --5 
     when "0110" => 
     Seven_Segment <= "-1----0100000";  --6 
     when "0111" => 
     Seven_Segment <= "-1----0001111";  --7 
     when "1000" => 
     Seven_Segment <= "-1----0000000";  --8 
     when "1001" => 
     Seven_Segment <= "-1----0000100";  --9 
     when others => 
     Seven_Segment <= "-1----1111110";  
 end case; 
  
 case SW (7 downto 4) is 
     when "0000" => 
     Seven_Segment <= "1-----0000001";  --0 
     when "0001" => 
     Seven_Segment <= "1-----1001111";  --1 
     when "0010" => 
     Seven_Segment <= "1-----0010010";  --2 
     when "0011" => 
     Seven_Segment <= "1-----0000110";  --3 
     when "0100" => 
     Seven_Segment <= "1-----1001100";  --4 
     when "0101" => 
     Seven_Segment <= "1-----0100100";  --5 
     when "0110" => 
     Seven_Segment <= "1-----0100000";  --6 
     when "0111" => 
     Seven_Segment <= "1-----0001111";  --7 
     when "1000" => 
     Seven_Segment <= "1-----0000000";  --8 
     when "1001" => 
     Seven_Segment <= "1-----0000100";  --9 
     when others => 
     Seven_Segment <= "1-----1111110";  
     end case; 

case to_integer(unsigned(dinero_decenas )) is 

     when 0 => 
     Seven_Segment <= "----1-0000001";  --0 
     when 10 => 
     Seven_Segment <= "----1-1001111";  --1 
     when 20 => 
     Seven_Segment <= "----1-0010010";  --2 
     when 30 => 
     Seven_Segment <= "----1-0000110";  --3 
     when 40 => 
     Seven_Segment <= "----1-1001100";  --4 
     when 50 => 
     Seven_Segment <= "----1-0100100";  --5 
     when 60 => 
     Seven_Segment <= "----1-0100000";  --6 
     when 70 => 
     Seven_Segment <= "----1-0001111";  --7 
     when 80 => 
     Seven_Segment <= "----1-0000000";  --8 
     when 90 => 
     Seven_Segment <= "----1-0000100";  --9 
     when others => 
     Seven_Segment <= "----1-1111110";
 end case;
 
case to_integer(unsigned  (dinero_centenas )) is 
     when 0 => 
     Seven_Segment <= "---1--0000001";  --0 
     when 100 => 
     Seven_Segment <= "---1--1001111";  --1 
     when 200 => 
     Seven_Segment <= "---1--0010010";  --2 
     when 300 => 
     Seven_Segment <= "---1--0000110";  --3 
     when 400 => 
     Seven_Segment <= "---1--1001100";  --4 
     when 500 => 
     Seven_Segment <= "---1--0100100";  --5 
     when 600 => 
     Seven_Segment <= "---1--0100000";  --6 
     when 700 => 
     Seven_Segment <= "---1--0001111";  --7 
     when 800 => 
     Seven_Segment <= "---1--0000000";  --8 
     when 900 => 
     Seven_Segment <= "---1--0000100";  --9 
     when others => 
     Seven_Segment <= "---1--1111110";  
     end case; 
  
 end process; 
  
 end Behavioral;