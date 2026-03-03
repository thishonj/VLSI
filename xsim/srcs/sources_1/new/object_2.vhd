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

entity object_2 is
Port (  btnU:  in std_logic;
        btnL:  in std_logic;
        btnR:  in std_logic;
        btnD:  in std_logic;
        clk25:    in  std_logic;
        FEnd:     in boolean;
        HC:       in integer range 1 to HMax;
        VC:       in integer range 1 to VMax;
        FC:       in integer range 0 to FMax;
        RGBout:   out vga12 );
end entity object_2;


architecture Behavioral of object_2 is


    -- Signals of the center of thr circle
    signal hk : integer := 200;
    signal vk : integer := 200;
    
    -- States for the rectangular path
    type path_state is (GoRight, GoDown, GoLeft, GoUp);
    -- signal current_direction : path_state := GoRight;
    
    -- Movement speed
    constant SPEED : integer := 3; -- pixels per frame
begin

    -- Position Calculation
    process(clk25)
    begin
        if rising_edge(clk25) then
            if FEnd then -- End of the frame
               if btnU = '1' then
                if vk > top_left_boundary then
                    vk <= vk - SPEED; -- moving up
                    end if;
                elsif btnD = '1' then
                    if vk < bottom_right_boundary then
                        vk <= vk + SPEED; -- moving down
                     end if;
                 end if;
                 
                 if btnL = '1' then
                   if hk > top_left_boundary then
                    hk <= hk - SPEED; -- moving left
                    end if;
                elsif btnR = '1' then
                    if hk < bottom_right_boundary then
                        hk <= hk + SPEED; -- moving right
                     end if;
                end if;      
             end if;
        end if;
    end process;

  --  Draw the rechtangle
    process(HC, VC, hk, vk)
    begin   
        if (HC >= hk) and (HC < hk + recktangle_size) and 
           (VC >= vk) and (VC < vk + recktangle_size) then
            RGBout <= red;     
        
        elsif (HC <= border_thickness) or (HC > HRes - border_thickness) or (VC <= border_thickness) or (VC > VRes - border_thickness) then
            RGBout <= green;   
           
        else
            RGBout <= blue;   
        end if;
    end process;

end Behavioral;








