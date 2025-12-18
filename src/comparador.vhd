----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2025 12:47:54
-- Design Name: 
-- Module Name: comparador - Behavioral
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

entity comparador is


    Port ( n_flancos : in integer;
           --modo_f: in std_logic;
           --modo_m: in std_logic;
           --modo_d: in std_logic;
           modo: in integer;
           modo_div : out integer);
end comparador;

architecture Behavioral of comparador is

begin

 process(n_flancos)

 begin
  if modo = 1 or modo = 2 then
   if n_flancos < 7 then
    modo_div <= 0;
   elsif n_flancos < 20 then
    modo_div <= 1;
   elsif n_flancos < 50 then
    modo_div <= 2;
   end if;
    
  elsif modo = 3 then
   if n_flancos < 14 then
    modo_div <= 0;
   elsif n_flancos < 39 then
    modo_div <= 1;
   elsif n_flancos < 99 then
    modo_div <= 2;
   end if;
  end if;
 
 end process;
end Behavioral;
