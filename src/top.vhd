----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2025 17:21:19
-- Design Name: 
-- Module Name: top - Behavioral
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


          
          

entity top is
    Port ( b_inicio : in STD_LOGIC;
           modo : in STD_LOGIC_VECTOR (1 downto 0); --constrains->SW
           reset : in STD_LOGIC;
           arriba : in STD_LOGIC;
           abajo : in STD_LOGIC;
           CLK : in STD_LOGIC;
           inf_displays : out STD_LOGIC_VECTOR (6 downto 0);
           sel_displays : out STD_LOGIC_VECTOR (7 downto 0);
           exit_led: out std_logic
           
           --inf_coche_d : out STD_LOGIC_VECTOR (6 downto 0)
           --led_rgb : out STD_LOGIC);
           );
    end top;


architecture Behavioral of top is
component coche is
 Port ( up : in STD_LOGIC;
        down : in STD_LOGIC;
        clk : in STD_LOGIC; 
        empezar: in std_logic;
        choque: in std_logic;
        code : out std_logic_vector(6 downto 0);
        display : out std_logic;
        luz: out std_logic
       );
end component;

component EDGEDTCTR is
 Port ( CLK : in STD_LOGIC;
        SYNC_IN : in STD_LOGIC;
        EDGE : out STD_LOGIC
       );
end component;

component SYNCHRNZR is
 Port ( CLK : in STD_LOGIC;
        ASYNC_IN : in STD_LOGIC;
        SYNC_OUT : out STD_LOGIC);
end component;

component FSM is
  port (
        clk            : in  std_logic;
        reset          : in  std_logic;  -- reset asíncrono activo alto
	    --Botón de inicio
        init_pulse     : in  std_logic;
	    --Cuando hay colisión se pone a uno  
        hit            : in  std_logic;  
	    --Pulso cada segundo durante un ciclo de reloj(viene del divisor de frecuencia)
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
end component;

component cont_flancos is
    Port ( clk_mod : in STD_LOGIC;
           n_flancos : out integer);
end component;

component DECODER_MODE is
port(
 entrada_sw: in std_logic_vector (1 downto 0);
 modo_facil: out std_logic;
 modo_medio: out std_logic;
 modo_dificil: out std_logic
 --led_rojo: out std_logic
 --led_amarillo: out std_logic
 --led_verde: out std_logic
); 

end component;

component comparador is
    Port ( n_flancos : in integer;
            --modo_f: in std_logic;
           --modo_m: in std_logic;
           --modo_d: in std_logic;
           modo: in integer;
           modo_div : out integer);
end component;

component comp_choque is
    Port ( fin_carretera : in STD_LOGIC_VECTOR (6 downto 0);
           pos_coche : in STD_LOGIC_VECTOR (6 downto 0);
           clk: in std_logic;
           
           choque : out STD_LOGIC);
end component;

component div_freq is
    Port ( clk : in STD_LOGIC;
           reset: in std_logic;
           --modo_f: in std_logic;
           --modo_m: in std_logic;
           --modo_d: in std_logic;
           modo: in integer;
           modo_div : in integer;
           tick: out std_logic);
           --clk_mod : out STD_LOGIC);
end component;

component carretera is
generic (
    ROAD_LENGTH: natural := 8;  -- Ahora son 8 displays (AN7 a AN0)
    segment : natural := 7    
);
Port ( 
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    CE : in STD_LOGIC;
    --modo_f: in STD_LOGIC;
    --modo_m: in STD_LOGIC;
    --modo_d: in STD_LOGIC;
    modo: in integer;
    mover: in std_logic;
    
    -- SALIDA de 56 BITS (8 displays * 7 segmentos)
    road: out std_logic_vector(55 downto 0); 
    s_toggle_out : out STD_LOGIC
);
end component;


