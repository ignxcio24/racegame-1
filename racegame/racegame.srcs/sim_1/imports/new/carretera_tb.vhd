----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2026 21:48:01
-- Design Name: 
-- Module Name: carretera_tb - Behavioral
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

entity carretera_tb is
--  Port ( );
end carretera_tb;

architecture tb of carretera_tb is

    component carretera
        port (clk          : in std_logic;
              rst          : in std_logic;
              CE           : in std_logic;
              modo_f       : in std_logic;
              modo_m       : in std_logic;
              modo_d       : in std_logic;
              road         : out std_logic_vector (55 downto 0);
              s_toggle_out : out std_logic);
    end component;

    signal clk          : std_logic := '0';
    signal rst          : std_logic;
    signal CE           : std_logic;
    signal modo_f       : std_logic;
    signal modo_m       : std_logic;
    signal modo_d       : std_logic;
    signal road         : std_logic_vector (55 downto 0);
    signal s_toggle_out : std_logic;
    

begin
     clk <= not clk after 50 ns;

    dut : carretera
    port map (clk          => clk,
              rst          => rst,
              CE           => CE,
              modo_f       => modo_f,
              modo_m       => modo_m,
              modo_d       => modo_d,
              road         => road,
              s_toggle_out => s_toggle_out);



    stimuli : process
        variable i: positive;
    begin
        -- ***EDIT*** Adapt initialization as needed
        CE <= '1';
        modo_f <= '1';
        modo_m <= '0';
        modo_d <= '0';
        rst <= '1';
        
        wait until rising_edge(clk);
        wait for 10ns;
        
        rst <= '0';
        wait until rising_edge(clk);
        wait for 10ns;
        
        rst <= '1';
        modo_f <= '1';
        for i in 0 to 5 loop
          wait until rising_edge(clk);
        end loop;
        
        rst <= '0';   -- activa reset
        wait until rising_edge(clk);
        wait for 10 ns;
        rst <= '1';   -- desactiva reset y vuelve a posición inicial
        
        modo_m <= '1';
        modo_f <= '0';
        for i in 0 to 20 loop
          wait until rising_edge(clk);
        end loop;
       
        rst <= '0';   -- activa reset
        wait until rising_edge(clk);
        wait for 10 ns;
        rst <= '1';   -- desactiva reset y vuelve a posición inicial
        
        modo_d <= '1';
        modo_m <= '0';
        for i in 0 to 5 loop
          wait until rising_edge(clk);
        end loop;
        
        wait;
    end process;

end tb;
