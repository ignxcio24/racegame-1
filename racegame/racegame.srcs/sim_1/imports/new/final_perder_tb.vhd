----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 22:08:29
-- Design Name: 
-- Module Name: final_perder_tb - Behavioral
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

entity final_perder_tb is
--  Port ( );
end final_perder_tb;

architecture tb of final_perder_tb is

    component final_perder
        port (pierde : in std_logic;
              clk    : in std_logic;
              ce     : in std_logic;
              led_r  : out std_logic;
              led_g  : out std_logic;
              led_b  : out std_logic);
    end component;

    signal pierde : std_logic;
    signal clk    : std_logic := '0';
    signal ce     : std_logic;
    signal led_r  : std_logic;
    signal led_g  : std_logic;
    signal led_b  : std_logic;

begin

    clk <= not clk after 50 ns;

    dut : final_perder
    port map (pierde => pierde,
              clk    => clk,
              ce     => ce,
              led_r  => led_r,
              led_g  => led_g,
              led_b  => led_b);


    stimuli : process
     variable i: positive;
    begin
       
       ce <= '0';
       wait until rising_edge(clk);
       wait for 10ns;
       
       ce <= '1';
       pierde <= '0';
       wait until rising_edge(clk);
       wait for 10ns;
       
       pierde <= '1';
       
       for i in 0 to 8 loop
        wait until rising_edge(clk);
        wait for 10ns;
       end loop;
       
       pierde <= '0';
       
       for i in 0 to 3 loop
        wait until rising_edge(clk);
        wait for 10ns;
       end loop;
       
       ce <= '0';
       
       for i in 0 to 3 loop
        wait until rising_edge(clk);
        wait for 10ns;
       end loop;

       assert false
         report "Fin de la simulación"
         severity failure;
        
    end process;

end tb;