----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2026 22:38:23
-- Design Name: 
-- Module Name: RGB_tb - Behavioral
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

entity RGB_tb is
--  Port ( );
end RGB_tb;

architecture tb of RGB_tb is

    component RGB
        port (modo_f : in std_logic;
              modo_m : in std_logic;
              modo_d : in std_logic;
              led_r  : out std_logic;
              led_g  : out std_logic;
              led_b  : out std_logic);
    end component;

    signal modo_f : std_logic := '0';
    signal modo_m : std_logic := '0';
    signal modo_d : std_logic := '0';
    signal led_r  : std_logic;
    signal led_g  : std_logic;
    signal led_b  : std_logic;

begin

    dut : RGB
    port map (modo_f => modo_f,
              modo_m => modo_m,
              modo_d => modo_d,
              led_r  => led_r,
              led_g  => led_g,
              led_b  => led_b);

    stimuli : process
    begin
      
      modo_f <= '1';
      wait for 20ns;
      
      modo_f <= '0';
      modo_m <= '1';
      wait for 20ns;
      
      modo_m <= '0';
      modo_d <= '1';
      wait for 20ns;
      
      assert false
        report "FIN DEL TESTBENCH"
        severity failure;
        
    end process;

end tb;