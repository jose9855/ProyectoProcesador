----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Jose Feiver Angarita Monsalve 
-- 
-- Fecha:    	    00:25:30 04/13/2016
-- Proyecto:	 	 Procesador SparcV8
-- Module Name:    Unidad de Control
-- Description: 	 Recibe el op y op3 y pone en la salida un numero binario que le indica al ALU la operación a realizar
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Unidad_Control is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
			  op2 : in  STD_LOGIC_VECTOR (2 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cond : in  STD_LOGIC_VECTOR (3 downto 0);
           icc : in  STD_LOGIC_VECTOR (3 downto 0);
			  enableMem : out STD_LOGIC;
           rfDest : out  STD_LOGIC;
           rfSource : out  STD_LOGIC_VECTOR (1 downto 0);
			  pcSource : out STD_LOGIC_VECTOR (1 downto 0);
           wrEnMem : out  STD_LOGIC; -- habilitador de escritura en data memory
           wrEnRF : out  STD_LOGIC; -- habilitador de escritura en regiter file
			  aluop : out  STD_LOGIC_VECTOR (5 downto 0));
end Unidad_Control;

architecture Arq_Unidad_Control of Unidad_Control is

begin
	process(op, op2, op3, cond, icc)
		begin
			if(op = "01")then --Call
				pcSource <= "01"; -- PC + (4 x disp30)
				wrEnRF <= '1'; -- Permito guardar el valor actual de PC
				rfSource <= "10"; -- PC
				enableMem <= '1';
				rfDest <= '1'; -- r[15]
				wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
				aluop <= "111111"; -- Un valor que no se tenga en cuenta como alguna operacion
			
			elsif(op = "00")then --Instrucciones Branches: Bicc - FBfcc - CBccc; Sethi
					if(op2 = "010")then -- Branch on Integer Condition Codes Instructions
						case cond is
							when "1000" => -- Branch Always
								pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
								wrEnRF <= '0';
								enableMem <= '1';
								rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "111111";
							when "1001" => -- Branch on Not Equal
								if(not(icc(2)) = '1') then -- not Z
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								end if;
							when "0001" => -- Branch on Equal
								if(icc(2) = '1') then --  Z
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								end if;
							when "1010" => -- Branch on Greater
								if((not(icc(2) or (icc(3) xor icc(1)))) = '1') then -- not(Z or (N xor V))
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								end if;
							
							when "0010" => -- Branch on Less or Equal
								if((icc(2) or (icc(3) xor icc(1))) = '1') then -- Z or (N xor V)
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								end if;
							when "1011" => -- Branch on Greater or Equal
								if((not(icc(3) xor icc(1))) = '1') then -- not (N xor V)
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								end if;
							when "0011" => -- Branch on Less
								if((icc(3) xor icc(1)) = '1') then -- (N xor V)
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "111111";
								end if;
							when others => -- Not Implemented
								pcSource <= "00";
								wrEnRF <= '0';
								enableMem <= '1';
								rfSource <= "00";
								rfDest <= '0'; -- r[15]
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "111111"; -- Un valor que no se tenga en cuenta como alguna operacion
						end case;
					elsif(op2 = "100")then -- NOP
							pcSource <= "11"; -- Se salta a PC + 4
							wrEnRF <= '0'; -- Se guarda en el Register File el valor de 
							rfSource <= "01"; -- Debe ser el resultado de la operacion
							rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
							wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
							aluop <= "111101";
							enableMem <= '1';
					end if;
				elsif(op = "10")then				
						case op3 is
							when "000000" => -- ADD
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- 
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "000000";
								enableMem <= '1';
							when "010000" => -- ADDCC
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "000001";
								enableMem <= '1';
							when "001000" => -- Addx
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "000010";
								enableMem <= '1';
							when "011000" => -- Addxcc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "000011";
								enableMem <= '1';
								
							when "000100" => -- SUB
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- 
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "000100";
								enableMem <= '1';
							when "010100" => -- SUBCC
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- 
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "000101";
								enableMem <= '1';
							when "001100" => -- Subx
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "000110";
								enableMem <= '1';
							when "011100" => -- Subxcc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "000111";
								enableMem <= '1';

							when "000001" => -- And
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "011100";
								enableMem <= '1';
							when "010001" => -- Andcc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "011101";
								enableMem <= '1';
							when "000101" => -- Andn
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "011110";
								enableMem <= '1';
							when "010101" => -- Andncc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "011111";
								enableMem <= '1';
								
							when "000010" => -- OR
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "100000";
								enableMem <= '1';
							when "010010" => -- Orcc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "100001";
								enableMem <= '1';
							when "000110" => -- Orn
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "100010";
								enableMem <= '1';
							when "010110" => -- Orncc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "100011";
								enableMem <= '1';
							
							when "000011" => -- Xor
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "100100";
								enableMem <= '1';
							when "010011" => -- Xorcc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "100101";
								enableMem <= '1';
							when "000111" => -- Xnor
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "100110";
								enableMem <= '1';
							when "010111" => -- Xnorcc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "100111";
								enableMem <= '1';
								
							when "100101" => -- Shift left logical
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "101000";
								enableMem <= '1';
							when "100110" => -- Shift rigth logical
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "101001";
								enableMem <= '1';	
								
							when "111100" => -- Save
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "101011";
								enableMem <= '1';	
								
							when "111101" => -- Restore
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "101100";
								enableMem <= '1';	
								
							when "111000" => -- JMPL
								pcSource <= "00"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '1'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "101101";
								enableMem <= '1';	
								
							when others => -- Implementar demas instrucciones
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '0'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								aluop <= "000000";
								enableMem <= '1';
						end case;
						
					else
						if(op = "11")then --Instrucciones de memoria (Load, Store)
							case op3 is 
							
								when "000000" => -- Load Word
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '1'; -- Si se guarda en el Register File
									rfSource <= "00"; -- Se debe guardar lo que se carga de la Memoria de Datos
									rfDest <= '0'; -- Se debe permitir que el valor cargado desde la Memoria de datos se guarde en el RF donde diga rd
									wrEnMem <= '0'; -- El dato no es escrito en Memoria de Datos
									aluop <= "001100";
									enableMem <= '1';
									
								when "000100" => -- Store Word
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0'; -- No Se guarda en el Register File
									rfSource <= "01"; -- No importa porque no se va a guardar en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '1'; -- El dato es escrito en Memoria de Datos
									aluop <= "010110";
									enableMem <= '1';
								
								when others => -- Implementar demas instrucciones
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0'; -- Se guarda en el Register File el valor de la Operacion
									rfSource <= "01"; -- Debe ser el resultado de la operacion
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									aluop <= "000000";
									enableMem <= '1';
							end case;
						end if;
					end if;
	end process;

end Arq_Unidad_Control;

