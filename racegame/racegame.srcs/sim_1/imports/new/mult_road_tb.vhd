----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 14:01:13
-- Design Name: 
-- Module Name: mult_road_tb - Behavioral
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

entity mult_road_tb is
--  Port ( );
end mult_road_tb;

architecture tb of mult_road_tb is

    component mult_road
        ----- Simulacion
        --generic (
          --  G_MUX_FREQ_DIV : natural := 100000  -- valor REAL (hardware)
        --);
        ------
        port (CLK           : in std_logic;
              RST           : in std_logic;
              ROAD_ARRAY_IN : in std_logic_vector (55 downto 0);
              SEGMENTS_OUT  : out std_logic_vector (6 downto 0);
              ANODES_OUT    : out std_logic_vector (7 downto 0));
    end component;

    signal CLK           : std_logic := '0';
    signal RST           : std_logic;
    signal ROAD_ARRAY_IN : std_logic_vector (55 downto 0);
    signal SEGMENTS_OUT  : std_logic_vector (6 downto 0);
    signal ANODES_OUT    : std_logic_vector (7 downto 0);


begin

    CLK <= not CLK after 50 ns;

    dut : mult_road
    -------- Simulacion
    --generic map (
      --G_MUX_FREQ_DIV => 4   -- valor pequeño SOLO para simulación
    --)
    ---------
    port map (CLK           => CLK,
              RST           => RST,
              ROAD_ARRAY_IN => ROAD_ARRAY_IN,
              SEGMENTS_OUT  => SEGMENTS_OUT,
              ANODES_OUT    => ANODES_OUT);

    stimuli : process
    begin
        
        ROAD_ARRAY_IN <= (others => '1');
        RST <= '0';
        
        wait until rising_edge(CLK);
        wait until rising_edge(CLK);
        wait for 10ns;
        
        RST <= '1';
        
        ROAD_ARRAY_IN <= "10010001101000001100001110001010000111100000010001101000";

        wait;
    end process;

end tb;