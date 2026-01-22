----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.01.2026 21:42:40
-- Design Name: 
-- Module Name: comparador_tb - Behavioral
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

entity comparador_tb is
--  Port ( );
end comparador_tb;

architecture tb of comparador_tb is

    component comparador
        port (n_flancos : in integer;
              modo_f    : in std_logic;
              modo_m    : in std_logic;
              modo_d    : in std_logic;
              modo_div  : out integer);
    end component;

    signal n_flancos : integer;
    signal modo_f    : std_logic;
    signal modo_m    : std_logic;
    signal modo_d    : std_logic;
    signal modo_div  : integer;

begin

    dut : comparador
    port map (n_flancos => n_flancos,
              modo_f    => modo_f,
              modo_m    => modo_m,
              modo_d    => modo_d,
              modo_div  => modo_div);


    stimuli : process
     variable cnt : integer;
    begin
        cnt := 0;
        n_flancos <= 0;
        modo_f <= '1';
        modo_m <= '0';
        modo_d <= '0';

        while cnt < 30 loop
         cnt := cnt + 1;
         n_flancos <= cnt;
         wait for 1 ns;  
        end loop;
        
        cnt := 0;
        n_flancos <= 0;
        modo_f <= '0';
        modo_m <= '1';
        modo_d <= '0';

        while cnt < 30 loop
         cnt := cnt + 1;
         n_flancos <= cnt;
         wait for 1 ns;
        end loop;
        
        cnt := 0;
        n_flancos <= 0;
        modo_f <= '0';
        modo_m <= '0';
        modo_d <= '1';

        while cnt < 30 loop
         cnt := cnt + 1;
         n_flancos <= cnt;
         wait for 1 ns;  
        end loop;

         wait;
    end process;

end tb;
