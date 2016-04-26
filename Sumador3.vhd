----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:42:33 04/21/2015 
-- Design Name: 
-- Module Name:    Sumador3 - arq_Sumador3 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sumador3 is
    Port ( operando1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operando2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Resultado : out  STD_LOGIC_VECTOR (31 downto 0));
end Sumador3;

architecture arq_Sumador3 of Sumador3 is

begin
	process (operando1, operando2)
		begin
		Resultado <= operando1 + operando2; 
		--Suma el dato del operando 1 con el dato del operando2
		--(operando1: es un numero binario de 32bits (es un 1)
		--(operando2: es un numero binario de 32bits procedente del nPC)
	end process;

end arq_Sumador3;