component mult_road is
    Port (
        CLK             : in  STD_LOGIC;                               
        RST             : in  STD_LOGIC;
        --freq: in integer;
        -- ENTRADA: Vector de 56 bits
        ROAD_ARRAY_IN   : in  STD_LOGIC_VECTOR(55 downto 0); 
        --code_coche   : in  STD_LOGIC_VECTOR(6 downto 0); 
        -- SALIDAS FÍSICAS
        SEGMENTS_OUT    : out STD_LOGIC_VECTOR(6 downto 0);             
        ANODES_OUT      : out STD_LOGIC_VECTOR(7 downto 0)              
    );
end component;
component div_freq_comp_choque is
    Port ( enable : in STD_LOGIC;
           accion : out STD_LOGIC);
end component;

signal ROAD_LENGTH_s: natural := 8; 
signal segment_s : natural := 7;

signal s1: std_logic;
signal s2: std_logic;

signal s3: std_logic;
signal s4: std_logic;

signal s5: std_logic;
signal s6: std_logic;

signal s_toggle: std_logic;
signal s_mux_anodes: std_logic_vector(7 downto 0);
signal mover_car: std_logic;
signal accion_comp: std_logic;

signal modo_juego: std_logic;
signal choque_s: std_logic;
signal tick_aux: std_logic;
signal enable_coche: std_logic;

signal mod_facil: std_logic;
signal mod_med: std_logic;
signal mod_dif: std_logic;

--signal en_mod_facil: std_logic;
--signal en_mod_med: std_logic;
--signal en_mod_dif: std_logic;
signal en_mod: integer;

signal inicio_carr: std_logic;
signal clk_mod_s: std_logic;
signal num_flancos: integer;
signal mod_div: integer;

signal cod_carr: STD_LOGIC_VECTOR (6 downto 0);
signal cod_coche: STD_LOGIC_VECTOR (6 downto 0);
signal reloj_choque: STD_LOGIC;

signal sal_disply_coche: STD_LOGIC_VECTOR (6 downto 0);

signal inf_carr_sal_gen : STD_LOGIC_VECTOR (55 downto 0);
signal cod_carr_sel:STD_LOGIC_VECTOR (6 downto 0);
signal inf_completa: std_logic_vector(55 downto 0);
signal inf_carr_ocho_dis: std_logic_vector(55 downto 0);
signal inf_a_comparar:STD_LOGIC_VECTOR (6 downto 0);
signal coche_activo : std_logic;

signal ex_choque: std_logic;

--Prueba
--constant CLK_DIV_COUNT : natural := 100000000; -- Para generar 1 Hz
--signal s_ce_counter       : natural range 0 to CLK_DIV_COUNT - 1 := 0; 
--signal s_game_ce_lento    : STD_LOGIC := '0'; -- El pulso lento para CE
--
begin

-------
 --process(clk, reset)
   -- begin
     --   if reset = '0' then
       --     s_ce_counter <= 0;
         --   s_game_ce_lento <= '0';
        --elsif rising_edge(clk) then
          --  if inicio_carr = '1' then -- El switch CE (J15) debe estar en '1' para iniciar el movimiento
            --    if s_ce_counter = CLK_DIV_COUNT - 1 then
              --      s_ce_counter <= 0;
                --    s_game_ce_lento <= '1'; -- Pulso de un ciclo
                --else
                 --   s_ce_counter <= s_ce_counter + 1;
                   -- s_game_ce_lento <= '0'; 
                --end if;
            --else
              --  s_ce_counter <= 0;
                --s_game_ce_lento <= '0';
          --  end if;
        --end if;
    --end process;
 ----------
vehiculo: coche port map(
  up => s3,
  down=> s4,
  clk => CLK, 
  code => sal_disply_coche,
  choque => ex_choque,
  empezar => enable_coche,
  display => coche_activo,
  luz => exit_led
  );
  
  
  
SIN1: SYNCHRNZR port map(
  ASYNC_IN => arriba,
  CLK => CLK,
  SYNC_OUT=>s1);
  
SIN2: SYNCHRNZR port map(
  ASYNC_IN => abajo,
  CLK => CLK,
  SYNC_OUT=>s2);
  
