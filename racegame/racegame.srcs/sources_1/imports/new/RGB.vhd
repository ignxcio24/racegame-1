----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2025 16:13:53
-- Design Name: 
-- Module Name: RGB - Behavioral
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

entity RGB is
    Port ( modo_f : in STD_LOGIC;
           modo_m : in STD_LOGIC;
           modo_d : in STD_LOGIC;
           led_r : out STD_LOGIC;
           led_g : out STD_LOGIC;
           led_b : out STD_LOGIC);
end RGB;

architecture Behavioral of RGB is

begin
 process(modo_f, modo_d, modo_m)
    begin
        if modo_f = '1' then   
           led_r<= '0';
           led_g<='1';
           led_b<='0';
        
        elsif modo_m = '1' then
             led_r<= '0';
             led_g<='0';
             led_b<='1';
        elsif modo_d ='1' then   
           led_r<= '1';
           led_g<='0';
           led_b<='0';
        else 
           led_r<= '0';
           led_g<='0';
           led_b<='0';
        end if;
    end process;


end Behavioral;
