----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2026 21:35:52
-- Design Name: 
-- Module Name: coche_tb - Behavioral
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

entity coche_tb is
--  Port ( );
end coche_tb;

architecture tb of coche_tb is

    component coche is
        port (up      : in std_logic;
              down    : in std_logic;
              clk     : in std_logic;
              rst     : in std_logic;
              empezar : in std_logic;
              code    : out std_logic_vector (6 downto 0);
              display : out std_logic);
    end component;

    signal up      : std_logic;
    signal down    : std_logic;
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '1';
    signal empezar : std_logic;
    signal code    : std_logic_vector (6 downto 0);
    signal display : std_logic;

begin
   
    clk <= not clk after 50 ns;
    
    dut : coche
    port map (up      => up,
              down    => down,
              clk     => clk,
              rst     => rst,
              empezar => empezar,
              code    => code,
              display => display);


    stimuli : process
    begin
       
       
       wait for 10ns;
       empezar <= '1';
       wait until rising_edge(clk);
       wait for 10ns;
       up <= '1';
       down <= '0';
       wait until rising_edge(clk);
       wait for 10ns;
       down <= '1';
       up <= '0';
       
       wait until rising_edge(clk);
       wait until rising_edge(clk);
       wait until rising_edge(clk);
       wait until rising_edge(clk);
       
       wait for 5ns;
       
       rst <= '0';
       empezar <= '0';

    end process;

end tb;
