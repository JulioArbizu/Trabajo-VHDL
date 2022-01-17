----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.01.2022 22:46:46
-- Design Name: 
-- Module Name: decoder7segments - Behavioral
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY decoder7segments IS
    PORT (
        code : IN std_logic_vector(3 DOWNTO 0);
        led : OUT std_logic_vector(6 DOWNTO 0)
    );
END ENTITY decoder7segments;

ARCHITECTURE dataflow OF decoder7segments IS
BEGIN
    WITH code SELECT
        led <=  "1000000" WHEN "0000",
                "1111001" WHEN "0001",
                "0100100" WHEN "0010",
                "0110000" WHEN "0011",
                "0011001" WHEN "0100",
                "0010010" WHEN "0101",
                "0000010" WHEN "0110",
                "1111000" WHEN "0111",
                "0000000" WHEN "1000",
                "0010000" WHEN "1001",
                "0111111" WHEN others;
END ARCHITECTURE dataflow;
