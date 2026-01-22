----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 22:33:04
-- Design Name: 
-- Module Name: FSM_tb - Behavioral
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

entity FSM_tb is
--  Port ( );
end FSM_tb;

architecture tb of FSM_tb is

    component FSM
        port (clk               : in std_logic;
              reset_n           : in std_logic;
              init_pulse        : in std_logic;
              hit               : in std_logic;
              tick_1s           : in std_logic;
              modo_facil        : in std_logic;
              modo_medio        : in std_logic;
              modo_dificil      : in std_logic;
              enable_coche      : out std_logic;
              enable_obstaculos : out std_logic;
              winner            : out std_logic;
              looser            : out std_logic);
    end component;

    signal clk               : std_logic := '0';
    signal reset_n           : std_logic;
    signal init_pulse        : std_logic;
    signal hit               : std_logic;
    signal tick_1s           : std_logic;
    signal modo_facil        : std_logic;
    signal modo_medio        : std_logic;
    signal modo_dificil      : std_logic;
    signal enable_coche      : std_logic;
    signal enable_obstaculos : std_logic;
    signal winner            : std_logic;
    signal looser            : std_logic;


begin
    
    clk <= not clk after 50ns;
    
    dut : FSM
    port map (clk               => clk,
              reset_n           => reset_n,
              init_pulse        => init_pulse,
              hit               => hit,
              tick_1s           => tick_1s,
              modo_facil        => modo_facil,
              modo_medio        => modo_medio,
              modo_dificil      => modo_dificil,
              enable_coche      => enable_coche,
              enable_obstaculos => enable_obstaculos,
              winner            => winner,
              looser            => looser);

    
   

    stimuli : process
    begin
       
       reset_n <= '0';
       
       wait until rising_edge(clk);
       wait for 10ns;
       
       reset_n <= '1';
       modo_facil <= '1';
       modo_medio <= '0';
       modo_dificil <= '0';
       
       wait until rising_edge(clk);
       wait for 10ns;
       
       init_pulse <= '1';
       wait until rising_edge(clk);
       wait for 10 ns;
       init_pulse <= '0';
      
       
       for i in 0 to 25 loop
        tick_1s <= '1';
        wait until rising_edge(clk);
        tick_1s <= '0';
        wait until rising_edge(clk);
       end loop;
       
       for i in 0 to 2 loop
         tick_1s <= '1';
         wait until rising_edge(clk);
         tick_1s <= '0';
         wait until rising_edge(clk);
       end loop;
       
       reset_n <= '0';
       wait until rising_edge(clk);
       wait for 10ns;
       reset_n <= '1';
       
       modo_facil <= '0';
       modo_medio <= '0';
       modo_dificil <= '1';
       
       init_pulse <= '1';
       wait until rising_edge(clk);
       init_pulse <= '0';

       for i in 0 to 2 loop
         tick_1s <= '1';
         wait until rising_edge(clk);
         tick_1s <= '0';
         wait until rising_edge(clk);
       end loop;
       
       hit <= '1';
       tick_1s <= '1';  
       wait until rising_edge(clk);
       tick_1s <= '0';
       hit <= '0';
       wait until rising_edge(clk);
       
       for i in 0 to 6 loop
         tick_1s <= '1';
         wait until rising_edge(clk);
         tick_1s <= '0';
         wait until rising_edge(clk);
       end loop;
       
       assert false
         report "Fin de la simulación"
         severity failure;
        

        wait;
    end process;

end tb;
