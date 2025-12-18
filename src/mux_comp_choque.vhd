----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2025 09:28:48
-- Design Name: 
-- Module Name: mux_comp_choque - Behavioral
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

entity mux_comp_choque is
    Port ( inf_carr_1 : in STD_LOGIC_VECTOR (0 downto 0);
           inf_carr_2 : in STD_LOGIC_VECTOR (6 downto 0);
           inf_carr_3 : in STD_LOGIC_VECTOR (6 downto 0);
           inf_coche_origen : in STD_LOGIC_VECTOR (6 downto 0);
           modo_f: in std_logic;
           modo_m: in std_logic;
           modo_d: in std_logic;
           inf_carr : out STD_LOGIC_VECTOR (6 downto 0);
           inf_coche : out STD_LOGIC_VECTOR (6 downto 0));
end mux_comp_choque;

architecture Behavioral of mux_comp_choque is

begin
 process(inf_carr_1, inf_carr_2, inf_carr_3, inf_coche_origen)
 begin
 
  if modo_f = '1' then
   inf_carr <= inf_carr_1;
   inf_coche <= inf_coche_origen;
  elsif modo_m = '1' then 
   inf_carr <= inf_carr_2;
   inf_coche <= inf_coche_origen;
  elsif modo_d = '1' then
   inf_carr <= inf_carr_3;
   inf_coche <= inf_coche_origen;
  end if;
 end process;

end Behavioral;
