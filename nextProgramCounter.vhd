----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Jose Feiver Angarita Monsalve 
-- 
-- Fecha:			 19:49:58 04/05/2016
-- Proyecto:	 	 Procesador MonocicloSparcV8
-- Module Name:    nPC: nextProgramCounter
-- Description: 	 Guarda un dato de 32bits que indica el valor de la intruccion siguiente, inicia en 0
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nextProgramCounter is
    Port ( nPC_in : in  STD_LOGIC_VECTOR (31 downto 0);--Dato de 32bits proveniente del Sumador
           Reset : in  STD_LOGIC; --Permite reiniciar el nPC
           Clk : in  STD_LOGIC;--Señal de reloj de la FPGA
           nPC_out : out  STD_LOGIC_VECTOR (31 downto 0));--Salida corresponde a un dato de 32bits (es una dirección)
end nextProgramCounter;

architecture Arq_nextProgramCounter of nextProgramCounter is

begin
	process(Clk, nPC_in, Reset)
		begin
			if(Reset = '1')then --Si reset vale 1 pone 0 en la salida
				nPC_out <= (others=>'0');
			else
				if(rising_edge(Clk))then --Si hay un flanco de subida pone en la salida el valor del nPC_in
					nPC_out <= nPC_in;
				end if;
			end if;
	end process;

end Arq_nextProgramCounter;

