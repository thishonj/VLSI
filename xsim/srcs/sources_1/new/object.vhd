----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2026 12:30:45 PM
-- Design Name: 
-- Module Name: object - Behavioral
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
use work.pkg_PrASIC.all;

entity object is
Port (
        HC:       in integer range 1 to HMax;
        VC:       in integer range 1 to VMax;
        FC:       in integer range 0 to FMax;
        RGBout:   out vga12 );
end entity object;


architecture Behavioral of object is

begin

process(HC, VC)
begin
    if (HC <=border_thickness ) or (HC > HRes - border_thickness) or
        (VC <=border_thickness) or (VC > VRes - border_thickness) then
         RGBout <= green;
     else 
        RGBout <= blue;
        end if;
end process;


end Behavioral;
