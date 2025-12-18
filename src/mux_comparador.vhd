----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2025 11:32:48
-- Design Name: 
-- Module Name: mux_comparador - Behavioral
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

entity mux_comparador is
    Port ( n_flancos_g1 : in integer;
           n_flancos_g2 : in integer;
           n_flancos_g3 : in integer;
           modo_f: in std_logic;
           modo_m: in std_logic;
           modo_d: in std_logic;
           n_flancos : out integer);
end mux_comparador;

architecture Behavioral of mux_comparador is

begin
 process(n_flancos_g1,n_flancos_g2, n_flancos_g3)
 begin
 
  if modo_f = '1' then
   n_flancos <= n_flancos_g1;
  elsif modo_m = '1' then
   n_flancos <= n_flancos_g2;
  elsif modo_d = '1' then
   n_flancos <= n_flancos_g3;
  end if;

 end process;
 
end Behavioral;
