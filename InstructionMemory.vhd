----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Jose Feiver Angarita Monsalve 
-- 
-- Fecha:    	    23:03:42 04/10/2016
-- Proyecto:	 	 Procesador SparcV8
-- Module Name:    IM: Instruction Memory (Memoria de Instrucciones)
-- Description: 	 Selecciona una a una las instrucciones a ejecutar por el procesador
--						 dichas instrucciones estan establecidas en un archivo .txt o data. definido por el usuario
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;

entity InstructionMemory is
    Port ( IM_in : in  STD_LOGIC_VECTOR (31 downto 0);
			  Reset : in  STD_LOGIC;--Reinicia el IM
           IM_out : out  STD_LOGIC_VECTOR (31 downto 0));
end InstructionMemory;

architecture Arq_InstructionMemory of InstructionMemory is
	type rom_type is array (0 to 32) of std_logic_vector (31 downto 0);
	-- rom_type: variable guarda un array, el array debe ser del tamaño del archivo .txt o .data
	-- 			 el archivo siempre debe tener una logico de 32 o 64 ... (2^n)
		
	impure function InitRomFromFile (RomFileName : in string) return rom_type is 
		--InitRomFromFile: es una función que recibe como parametro una variable RomFileName (es el nombre del archivo .txt o .data)y retorna el array rom_type
		FILE RomFile : text open read_mode is RomFileName;--abre el archivo txt o data
		variable RomFileLine : line;
		variable temp_bv : bit_vector(31 downto 0);
		variable temp_mem : rom_type;
		begin
			for i in rom_type'range loop
				readline (RomFile, RomFileLine);
				read(RomFileLine, temp_bv);
				temp_mem(i) := to_stdlogicvector(temp_bv);
			end loop;
		return temp_mem;
	end function;
	
	signal instructions : rom_type := InitRomFromFile("programMul.data");-- Multiplica 8 * 7 = 56 Se llama a la función indicando el nombre del archivo .txt o .data
	
begin
	--reset,address, instructions)
	process(Reset,IM_in, instructions)--clk)
	begin
		--if(rising_edge(clk))then
			if(Reset = '1')then --Si reset vale 1 pone en 0 la salida
				IM_out <= (others=>'0');
			else -- Toma la instrucción que se encuentre en el archivo segun linea indicada por IM_in y la pone en la salida
				IM_out <= instructions(conv_integer(IM_in(5 downto 0)));
			end if;
		--end if;
	end process;

end Arq_InstructionMemory;

