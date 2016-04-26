----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Jose Feiver Angarita Monsalve 
-- 
-- Fecha:   		 21:31:58 04/05/2016
-- Proyecto:	 	 Procesador SparcV8
-- Module Name:    PC: ProgramCounter
-- Description: 	 Guarda el valor de la instrucci�n que se esta ejecutando en el momento.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ProgramCounter is
    Port ( PC_in : in  STD_LOGIC_VECTOR (31 downto 0);--Dato de 32bits que indica la instrucci�n a ejecutar
           Reset : in  STD_LOGIC;--Reinicia el PC
           Clk : in  STD_LOGIC;--Se�al de reloj
           PC_out : out  STD_LOGIC_VECTOR (31 downto 0));--Dato de 32bits que indica la instrucci�n que se esta ejecutando en el momento.
end ProgramCounter;

architecture Arq_ProgramCounter of ProgramCounter is

begin
	process(Clk)
		begin
			if(rising_edge(Clk))then 
				if(Reset = '1')then --Si reset vale 1 pone en la salida "0"
					PC_out <= (others=>'0');
				else -- si hay un flanco de subida pone en la salida la instrucci�n a ejecutar.
					PC_out <= PC_in;
				end if;
			end if;
	end process;

end Arq_ProgramCounter;

