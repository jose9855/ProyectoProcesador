----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Andrés Felipe Valencia Rivera 
-- 
-- Fecha:    17:33:28 04/19/2015 
-- Proyecto:	 	 Procesador SparcV8
-- Module Name:    MuxTo_nPC 
-- Description:	 multiplexor conectado al nPC, permite trabajar con instrucciones de saltos y call
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxTo_nPC is
    Port ( PCDisp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCDisp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCAddress : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           PCAddressOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MuxTo_nPC;

architecture Arq_MuxTo_nPC of MuxTo_nPC is

begin

process(PCDisp30,PCDisp22,PC4,PCAddress,PCAddress,PCSource)
begin
		case PCSource is
			when "00" => -- No implementado
				PCAddressOut <= PCAddress;
			when "01" => -- call
				PCAddressOut <= PCDisp30;
			when "10" => -- branch
				PCAddressOut <= PCDisp22;
			when "11" => -- siguiente instrucción
				PCAddressOut <= PC4;
			when others => -- siguiente instrucción
				PCAddressOut <= PC4;
		end case;
end process;

end Arq_MuxTo_nPC;
