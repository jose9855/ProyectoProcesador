----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Andrés Felipe Valencia Rivera 
-- 
-- Fecha:    18:49:32 04/19/2015 
-- Proyecto:	 	 Procesador SparcV8
-- Module Name:    Data Memory
-- Description:	 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MuxWinManO7toRF is
    Port ( nrd : in  STD_LOGIC_VECTOR (5 downto 0);
           registroO7 : in  STD_LOGIC_VECTOR (5 downto 0);
           RFDestSel : in  STD_LOGIC;
           RFDest : out  STD_LOGIC_VECTOR (5 downto 0));
end MuxWinManO7toRF;

architecture Arq_MuxWinManO7toRF of MuxWinManO7toRF is

begin
	process(nrd,registroO7,RFDestSel)
	begin
		if(RFDestSel = '0')then
			RFDest <= nrd;
		else
			if(RFDestSel = '1')then
				RFDest <= registroO7;
			end if;
		end if;
	end process;


end Arq_MuxWinManO7toRF;

