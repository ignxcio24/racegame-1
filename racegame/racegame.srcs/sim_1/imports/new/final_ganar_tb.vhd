----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2026 21:49:16
-- Design Name: 
-- Module Name: final_ganar_tb - Behavioral
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

entity final_ganar_tb is
--  Port ( );
end final_ganar_tb;

architecture tb of final_ganar_tb is

    component final_ganar
        port (clk                : in std_logic;
              ce                 : in std_logic;
              gana               : in std_logic;
              led_encender_ganar : out std_logic_vector (15 downto 0));
    end component;

    signal clk                : std_logic := '0';
    signal ce                 : std_logic;
    signal gana               : std_logic;
    signal led_encender_ganar : std_logic_vector (15 downto 0);

begin

    clk <= not clk after 100ns;
    
    dut : final_ganar
    port map (clk                => clk,
              ce                 => ce,
              gana               => gana,
              led_encender_ganar => led_encender_ganar);

    stimuli : process
     variable i: positive;
    begin
     
        ce <= '0';
        gana <= '0';
        
        for i in 0 to 1 loop
          wait until rising_edge(clk);
        end loop;
        
        ce <= '1';
        
        wait for 50 ns;
        
        gana <= '1';
        
        for i in 0 to 17 loop
          wait until rising_edge(clk);
        end loop;  
        
        ce <= '0';
        gana <= '0';
   
        wait;
    end process;

end tb;
