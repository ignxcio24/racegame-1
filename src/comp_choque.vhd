----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2025 11:51:29
-- Design Name: 
-- Module Name: comp_choque - Behavioral
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

entity comp_choque is
    Port ( fin_carretera : in STD_LOGIC_VECTOR (6 downto 0);
           pos_coche : in STD_LOGIC_VECTOR (6 downto 0);

           clk: in std_logic;
           
           choque : out STD_LOGIC);
end comp_choque;

architecture Behavioral of comp_choque is

 
begin
 choque <= '0';
process(clk)
 variable fin_carretera_i: std_logic_vector(2 downto 0);
 variable pos_coche_i: std_logic_vector(2 downto 0);
 
  variable res_mascara: std_logic_vector(2 downto 0); 
begin
 if clk = '1' then
 fin_carretera_i := fin_carretera(6) &  fin_carretera(0) & fin_carretera(3);
 pos_coche_i := pos_coche(6) &  pos_coche(0) & pos_coche(3);
 
 res_mascara := fin_carretera_i and pos_coche_i;
 
 case res_mascara is
  when "000" =>  choque <= '0';
  when others => choque <= '1';
 end case; 
  
 end if;
end process;
end Behavioral;
