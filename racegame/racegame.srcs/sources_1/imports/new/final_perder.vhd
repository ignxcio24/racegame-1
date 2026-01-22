----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2025 21:28:57
-- Design Name: 
-- Module Name: final_perder - Behavioral
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

entity final_perder is
    Port ( pierde : in STD_LOGIC;
           clk: in std_logic;
           ce: in std_logic;
           led_r : out STD_LOGIC;
           led_g : out STD_LOGIC;
           led_b : out STD_LOGIC);
end final_perder;

architecture Behavioral of final_perder is
 signal toggle: std_logic:='0';
begin

process(clk)
begin
 if rising_edge(clk) then
 if ce ='1' then
  if pierde = '0' then
   led_r <= '0';
   led_g <= '0';
   led_b <= '0';
  elsif pierde = '1' then
   if toggle = '0' then
    led_r <= '0';
    led_g <= '0';
    led_b <= '0';
    toggle <= '1';
   elsif toggle = '1' then
    led_r <= '1';
    led_g <= '0';
    led_b <= '0';
    toggle <= '0';
   end if;
  end if;
  end if;
 end if;

end process;

end Behavioral;
