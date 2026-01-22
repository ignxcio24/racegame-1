----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2026 22:51:39
-- Design Name: 
-- Module Name: SYNCHRNZR_tb - Behavioral
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

entity SYNCHRNZR_tb is
--  Port ( );
end SYNCHRNZR_tb;

architecture tb of SYNCHRNZR_tb is

    component SYNCHRNZR
        port (CLK      : in std_logic;
              ASYNC_IN : in std_logic;
              SYNC_OUT : out std_logic);
    end component;

    signal CLK      : std_logic := '0';
    signal ASYNC_IN : std_logic;
    signal SYNC_OUT : std_logic;

begin

    CLK <= not CLK after 50ns;

    dut : SYNCHRNZR
    port map (CLK      => CLK,
              ASYNC_IN => ASYNC_IN,
              SYNC_OUT => SYNC_OUT);

    stimuli : process
      variable i: positive;
    begin
        
        wait for 37 ns;
        ASYNC_IN <= '1';
        wait for 40 ns;     
        ASYNC_IN <= '0';
        
        for i in 0 to 3 loop
         wait until rising_edge(CLK);
        end loop;

        wait for 123 ns;
        ASYNC_IN <= '1';
        wait for 300 ns;   
        ASYNC_IN <= '0';
        
        for i in 0 to 3 loop
         wait until rising_edge(CLK);
        end loop;
        
        wait for 57 ns;
        ASYNC_IN <= '1';
        wait for 250 ns;
        ASYNC_IN <= '0';
        
        wait for 500 ns;
  
        assert false
          report "FIN DEL TESTBENCH"
          severity failure;

    end process;

end tb;