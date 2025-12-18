----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2025 18:32:09
-- Design Name: 
-- Module Name: DECODER_MODE - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DECODER_MODE is
port(
 entrada_sw: in std_logic_vector (1 downto 0);
 modo_facil: out std_logic;
 modo_medio: out std_logic;
 modo_dificil: out std_logic
 --led_rojo: out std_logic;
 --led_amarillo: out std_logic;
 --led_verde: out std_logic
); 
end entity DECODER_MODE;

architecture dataflow of DECODER_MODE is
begin
 --Utilizamos estructura when/else para elegir el modo
 modo_facil <= '1' when entrada_sw = "00" else '0';
 modo_medio <= '1' when entrada_sw = "01" else '0';
 modo_dificil <= '1' when entrada_sw = "10" else '0';
 --Dejamos esto así de momento
 modo_dificil <= '1' when entrada_sw = "11" else '0';

 --Los leds depende de si la placa tiene varios colores posibles, eso
 --lo diseño fácil después dependiendo de como sea la placa porque de esa
 --forma cambiarían las salidas

end architecture dataflow;