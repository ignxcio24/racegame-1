----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2025 12:57:58
-- Design Name: 
-- Module Name: cont_flancos - Behavioral
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

entity cont_flancos is
    Port ( clk_mod : in STD_LOGIC;
           n_flancos : out integer);
end cont_flancos;

architecture Behavioral of cont_flancos is
 signal cont: integer:= 0;
begin
 process(clk_mod)
 begin
  if rising_edge(clk_mod) then
   cont <= cont + 1;
  end if;
 end process;
 n_flancos <= cont;

end Behavioral;
