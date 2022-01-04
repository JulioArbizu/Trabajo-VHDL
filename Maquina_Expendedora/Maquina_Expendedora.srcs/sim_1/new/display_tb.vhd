LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_bcd_7seg IS
END tb_bcd_7seg;

ARCHITECTURE behavior OF tb_bcd_7seg IS

component display   is 
 Port ( 
     SW                    : in STD_LOGIC_VECTOR (7 downto 0); 
     dinero_decenas        : in STD_LOGIC_VECTOR (9 downto 0); 
     dinero_centenas       : in STD_LOGIC_VECTOR (9 downto 0); 
     Seven_Segment         : out STD_LOGIC_VECTOR (12 downto 0)--D8 D7 D3 DP D2 D1 gfedcba 
 );  
 end component;

signal SW : std_logic_vector(7 downto 0);
signal dinero_decenas : std_logic_vector(9 downto 0) := (others => '0');
signal dinero_centenas : std_logic_vector(9 downto 0) := (others => '0');

--Outputs
signal Seven_Segment : std_logic_vector(12 downto 0);

BEGIN

 --Instantiate the Unit Under Test (UUT)
uut: display PORT MAP (
SW => SW,
Seven_Segment => Seven_Segment,
dinero_decenas  => dinero_decenas,
dinero_centenas  => dinero_centenas 
);

 --Stimulus process
stim_proc: process
begin

SW <= "00000000";
wait for 100 ns;
SW <= "00010000";
dinero_decenas <= "0000001010";
dinero_centenas  <= "1110000100";
wait for 100 ns;
SW <= "00100001";
wait for 100 ns;
SW <= "00110010";
wait for 100 ns;
SW <= "01000011";
wait for 100 ns;
SW <= "01010100";
wait for 100 ns;
SW <= "01100101";
wait for 100 ns;
SW <= "01110110";
wait for 100 ns;
SW <= "10000111";
wait for 100 ns;
SW <= "10011000";
wait for 100 ns;
end process;

END;