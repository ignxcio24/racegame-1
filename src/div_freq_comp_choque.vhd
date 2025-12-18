----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2025 22:46:18
-- Design Name: 
-- Module Name: div_freq_comp_choque - Behavioral
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

entity div_freq_comp_choque is
    Port ( enable : in STD_LOGIC;
           accion : out STD_LOGIC);
end div_freq_comp_choque;

architecture Behavioral of div_freq_comp_choque is
 
begin
 process(enable)
  --variable cont: integer := 50000000;
 begin
  if enable = '1' then
   accion <= '1';
  else
   accion <= '0';
  end if;
 end process;
end Behavioral;
