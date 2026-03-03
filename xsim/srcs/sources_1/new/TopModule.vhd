----------------------------------------------------------------------------------
-- Company:     LIKE
-- Engineer:    Juergen Frickel
-- Create Date: 10.02.2026
-- TopModule for PrASIC
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.pkg_PrASIC.all;

entity YourGameName is
  Port (clk:          in std_logic;
        btnCpuReset:  in std_logic;
        btnU:  in std_logic;
        btnL:  in std_logic;
        btnR:  in std_logic;
        btnD:  in std_logic;
        sw:           in std_logic_vector (4 downto 0);
        Hsync, Vsync: out std_logic;
        vgaRed, vgaGreen, vgaBlue: out std_logic_vector(3 downto 0) );
end entity;

architecture BestGame of YourGameName is
   
  component clk_wiz_0
    Port (clk_out1: out std_logic;
          reset:    in  std_logic;
          clk_in1:  in  std_logic);    
  end component;

  component VGA
  Port (clk25:    in  std_logic;
        AR:       in  boolean;
        VGAin:    in  vga12;
        Freeze:   in  boolean;      
        HC:       out integer range 1 to HMax;
        VC:       out integer range 1 to VMax;
        FC:       out integer range 0 to FMax;
        FEnd:     out boolean;
        Hsync:    out std_logic;
        Vsync:    out std_logic;
        VGAout:   out vga12 );
  end component;
  
  component object is
  Port (HC:       in integer range 1 to HMax;
        VC:       in integer range 1 to VMax;
        FC:       in integer range 0 to FMax;
        RGBout:   out vga12 );
  end component;
  
  component object_2 is
  Port (
        clk25:    in  std_logic;
        FEnd:     in boolean;
        btnU:  in std_logic;
        btnL:  in std_logic;
        btnR:  in std_logic;
        btnD:  in std_logic;
        HC:       in integer range 1 to HMax;
        VC:       in integer range 1 to VMax;
        FC:       in integer range 0 to FMax;
        RGBout:   out vga12 );
end component;

  
    
  signal t_VGAin:   VGA12;
  signal t_VGAout:  VGA12;
  signal t_object :  VGA12;
  signal t_rect_vga :  VGA12;

  signal clk25:    std_logic;
  signal t_reset:  std_logic;
  signal t_HC:     integer range 1 to HMax;
  signal t_VC:     integer range 1 to VMax;
  signal t_FC:     integer range 0 to FMax;
  signal t_FEnd, t_AR, t_Freeze:  boolean;
  signal SLV_Tmp:  std_logic_vector(19 downto 0);
  
   
begin

   Clk_IP : clk_wiz_0
      port map (clk_in1  => clk,
                reset    => t_reset,
                clk_out1 => clk25);

   My_VGA : VGA
      port map (
         clk25  => clk25,
         AR     => t_AR,
         VGAin  => t_VGAin,
         Freeze => t_Freeze,
         HC     => t_HC,
         VC     => t_VC,
         FC     => t_FC,
         FEnd   => t_FEnd,
         Hsync  => HSync,
         Vsync  => VSync,
         VGAout => t_VGAout );
         
   Border_object : object
      port map (
        HC      => t_HC, 
        VC      => t_VC,
        FC      => t_FC,
        RGBout   => t_object);
        
        
   moving_object : object_2
      port map (
        btnU => btnU,
        btnL => btnL,
        btnR => btnR,
        btnD => btnD,
        clk25   => clk25,
        FEnd    => t_FEnd,
        HC      => t_HC, 
        VC      => t_VC,
        FC      => t_FC,
        RGBout   => t_rect_vga);
         
         
         
 -------------------------------------------------
   t_reset  <= not btnCpuReset;     -- high active reset for clock IP
   t_AR     <= (btnCPUReset='0');   -- async. reset (converting to boolean)
   t_Freeze <= (sw(0)='1');         -- freeze with sw-0 (converting to boolean)

   vgaRed   <=  t_VGAout (11 downto 8);
   vgaGreen <=  t_VGAout (7 downto 4);
   vgaBlue  <=  t_VGAout (3 downto 0);
-------------------------------------------------

------------  moving pattern generator - only for test + demonstration:  ------------
------------  your own game logic should be implemented in other components ---------
   SLV_Tmp <= std_logic_vector(to_unsigned((t_HC-HRes/2)*(t_HC-HRes/2) + 
               (t_VC-VRes/2)*(t_VC-VRes/2) + (t_FC-FMax/2)*(t_FC-FMax/2),20));

   t_VGAin <= t_rect_vga when sw(4)='1' else 
        SLV_tmp(17 downto 6) when sw(1)='1' else
        SLV_tmp(15 downto 4) when sw(2)='1' else
        SLV_tmp(17 downto 12) & SLV_tmp(5 downto 0) when sw(3)='1' else
        SLV_tmp(13 downto 2);
-------------------------------------------------

end architecture;