----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Jose Feiver Angarita Monsalve 
-- 
-- Fecha:    	    09:35:00 04/07/2016 
-- Proyecto:	 	 Procesador SparcV8
-- Module Name:    Sumador - Ar_Sumador 
-- Description: 	 Suma 1 al valor que sale del nPC

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sumador is
    Port ( operando1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operando2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Resultado : out  STD_LOGIC_VECTOR (31 downto 0));
end Sumador;

architecture Arq_Sumador of Sumador is

begin
	process (operando1, operando2)
		begin
		Resultado <= operando1 + operando2; 
		--Suma el dato del operando 1 con el dato del operando2
		--(operando1: es un numero binario de 32bits (es un 1)
		--(operando2: es un numero binario de 32bits procedente del nPC)
	end process;

end Arq_Sumador;