----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Jose Feiver Angarita Monsalve 
-- 
-- Fecha:    	    22:50:10 04/17/2016
-- Proyecto:	 	 Procesador SparcV8
-- Module Name:    Multiplexor de Register File - SEU a ALU
-- Description:	 pone en la salida el valor del register file o del SEU dependiendo del valor de "i"
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_RFSEUtoALU is
    Port ( crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           simm32 : in  STD_LOGIC_VECTOR (31 downto 0);
           i : in  STD_LOGIC; --valor que indica cual de los dos valores de entrada se encoge 
			  -- si vale 0 se escoge crs2
			  -- si vale 1 se escoge simm32
           OperandoALU : out  STD_LOGIC_VECTOR (31 downto 0));
end mux_RFSEUtoALU;

architecture Arq_mux_RFSEUtoALU of mux_RFSEUtoALU is

begin
	process(crs2,simm32,i)
	begin
		if(i = '1')then
			OperandoALU <= simm32;
		else
			if(i = '0')then
				OperandoALU <= crs2;
			end if;
		end if;
	end process;

end Arq_mux_RFSEUtoALU;

