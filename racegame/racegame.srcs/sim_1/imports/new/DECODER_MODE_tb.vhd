----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2026 22:24:57
-- Design Name: 
-- Module Name: DECODER_MODE_tb - Behavioral
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

entity DECODER_MODE_tb is
--  Port ( );
end DECODER_MODE_tb;

architecture tb of DECODER_MODE_tb is

    component DECODER_MODE
        port (entrada_sw   : in std_logic_vector (1 downto 0);
              modo_facil   : out std_logic;
              modo_medio   : out std_logic;
              modo_dificil : out std_logic);
    end component;

    signal entrada_sw   : std_logic_vector (1 downto 0);
    signal modo_facil   : std_logic;
    signal modo_medio   : std_logic;
    signal modo_dificil : std_logic;

begin

    dut : DECODER_MODE
    port map (entrada_sw   => entrada_sw,
              modo_facil   => modo_facil,
              modo_medio   => modo_medio,
              modo_dificil => modo_dificil);

    stimuli : process
    begin
        
        entrada_sw <= "00";
        wait for 30ns;
        
        entrada_sw <= "10";
        wait for 30ns;
        
        entrada_sw <= "01";
        wait for 30ns;
        
        entrada_sw <= "11";
        wait for 30ns;
       
        assert false
          report "FIN DEL TESTBENCH"
          severity failure;
    end process;

end tb;