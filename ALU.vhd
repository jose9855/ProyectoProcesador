----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Andrés Felipe Valencia Rivera 
-- 
-- Fecha:    20:52:44 04/12/2015 
-- Proyecto:	 	 Procesador SparcV8
-- Module Name:    ALU Unidad Aritmetico Logica
-- Description:	 unidad que hace las operaciones matematicas y logicas.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity ALU is
    Port ( operando1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operando2 : in  STD_LOGIC_VECTOR (31 downto 0);
           aluop : in  STD_LOGIC_VECTOR (5 downto 0);
			  carry : in  STD_LOGIC;
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));  
end ALU;

architecture Arq_ALU of ALU is

begin
	process(operando1,operando2, aluop, carry)
	begin
	   case (aluOP) is 

			-- SUMAS -- 

			when "000000" => -- Add
				AluResult <= operando1 + operando2;

			when "000001" => -- Addcc
				AluResult <= operando1 + operando2;

			when "000010" => --Addx
				AluResult <= operando1 + operando2 + carry;

			when "000011" => --Addxcc
				AluResult <= operando1 + operando2 + carry;


			-- RESTAS-- 

			when "000100" => -- Sub
				AluResult <= operando1 - operando2;

			when "000101" => -- Subcc
				AluResult <= operando1 - operando2;

			when "000110" => --Subx
				AluResult <= operando1 - operando2 - carry;

			when "000111" => --Subxcc
				AluResult <= operando1 - operando2 - carry;


			-- LOAD-- 

			when "001100" => --LOAD WORD
				AluResult <= operando1 + operando2;

			-- STORE-- 
			when "010110" => --STORE WORD
				AluResult <= operando1 + operando2;
				
				
			-- LOGICAL-- 
			when "011100" => --And
				AluResult <= operando1 and operando2;	

			when "011101" => --Andcc
				AluResult <= operando1 and operando2;	
				
			when "011110" => --Andn
				AluResult <= not (operando1 and operando2);	
				
			when "011111" => --Andncc
				AluResult <= not (operando1 and operando2);	
				 
			when "100000" => -- or
				AluResult <= operando1 or operando2;
				
			when "100001" => -- Orcc
				AluResult <= operando1 or operando2;
				
			when "100010" => -- Orn
				AluResult <= not (operando1 or operando2);
				
			when "100011" => -- Orncc
				AluResult <= not (operando1 or operando2);
					
			when "100100" => -- Xor
				AluResult <= operando1 xor operando2;
				
			when "100101" => -- Xorcc
				AluResult <= operando1 xor operando2;
		
			when "100110" => -- Xnor
				AluResult <= operando1 xnor operando2;
		
			when "100111" => -- Xnorcc
				AluResult <= operando1 xnor operando2;
		
			when "101101" => -- JMPL
				AluResult <= operando1 + operando2;
		
			--when "101000" => -- SLL
				--AluResult <= operando1 sll conv_integer (operando2);
		
			when "111101" => --nop
				AluResult <= (others=>'0');

			when others =>
				AluResult <= (others=>'0');
		end case;
	end process;


end Arq_ALU;

