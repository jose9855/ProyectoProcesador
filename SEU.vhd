----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Andrés Felipe Valencia Rivera 
-- 
-- Fecha:    20:26:38 04/12/2015  
-- Proyecto:	 	 Procesador SparcV8
-- Module Name:    SEU Unidad de Extensión de Signo.
-- Description: 	 Verifica si el inmediato es positivo o negativo
--						 completa con 0 los 32bits si es positivo
--					    completa con 1 los 32bits si es negativo
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SEU is
    Port ( imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           simm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU;

architecture Arq_SEU of SEU is

begin
	process(imm13)
	begin
			if(imm13(12) = '1')then
				simm32(12 downto 0) <= imm13;
				simm32(31 downto 13) <= (others=>'1');
			else
				simm32(12 downto 0) <= imm13;
				simm32(31 downto 13) <= (others=>'0');
			end if;
	end process;
end Arq_SEU;

