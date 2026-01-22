----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 13:34:58
-- Design Name: 
-- Module Name: comp_choque_tb - Behavioral
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

entity comp_choque_tb is
--  Port ( );
end comp_choque_tb;

architecture tb of comp_choque_tb is

    component comp_choque
        port (fin_carretera : in std_logic_vector (6 downto 0);
              pos_coche     : in std_logic_vector (6 downto 0);
              clk           : in std_logic;
              choque        : out std_logic);
    end component;

    signal fin_carretera : std_logic_vector (6 downto 0);
    signal pos_coche     : std_logic_vector (6 downto 0);
    signal clk           : std_logic;
    signal choque        : std_logic;

begin

    dut : comp_choque
    port map (fin_carretera => fin_carretera,
              pos_coche     => pos_coche,
              clk           => clk,
              choque        => choque);

    stimuli : process
    begin
       --Utilizamod los tres posibles casos que puede tomar la carretera
       fin_carretera <= "0001001";
       pos_coche <= "1000000";
       wait for 5ns;
       pos_coche <= "0001000";
       wait for 5ns;
       pos_coche <= "0000001";
       wait for 5ns;
        
       fin_carretera <= "1000001";
       pos_coche <= "1000000";
       wait for 5ns;
       pos_coche <= "0001000";
       wait for 5ns;
       pos_coche <= "0000001";
       wait for 5ns;
       
       fin_carretera <= "1001000"; 
       pos_coche <= "1000000";
       wait for 5ns;
       pos_coche <= "0001000";
       wait for 5ns;
       pos_coche <= "0000001";
       wait for 5ns;
       
       assert false
         report "Fin de la simulación, todas las comprobaciones hechas"
         severity failure;
         
    end process;
end tb;
