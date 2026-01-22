----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2026 11:31:49
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is
 component top
    Port (
      b_inicio     : in  STD_LOGIC;
      modo         : in  STD_LOGIC_VECTOR (1 downto 0);
      reset_n      : in  STD_LOGIC;
      arriba       : in  STD_LOGIC;
      abajo        : in  STD_LOGIC;
      CLK          : in  STD_LOGIC;
      hitazo       : in  STD_LOGIC;
      inf_displays : out STD_LOGIC_VECTOR (6 downto 0);
      sel_displays : out STD_LOGIC_VECTOR (7 downto 0);
      led_r        : out STD_LOGIC;
      led_g        : out STD_LOGIC;
      led_b        : out STD_LOGIC;
      led_r_final_p: out STD_LOGIC;
      led_g_final_p: out STD_LOGIC;
      led_b_final_p: out STD_LOGIC;
      led_final_g  : out STD_LOGIC_VECTOR(15 downto 0)
    );
  end component;
  
  signal CLK          : std_logic := '0';
  signal reset_n      : std_logic := '0';
  signal b_inicio     : std_logic := '0';
  signal arriba       : std_logic := '0';
  signal abajo        : std_logic := '0';
  signal modo         : std_logic_vector(1 downto 0) := "00";
  signal hitazo       : std_logic := '0';

  signal inf_displays : std_logic_vector(6 downto 0);
  signal sel_displays : std_logic_vector(7 downto 0);
  signal led_r, led_g, led_b : std_logic;
  signal led_r_final_p, led_g_final_p, led_b_final_p : std_logic;
  signal led_final_g : std_logic_vector(15 downto 0);

begin
  
  CLK <= not CLK after 5 ns; -- 100MHz

  dut : top
    port map (
      CLK           => CLK,
      reset_n       => reset_n,
      b_inicio      => b_inicio,
      modo          => modo,
      arriba        => arriba,
      abajo         => abajo,
      hitazo        => hitazo,
      inf_displays  => inf_displays,
      sel_displays  => sel_displays,
      led_r         => led_r,
      led_g         => led_g,
      led_b         => led_b,
      led_r_final_p => led_r_final_p,
      led_g_final_p => led_g_final_p,
      led_b_final_p => led_b_final_p,
      led_final_g   => led_final_g
    );
    
    stimuli : process
     begin
     
      --reset
      reset_n <= '0';
      wait for 100 ns;
      reset_n <= '1';
      wait until rising_edge(CLK);
      
      --elegimos la dificultad
      modo <= "00"; -- fácil
      wait until rising_edge(CLK);
      
      --iniciamos la partida
      b_inicio <= '1';
      wait until rising_edge(CLK);
      b_inicio <= '0'; 
      
      for i in 0 to 5 loop
       wait until rising_edge(CLK);
      end loop;
      
      --Bucles para mover el coche
      for i in 0 to 2 loop
        arriba <= '1';
        wait until rising_edge(CLK);
        arriba <= '0';
        wait for 400 ns;
      end loop;
      
      for i in 0 to 1 loop
        abajo <= '1';
        wait until rising_edge(CLK);
        abajo <= '0';
        wait for 200 ns;
      end loop;
      
      --Dejamos el juego un tiempo
      wait for 200ns;
      
      --Terminamos la simulacion
      assert false
       report "FIN DEL TESTBENCH TOP"
       severity failure;

     end process;
end Behavioral;
