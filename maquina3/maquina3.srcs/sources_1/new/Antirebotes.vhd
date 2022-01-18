library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity antirebotes is
    port(
    ------------------------------ ENTRADAS ----------------------------------------
        CLK                     : in std_logic;                     -- Señal de reloj
        reset_in                : in std_logic;                     -- Entrada reset activa a nivel bajo
        boton_central_in        : in std_logic;                     -- Utilaza para seleccion del producto y modo de pago con tarjeta
        moneda_10c_in           : in std_logic;                     -- Moneda 10 centimos
        moneda_20c_in           : in std_logic;                     -- Moneda 20 centimos
        moneda_50c_in           : in std_logic;                     -- Moneda 50 centimos
        moneda_1e_in            : in std_logic;                     -- Moneda 1 euro
        --------------------------- SALIDAS -----------------------------------------
        reset_out               : out std_logic;                     
        boton_central_out       : out std_logic;                     
        moneda_10c_out          : out std_logic;                     
        moneda_20c_out          : out std_logic;                     
        moneda_50c_out          : out std_logic;                     
        moneda_1e_out           : out std_logic
                        
    );      
end antirebotes;

architecture Structural of antirebotes is
    COMPONENT EDGEDTCTR is
        port ( 
            CLK     : in std_logic;
            SYNC_IN : in std_logic;
            EDGE    : out std_logic
     );
    end COMPONENT;
    
    COMPONENT SYNCHRNZR is
    port ( 
        CLK         : in std_logic;
        ASYNC_IN    : in std_logic;
        SYNC_OUT    : out std_logic
    );
    end COMPONENT;
    signal reset, boton_central, moneda_10c, moneda_20c, moneda_50c, moneda_1e : std_logic;
begin
    snc_reset : SYNCHRNZR PORT MAP (clk=>clk, ASYNC_IN=>reset_in, SYNC_OUT=>reset);
    edge_reset : EDGEDTCTR PORT MAP(clk=>clk, SYNC_IN=>reset, EDGE=>reset_out);
    
    snc_btn_cen : SYNCHRNZR PORT MAP (clk=>clk, ASYNC_IN=>boton_central_in, SYNC_OUT=>boton_central);
    edge_btc_cen : EDGEDTCTR PORT MAP(clk=>clk, SYNC_IN=>boton_central, EDGE=>boton_central_out);
    
    snc_m10c : SYNCHRNZR PORT MAP (clk=>clk, ASYNC_IN=>moneda_10c_in, SYNC_OUT=>moneda_10c);
    edge_m10c : EDGEDTCTR PORT MAP(clk=>clk, SYNC_IN=>moneda_10c, EDGE=>moneda_10c_out);
    
    snc_m20c : SYNCHRNZR PORT MAP (clk=>clk, ASYNC_IN=>moneda_20c_in, SYNC_OUT=>moneda_20c);
    edge_m20c : EDGEDTCTR PORT MAP(clk=>clk, SYNC_IN=>moneda_20c, EDGE=>moneda_20c_out);
    
    snc_m50c : SYNCHRNZR PORT MAP (clk=>clk, ASYNC_IN=>moneda_50c_in, SYNC_OUT=>moneda_50c);
    edge_m50c : EDGEDTCTR PORT MAP(clk=>clk, SYNC_IN=>moneda_50c, EDGE=>moneda_50c_out);  
    
    snc_m1e : SYNCHRNZR PORT MAP (clk=>clk, ASYNC_IN=>moneda_1e_in, SYNC_OUT=>moneda_1e);
    edge_m1e : EDGEDTCTR PORT MAP(clk=>clk, SYNC_IN=>moneda_1e, EDGE=>moneda_1e_out);  
end Structural;
