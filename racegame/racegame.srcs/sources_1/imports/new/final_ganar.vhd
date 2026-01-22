library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity final_ganar is
  Port (
    clk  : in  std_logic;
    --rst_n: in  std_logic;
    ce   : in  std_logic;
    gana : in  std_logic;
    led_encender_ganar : out std_logic_vector(15 downto 0)
  );
end final_ganar;

architecture Behavioral of final_ganar is
  signal reg_leds : std_logic_vector(15 downto 0) :=  "0000000000000001";
begin

process(clk)
begin
  --if rst_n = '0' then
    --reg_leds <= "0000000000000001";
  if rising_edge(clk) then
    if ce = '1' then
      if gana = '1' then
        -- desplazamiento circular
        reg_leds <= reg_leds(14 downto 0) & reg_leds(15);
      else
        reg_leds <= "0000000000000001";
      end if;
    end if;
  end if;
end process;

led_encender_ganar <= reg_leds;

end Behavioral;
