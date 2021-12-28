library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
 
entity Clock_Divider is

    generic(
    modulo : positive :=50000000
    );
    
    port (
    clk:       in std_logic;
    reset:     in std_logic;
    clock_out: out std_logic
    );

end Clock_Divider;
 
architecture Behavioral of Clock_Divider is
 
    begin     
    process(clk,reset)
        subtype count_t is natural range 0 to modulo - 1;
        variable count : count_t;
        begin
        if(reset='0') then
            count := 0;
        elsif(rising_edge(clk)) then
            count := (count + 1)mod modulo;
        end if;

        if (count = modulo - 1) then
        clock_out <= '1';
        else
        clock_out <= '0';
        end if;

    end process;
 
end Behavioral;