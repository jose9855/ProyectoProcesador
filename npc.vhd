----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:49:58 04/05/2016 
-- Design Name: 
-- Module Name:    npc - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity npc is
    Port ( dato : in  STD_LOGIC_VECTOR (0 downto 31);
           reset : in  STD_LOGIC_VECTOR (0 downto 1);
           clk : in  STD_LOGIC_VECTOR (0 downto 1);
           salida : out  STD_LOGIC_VECTOR (0 downto 31));
end npc;

architecture Behavioral of npc is

begin


end Behavioral;

