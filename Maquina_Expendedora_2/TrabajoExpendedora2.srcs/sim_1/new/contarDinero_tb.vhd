library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contarDinero_tb is
--  Port ( );
end contarDinero_tb;

architecture Behavioral of contarDinero_tb is
 component  contarDinero is
	port (
      CLK:                 in std_logic;
      reset:               in std_logic;
      moneda10c:           in std_logic;
      moneda20c:           in std_logic;
      moneda50c:           in std_logic;
      moneda1e:            in std_logic; 
	  dinero_ok:           out std_logic;
      dinero_decenas:      out std_logic_vector (3 downto 0);
      dinero_centenas:     out std_logic_vector (3 downto 0)
    );
    
end component ;
signal CLK : std_logic :='0';
signal reset : std_logic :='0';
signal moneda10c,moneda20c,moneda50c,moneda1e,dinero_ok: std_logic;
signal dinero_centenas,dinero_decenas:  std_logic_vector (3 downto 0);
    
constant clk_period:time := 10ns;	 
begin
CLK <= not CLK after 0.5*clk_period ;
uut: contarDinero port map (
CLK => CLK ,
reset => reset ,
moneda10c => moneda10c, 
moneda20c => moneda20c , 
moneda50c => moneda50c, 
moneda1e => moneda1e,
dinero_ok => dinero_ok,
dinero_centenas => dinero_centenas,
dinero_decenas => dinero_decenas 
);

stim_proc: process
begin


wait for 10 ns;
moneda10c <= '1';
wait for 10 ns;
moneda10c <= '0';
moneda20c <= '1';
wait for 10 ns;
moneda20c <= '0';
moneda50c <= '1';
wait for 10 ns;
moneda50c <= '0';
wait for 10 ns;
moneda50c <= '1';
wait for 10 ns;
moneda50c <= '0';
moneda1e <= '1';
wait for 20 ns;
moneda1e <= '0';
reset <= '1';
wait for 20 ns;
assert FALSE 
    report "La simulación se finalizó correctamente"
    severity FAILURE ;
end process;
end Behavioral;
