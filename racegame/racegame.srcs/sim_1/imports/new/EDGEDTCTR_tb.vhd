----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2026 11:03:53
-- Design Name: 
-- Module Name: EDGEDTCTR_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EDGEDTCTR_tb is
--  Port ( );
end EDGEDTCTR_tb;

architecture tb of EDGEDTCTR_tb is

    component EDGEDTCTR
        port (CLK     : in std_logic;
              SYNC_IN : in std_logic;
              EDGE    : out std_logic);
    end component;

    signal CLK     : std_logic := '0';
    signal SYNC_IN : std_logic;
    signal EDGE    : std_logic;

begin

    CLK <= not CLK after 50ns;
    
    dut : EDGEDTCTR
    port map (CLK     => CLK,
              SYNC_IN => SYNC_IN,
              EDGE    => EDGE);

    stimuli : process
     variable i: positive;
    begin
       
       SYNC_IN <= '0';
       wait until rising_edge(CLK);
       
       -- Generamos una señal de entrada mantenida en el tiempo
       SYNC_IN <= '1';
       wait until rising_edge(CLK);
       wait until rising_edge(CLK);
       SYNC_IN <= '0';
       
       for i in 0 to 3 loop
        wait until rising_edge(CLK);
       end loop;
       
       
       SYNC_IN <= '1';
       for i in 0 to 4 loop
        wait until rising_edge(CLK);
       end loop;
       SYNC_IN <= '0';
       
       for i in 0 to 3 loop
        wait until rising_edge(CLK);
       end loop;
       
       assert false
         report "FIN DEL TESTBENCH"
         severity failure;
   
        wait;
    end process;

end tb;