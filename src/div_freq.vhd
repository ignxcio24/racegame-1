----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2025 18:04:40
-- Design Name: 
-- Module Name: div_freq - Behavioral
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

entity div_freq is
    Port ( clk : in STD_LOGIC;
           reset: in std_logic;
           --modo_f: in std_logic;
           --modo_m: in std_logic;
           --modo_d: in std_logic;
           modo: in integer;
           modo_div : in integer;
           tick: out std_logic);
           --clk_mod : out STD_LOGIC);
           
end div_freq;

architecture Behavioral of div_freq is

 signal limit: integer;
 signal counter: integer := 0;
 
begin
 
process(clk)
 
 
 begin
 
 if rising_edge(clk) then
        if reset = '0' then
            counter <= 0;
            tick <= '0';
        else
        -- Selección del divisor
        if modo = 1 or modo = 2 then
           case modo_div is
              when 0 => limit <= 300000000;
              when 1 => limit <= 200000000;
              when 2 => limit <= 100000000;
              when others => limit <= 300000000;
            end case;
         elsif modo = 3 then
            case modo_div is
               when 0 => limit <= 150000000;
               when 1 => limit <= 100000000;
               when 2 => limit <= 50000000;
               when others => limit <= 150000000;
               end case;
         end if;

            -- Contador
            if counter = limit then
                counter <= 0;
                tick <= '1';   -- pulso de 1 ciclo
            else
                counter <= counter + 1;
                tick <= '0';
            end if;
          end if;
    end if;
end process;


end Behavioral;
