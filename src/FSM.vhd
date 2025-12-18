----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2025 18:29:42
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    port (
        clk: in  std_logic;
        reset: in  std_logic;  -- reset asíncrono activo alto
	
	    --Botón de inicio
        init_pulse     : in  std_logic;
	    --Cuando hay colisión se pone a uno  
        hit            : in  std_logic;  
	    --Pulso cada segundo durante un ciclo de reloj(viene del divisor
	    --de frecuencia)
        tick_1s        : in  std_logic;  

        --Modos que llegan desde el decoder
        modo_facil     : in  std_logic;
        modo_medio     : in  std_logic;
        modo_dificil   : in  std_logic;

        --Salidas de de los enable y reset
        enable_coche       : out std_logic;
        enable_obstaculos  : out std_logic;
        --reset_juego        : out std_logic;

        --Salidas para dificultad (hacia obstáculos)
        --en_facil   : out std_logic;
        --en_medio   : out std_logic;
        --en_dificil : out std_logic
        en_modo :out integer

        -- Salidas para el display (para que el driver sepa qué mostrar)
        --show_wait      : out std_logic;
        --show_play      : out std_logic;
        --show_gameover  : out std_logic
    );
end entity FSM;

architecture behavioral of FSM is

    --Estados del juego
    type state_type is (ESPERANDO, JUGANDO, GAME_OVER);
    signal state_reg, state_next : state_type;

    --Contador de segundos en GAME_OVER
    constant GAMEOVER_TIME : natural := 4;  -- segundos que dura GAME OVER
    --Es el contador, va de 0 a 4 pero tiene longitud de 7
    signal go_counter      : unsigned(2 downto 0) := (others => '0'); 

begin

    --Process que actualiza el estado actual, trata el reset y el contador
    process(clk, reset)
    begin
        if reset = '0' then
            state_reg <= ESPERANDO;
            go_counter <= (others => '0');

        elsif rising_edge(clk) then
            -- Actualizamos el estado
            state_reg <= state_next;

            --Si ha llegado a GAME OVER, se va sumando el contador por 
            -- el pulso del divisor de frecuencia
            if state_reg = GAME_OVER then
                if tick_1s = '1' then
                    if go_counter < GAMEOVER_TIME then
                        go_counter <= go_counter + 1;
                    end if;
                end if;
            else
                -- Si no es GAME OVER, contador a cero
                go_counter <= (others => '0');
            end if;
        end if;
    end process;

    --Process que trata el cambio de estado
    process(state_reg, init_pulse, hit, go_counter)
    begin
        -- Si nos quedamos en el mismo estado
        state_next <= state_reg;

        case state_reg is

            -- Cambio de estado ESPERANDO -> JUGANDO
            when ESPERANDO =>
                if init_pulse = '1' then
                    state_next <= JUGANDO;
                end if;

            -- Cambio de estado JUGANDO -> GAME_OVER
            when JUGANDO =>
                if hit = '1' then
                    state_next <= GAME_OVER;
                end if;

            -- Cambio de estado GAME OVER -> ESPERANDO
            when GAME_OVER =>
                -- Cuando el contador llegue a GAMEOVER_TIME, volvemos a ESPERANDO
                if to_integer(go_counter) >= GAMEOVER_TIME then
                    state_next <= ESPERANDO;
                end if;

        end case;
    end process;

    --Salidas de la FSM
    process(state_reg, modo_facil, modo_medio, modo_dificil)
    begin
        --Inicializamos valores
	
        enable_coche      <= '0';
        enable_obstaculos <= '0';
        --reset_juego       <= '0';

        --en_facil   <= '0';
        --en_medio   <= '0';
        --en_dificil <= '0';
        en_modo <= 0;

        --show_wait     <= '0';
        --show_play     <= '0';
        --show_gameover <= '0';

        case state_reg is

            when ESPERANDO =>
                --Si estamos en esperando, todo en la posición inicial
                enable_coche      <= '0';
                enable_obstaculos <= '0';
                --reset_juego       <= '1';    -- coche y obstáculos en posición inicial
                --show_wait         <= '1';    -- el driver de display puede mostrar pantalla negra / READY

            when JUGANDO =>
		--Estamos jugando
                enable_coche      <= '1';
                enable_obstaculos <= '1';
                --reset_juego       <= '0';
                --show_play         <= '1';

                -- Activamos solo el modo que diga el decoder
                --en_facil   <= modo_facil;
                --en_medio   <= modo_medio;
                --en_dificil <= modo_dificil;
                if modo_facil <= '1' then 
                 en_modo <= 1;
                elsif modo_medio <= '1' then
                 en_modo <= 2;
                elsif modo_dificil <= '1' then
                 en_modo <= 3;
                end if;

            when GAME_OVER =>
                enable_coche      <= '0';
                enable_obstaculos <= '0';
                --reset_juego       <= '0';
                --show_gameover     <= '1';

        end case;
    end process;

end architecture behavioral;
