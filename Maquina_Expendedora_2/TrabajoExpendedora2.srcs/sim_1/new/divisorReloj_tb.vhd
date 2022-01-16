LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY divisorReloj_tb IS
END divisorReloj_tb;

ARCHITECTURE behavior OF divisorReloj_tb IS

 -- Component Declaration for the Unit Under Test (UUT)

COMPONENT temporizador is
  generic(
  MODULO : positive
  );
  Port ( 
  clk       : in std_logic;  --Reloj
  reset   : in std_logic;  --Entrada reset asíncrona
  contado   : out std_logic  --Salida del temporizador, 1 cuando se acaba la cuenta
  );
end COMPONENT;

--Inputs
signal clk,reset : std_logic := '0';

--Outputs
signal clock_out : std_logic;

 -- Clock period definitions
constant clk_period : time := 10 ns;

BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: temporizador
generic map(
  MODULO => 50000000
  )
PORT MAP (
clk => clk,
contado => clock_out,
reset => reset
);

 -- Clock process definitions
clk_process :process
begin
clk <= '0';
wait for clk_period/2;
clk <= '1';
wait for clk_period/2;
end process;

 -- Stimulus process
stim_proc: process
begin
    reset <= '1';
    wait for 4 * CLK_PERIOD;
    reset <= '0';
    wait for 4000 ms;
    assert false
        report "[EXITO] Simulacion finalizada correctamente"
        severity failure;
wait;
end process;

END;