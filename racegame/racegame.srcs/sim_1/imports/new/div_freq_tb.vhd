----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.01.2026 22:34:42
-- Design Name: 
-- Module Name: div_freq_tb - Behavioral
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

entity div_freq_tb is
--  Port ( );
end div_freq_tb;

architecture tb of div_freq_tb is

    component div_freq
        port (clk      : in std_logic;
              reset    : in std_logic;
              modo_f   : in std_logic;
              modo_m   : in std_logic;
              modo_d   : in std_logic;
              modo_div : in integer;
              tick     : out std_logic);
    end component;

    signal clk      : std_logic := '0';
    signal reset    : std_logic;
    signal modo_f   : std_logic;
    signal modo_m   : std_logic;
    signal modo_d   : std_logic;
    signal modo_div : integer;
    signal tick     : std_logic;

begin
    clk <= not clk after 1 ns;
    
    dut : div_freq
    port map (clk      => clk,
              reset    => reset,
              modo_f   => modo_f,
              modo_m   => modo_m,
              modo_d   => modo_d,
              modo_div => modo_div,
              tick     => tick);



    stimuli : process
      variable modo : integer;
    begin  
       
       reset <= '0';
       wait until rising_edge(clk);
       wait until rising_edge(clk);
       reset <= '1';

        modo_f <= '1';
        modo_m <= '0';
        modo_d <= '0';
        modo_div <= 0;
        
        for modo in 0 to 2 loop
          modo_div <= modo;

          wait until rising_edge(tick);
          wait until rising_edge(clk);
        end loop;
        
        modo_f <= '0';
        modo_m <= '1';
        modo_d <= '0';
        modo_div <= 0;
        
        for modo in 0 to 2 loop
         modo_div <= modo;

         wait until rising_edge(tick);
         wait until rising_edge(clk);
        end loop;        
        
        modo_f <= '0';
        modo_m <= '0';
        modo_d <= '1';
        modo_div <= 0;
        
        for modo in 0 to 2 loop
         modo_div <= modo;
         
         wait until rising_edge(tick);
         wait until rising_edge(clk);
        end loop;
            
        
        reset <= '0';  
        modo_div <= 0;
         
        wait until rising_edge(clk); 
        wait until rising_edge(clk);  
  
        reset <= '1'; 
         
        wait until rising_edge(tick);
      wait;
    end process;

end tb;