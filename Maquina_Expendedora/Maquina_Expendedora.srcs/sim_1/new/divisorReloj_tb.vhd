LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY divisorReloj_tb IS
END divisorReloj_tb;

ARCHITECTURE behavior OF divisorReloj_tb IS

 -- Component Declaration for the Unit Under Test (UUT)

COMPONENT Clock_Divider
PORT(
clk,reset : IN std_logic;
clock_out : OUT std_logic
);
END COMPONENT;

--Inputs
signal clk,reset : std_logic := '0';

--Outputs
signal clock_out : std_logic;

 -- Clock period definitions
constant clk_period : time := 0.01 us;

BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: Clock_Divider PORT MAP (
clk => clk,
clock_out => clock_out,
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
    wait for 4000 ms;
    assert false
        report "[EXITO] Simulacion finalizada correctamente"
        severity failure;
wait;
end process;

END;