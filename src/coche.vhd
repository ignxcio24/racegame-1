----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2025 16:53:23
-- Design Name: 
-- Module Name: coche - Behavioral
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
use work.variables.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity coche is
    Port ( up : in STD_LOGIC;
           down : in STD_LOGIC;
           clk : in STD_LOGIC; 
           empezar: in std_logic;
           choque: in std_logic;
           code : out std_logic_vector(6 downto 0);
           display : out std_logic;
           luz: out std_logic
           );
end coche;

architecture Behavioral of coche is
 signal pos: integer:= 1;
begin
 process(clk)
 begin
  if rising_edge(clk) then
  if choque = '0' then
   if empezar = '1' then
    if up = '1' then
     if pos < 2 then
      pos <= pos + 1;
     end if;
    elsif down = '1' then
     if pos > 0 then
      pos <= pos - 1;
    end if;
   end if;
   end if;
  else
   luz <= '1';
  end if;
  end if;
  end process;
  
 process(pos)
  begin
  if empezar = '1' then
   case pos is
    when 2 => code <= "1000000";
    when 1 => code <= "0000001";
    when 0 => code <= "0001000";
    when others => code <= "0000000";
   end case;
   
   display <= '0';
  end if;
  end process;
 
end Behavioral;