edg1: EDGEDTCTR port map( 
           CLK => CLK,
           SYNC_IN=> s1,
           EDGE => s3
       );
       
 edg2: EDGEDTCTR port map( 
           CLK => CLK,
           SYNC_IN=> s2,
           EDGE => s4
       );
       
 maq: FSM port map(
        clk => CLK,
        reset => reset,
        init_pulse=>s6,  
        hit=> ex_choque, 
        tick_1s=> tick_aux,  
        modo_facil=> mod_facil,
        modo_medio=> mod_med,
        modo_dificil=> mod_dif,
        enable_coche => enable_coche,
        enable_obstaculos=> inicio_carr,
        --reset_juego        : out std_logic;
        --en_facil => en_mod_facil,
        --en_medio => en_mod_med,
        --en_dificil => en_mod_dif
        en_modo => en_mod
        --show_wait      : out std_logic;
        --show_play      : out std_logic;
        --show_gameover  : out std_logic
    );
  
 SIN_ini: SYNCHRNZR port map(
  ASYNC_IN => b_inicio,
  CLK => CLK,
  SYNC_OUT=>s5);
  
 edg_ini: EDGEDTCTR port map( 
           CLK => CLK,
           SYNC_IN=> s5,
           EDGE => s6
       );

decoder: DECODER_MODE port map(
 entrada_sw=> modo,
 modo_facil=> mod_facil,
 modo_medio=> mod_med,
 modo_dificil=> mod_dif
 --led_rojo: out std_logic
 --led_amarillo: out std_logic
 --led_verde: out std_logic
); 

contador: cont_flancos Port map ( 
     --clk_mod => clk_mod_s,
     clk_mod => clk,
     n_flancos => num_flancos
);

controlador: comparador port map(
           n_flancos =>  num_flancos,
           --modo_f => en_mod_facil,
           --modo_m => en_mod_med,
           --modo_d => en_mod_dif,
           modo => en_mod,
           modo_div => mod_div
);

choque: comp_choque port map( 
           --fin_carretera => cod_carr,
           fin_carretera => inf_a_comparar,
           pos_coche => sal_disply_coche,
           clk => accion_comp,

           choque => ex_choque
);

div_car: div_freq Port map(
       clk => CLK,
       reset => reset,
       --modo_f => en_mod_facil, 
       --modo_m => en_mod_med,
       --modo_d => en_mod_dif,
       modo => en_mod,
       modo_div => mod_div,
       tick => clk_mod_s
           --clk_mod => 
);

hab_comp_choque: div_freq_comp_choque Port map
         ( enable => clk_mod_s,
           accion => accion_comp
);


carr: carretera
--generic map(
  --  ROAD_LENGTH => ROAD_LENGTH_s,
    --segment => segment_s
--);
Port map( 
    clk => CLK,
    rst => RESET,
    CE => inicio_carr,
    --modo_f => en_mod_facil,
    --modo_m => en_mod_med,
    --modo_d => en_mod_dif,
    modo => en_mod,
    mover => clk_mod_s,

    -- SALIDA de 56 BITS (8 displays * 7 segmentos)
    road => inf_carr_sal_gen,
    s_toggle_out => s_toggle
);


m_road: mult_road
    Port map(
        CLK => clk,                              
        RST => RESET,
        --freq => 
        -- ENTRADA: Vector de 56 bits
        ROAD_ARRAY_IN => inf_completa,
        --code_coche  => sal_disply_coche,
        -- SALIDAS FÍSICAS
        SEGMENTS_OUT =>  inf_displays,           
        ANODES_OUT => s_mux_anodes        
    );
    
--inf_coche_d <= sal_disply_coche;
sel_displays  <= (others => '1') when (s_toggle = '1') else  s_mux_anodes;
inf_completa <=  inf_carr_sal_gen(55 downto 7) & sal_disply_coche(6 downto 0);
inf_carr_ocho_dis <= inf_carr_sal_gen(55 downto 0);
inf_a_comparar<= inf_carr_ocho_dis(6 downto 0);
cod_carr <= inf_carr_sal_gen(13 downto 7);

end Behavioral;
