----------------------------------------------------------------------------------
-- Universidad Tecnologica de Pereira 
-- Estudiante: Jose Feiver Angarita Monsalve 
-- 
-- Fecha:    	    22:10:35 04/17/2016
-- Proyecto:	 	 Procesador SparcV8
-- Module Name:    Register File
-- Description: 	 Pone en la salida el contenido del registro fuente 1 y 2 en 32bits
--						 igualmente, guarda el resultado de la ALU en el registro destino.
--						 funciona como una memoria ram 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RegisterFile is
    Port ( nrs1 : in  STD_LOGIC_VECTOR (5 downto 0); --nuevo registro fuente1
           nrs2 : in  STD_LOGIC_VECTOR (5 downto 0); --nuevo registro fuente2
           nrd : in  STD_LOGIC_VECTOR (5 downto 0); --nuevo registro destino
			  Reset : in  STD_LOGIC;--Reinicia el register file
           DataToWrite : in  STD_LOGIC_VECTOR (31 downto 0); -- dato a escribir
			  WriteEnable : in  STD_LOGIC; -- habilitador de escritura
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0); --crs: contenido registro fuente
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  crd : out  STD_LOGIC_VECTOR (31 downto 0)); -- contenido registro de destino
end RegisterFile;

architecture Arq_RegisterFile of RegisterFile is

	type tipo_ram is array (0 to 39) of std_logic_vector (31 downto 0); -- defino un vector de 0 a 39 cada uno de 32 bits
	signal registros : tipo_ram :=(others => x"00000000"); --defino una señal denominada registros con el vector inicializado en 32 ceros

begin

	process(Reset,nrs1,nrs2,nrd,DataToWrite)
	begin
			if(Reset = '1')then -- si reset se activa pongo todo en 0
				crs1 <= (others=>'0');
				crs2 <= (others=>'0');
				crd <= (others=>'0');
				registros <= (others => x"00000000");
			else
				crs1 <= registros(conv_integer(nrs1));
				crs2 <= registros(conv_integer(nrs2));
				crd <= registros(conv_integer(nrd));
			end if;
			
			if(WriteEnable = '1' and nrd /= "000000")then -- si el habilitador de escritura esta activo y el registro de destino es diferente del registro "g0" entonces
				registros(conv_integer(nrd)) <= DataToWrite; --Guardo el resultado de la ALU en el registro destino
			end if;
			
	end process;

end Arq_RegisterFile;

