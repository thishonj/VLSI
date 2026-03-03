----------------------------------------------------------------------------------
-- Company:     LIKE
-- Engineer:    Juergen Frickel
-- Create Date: 10.02.2026
-- TopModule for PrASIC
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_PrASIC.all;

entity VGA is
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
end entity VGA;


architecture MySolution of VGA is


signal h_counter : integer range 1 to  HMax;
signal v_counter : integer range 1 to  VMax;
signal f_counter : integer range 0 to  FMax;

begin
 process(clk25, AR)
  begin 
  if AR then
    h_counter <= 1;
    v_counter <= 1;
    f_counter <= 0;

  elsif rising_edge(clk25) then
    if h_counter < HMax then
       h_counter <= h_counter +1;
    else 
       h_counter <= 1;      
       if v_counter < VMax then
          v_counter <= v_counter +1;
       else 
          v_counter <= 1;   
          if not Freeze then
             if f_counter < FMax then
                f_counter <= f_counter +1;     
             else
                f_counter  <= 0;
             end if;
          end if;
       end if;
   end if;
   end if;
 end process;
  
VC <= v_counter;
HC <= h_counter;
FC <= f_counter;

Hsync <= '0' when (h_counter >= HS1 and h_counter <= HS2) else '1';
Vsync <= '0' when (v_counter >=  VS1 and v_counter <= VS2) else '1';

FEnd <= true when (h_counter = HMax and v_counter = VMax and not Freeze) else false;

process(VGAin, h_counter, v_counter)
begin
if (h_counter > HRes) or (v_counter > VRes) then 
    VGAout <= blank;
else 
    VGAout <= VGAin;
end if;
end process;



end MySolution;
