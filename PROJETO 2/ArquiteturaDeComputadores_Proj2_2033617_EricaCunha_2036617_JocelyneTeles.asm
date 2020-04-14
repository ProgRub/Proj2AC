;Arquitetura de Computadores 
;Projeto 2 
;Alunas:
;Érica Filipa Dias Cunha nº 2033617
;Jocelyne Estefanía Pestana  nº 2036617

;Periféricos
ON_OFF						EQU		1A0H			;botão on/off 
SEL_NR_MENU					EQU		1B0H			;botão de seleção
OK  						EQU		1C0H			;botão ok
CHANGE						EQU     1D0H			;botão change
PESO						EQU		1E0H			;botão para inserir o peso do alimento que queremos

;Posição do Display  
Display_inic				EQU 	200H			;Inicio do display principal
Display_end					EQU		26FH			;fim do display principal

;Posições onde o alimento vai ser escrito no menu principal da balança
Linha_inic					EQU 	0220H			;Inicio da linha onde começa o alimento a ser escrito
Linha_end					EQU 	022FH			;Fim da linha onde acaba onde o alimento foi escrito

;Constantes do programa e opções
caraterVazio				EQU		20H				;Carater para limpar o ecrã

MBalanca					EQU		1				;Opção para a escolha do Menu balança
MTotal						EQU		2				;Opção para a escolha do Menu Total
MReset						EQU		3				;Opção para a escolha do Menu Reset

Base_Tabela					EQU 	6000H			;Incio da tabela que contêm os alimentos

;Posição onde vai ser escrito no menu principal da balança o peso
LocalizacaoPesoDisplay		EQU		0248H			;Endereço base do display onde ficará localizado o peso

;Posição onde vai ser escrito no menu total as proteínas
LocalizacaoPDisplay 		EQU     0228H 			;Endereço base do display onde ficará localizado o peso

;Endereços na memória principal onde serão guardados os macronutrientes e calorias
LocalizacaoMemoriaP			EQU		02A0H			;Endereço da memória principal onde irá ficar guardado o valor das proteínas totais
LocalizacaoMemoriaC			EQU		02B0H			;Endereço da memória principal onde irá ficar guardado o valor dos hidratos de carbono totais
LocalizacaoMemoriaF			EQU		02C0H			;Endereço da memória principal onde irá ficar guardado o valor das gorduras totais 
LocalizacaoMemoriaCal		EQU		02D0H 			;Endereço da memória principal onde irá ficar guardado o valor das calorias totais 

;Endereços na memória secundária onde serão guardados os macronutrientes e calorias
LocalizacaoMemoriaPA 		EQU 	02F0H			;Endereço da memória secundária onde irá ficar guardado o valor das proteínas totais
LocalizacaoMemoriaCA		EQU 	0300H			;Endereço da memória secundária onde irá ficar guardado o valor dos hidratos de carbono totais
LocalizacaoMemoriaFA		EQU 	0310H			;Endereço da memória secundária onde irá ficar guardado o valor das gorduras totais 
LocalizacaoMemoriaCalA		EQU     0320H			;Endereço da memória secundária onde irá ficar guardado o valor das calorias totais 

NR_TOT_CAR 					EQU     4				;Número total de carateres para a converção de hexadecimal para decimal			

StackPointer				EQU		7000H			;Endereço da pilha

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;																	Listagem dos menus 
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;****************************************************************************
;Menu Principal
;****************************************************************************
Place 2000H
MenuPrincipal:								;Display do menu principal
	String " MENU PRINCIPAL "				;linha 1 do display do menu principal
	String "                "				;linha 2 do display do menu principal
	String "  1- Balança    "				;linha 3 do display do menu principal
	String "  2- Total      "				;linha 4 do display do menu principal
	String "  3- Reset      "				;linha 5 do display do menu principal
	String "                "				;linha 6 do display do menu principal
	String "                "				;linha 7 do display do menu principal

;****************************************************************************
;Menu Principal da Balança
;****************************************************************************
Place 2080H												
MenuBalancaPrincipal:						;Display do menu principal da balança
	String "  MENU BALANÇA  "				;linha 1 do display do menu principal da balança
	String "Alimento:       "				;linha 2 do display do menu principal da balança
	String "                "				;linha 3 do display do menu principal da balança
	String "Peso:           "				;linha 4 do display do menu principal da balança
	String "              g "				;linha 5 do display do menu principal da balança
	String "1) Registar     "				;linha 6 do display do menu principal da balança
	String "OK para voltar  "				;linha 7 do display do menu principal da balança

;****************************************************************************
;Menus da seleção de alimento para a balança 1, 2, 3, 4 e 5
;****************************************************************************
Place 2100H												
MenuBalanca1:								;Display do menu balança 1
	String " MENU BALANÇA   "				;linha 1 do display do menu balança 1
	String "1 - Aveia       "				;linha 2 do display do menu balança 1
	String "2 - Pão de Forma"				;linha 3 do display do menu balança 1
	String "3 - Batata      "				;linha 4 do display do menu balança 1
	String "4 - Arroz       "				;linha 5 do display do menu balança 1
	String "5 - Feijão      "				;linha 6 do display do menu balança 1
	String ">>>> Change>>>> "				;linha 7 do display do menu balança 1

Place 2180H												
MenuBalanca2:								;Display do menu balança 2
	String "6 - Legumes     "				;linha 1 do display do menu balança 2
	String "7 - Tomate      "				;linha 2 do display do menu balança 2
	String "8 - Banana      "				;linha 3 do display do menu balança 2
	String "9 - Laranja     "				;linha 4 do display do menu balança 2
	String "10- Maçã        "				;linha 5 do display do menu balança 2
	String "11- Kiwi        "				;linha 6 do display do menu balança 2
	String ">>>> Change>>>> "				;linha 7 do display do menu balança 2	

Place 2200H												
MenuBalanca3:								;Display do menu balança 3
	String "12- Bolacha Choc"				;linha 1 do display do menu balança 3
	String "13- Pizza Q&F PD"				;linha 2 do display do menu balança 3
	String "14- Amêndoas    "				;linha 3 do display do menu balança 3
	String "15- Linhaça     "				;linha 4 do display do menu balança 3
	String "16- Azeite      "				;linha 5 do display do menu balança 3
	String "17- Leite Magro "				;linha 6 do display do menu balança 3
	String ">>>> Change>>>> "				;linha 7 do display do menu balança 3	

Place 2280H												
MenuBalanca4:								;Display do menu balança 4
	String "18- Whey        "				;linha 1 do Display do menu balança 4
	String "19- Salmão      "				;linha 2 do Display do menu balança 4
	String "20- Pescada     "				;linha 3 do Display do menu balança 4
	String "21- Atum        "				;linha 4 do Display do menu balança 4
	String "22- Porco       "				;linha 5 do Display do menu balança 4
	String "23-Frango(peito)"				;linha 6 do Display do menu balança 4
	String ">>>> Change>>>> "				;linha 7 do Display do menu balança 4	

Place 2300H												
MenuBalanca5:								;Display do menu balança 5
	String "24- Peru (peito)"				;linha 1 do display do menu balança 5
	String "25- Ovo         "				;linha 2 do display do menu balança 5
	String "26- Queijo      "				;linha 3 do display do menu balança 5
	String ">>>> Change>>>> "				;linha 4 do display do menu balança 5
	String "                "				;linha 5 do display do menu balança 5
	String " OK para voltar "				;linha 6 do display do menu balança 5
	String " menu principal "				;linha 7 do display do menu balança 5	

;****************************************************************************
;Menu Opção Errada 
;****************************************************************************	
Place 2380H
MenuErro:							        ;Display do menu erro
	String "     ATENÇÃO    "				;linha 1 do display do menu erro
	String "                "				;linha 2 do display do menu erro
	String "     OPÇÃO      "				;linha 3 do display do menu erro
	String "     ERRADA     "				;linha 4 do display do menu erro
	String "                "				;linha 5 do display do menu erro
	String " OK para voltar "				;linha 6 do display do menu erro
    String "                "				;linha 7 do display do menu erro

;****************************************************************************
;Menu Total - Macronutrientes
;****************************************************************************	
Place 2400H
MenuTotal:							        ;Display do menu total de macronutrientes
	String "   MENU TOTAL   "				;linha 1 do display do menu total de macronutrientes
	String "                "				;linha 2 do display do menu total de macronutrientes
	String " P:           g "				;linha 3 do display do menu total de macronutrientes
	String " C:           g "				;linha 4 do display do menu total de macronutrientes
	String " F:           g "				;linha 5 do display do menu total de macronutrientes
	String " Cal:         K "				;linha 6 do display do menu total de macronutrientes
    String " OK para voltar "				;linha 7 do display do menu total de macronutrientes

;****************************************************************************
;Menu Reset
;****************************************************************************	
Place 2480H
MenuReset:							        ;Display do menu reset
	String "   MENU RESET   "				;linha 1 do display do menu reset
	String "                "				;linha 2 do display do menu reset
	String " 1) Confirmar   "				;linha 3 do display do menu reset
	String "                "				;linha 4 do display do menu reset
	String "                "				;linha 5 do display do menu reset
	String "OK para cancelar"				;linha 6 do display do menu reset
    String "    e voltar    "				;linha 7 do display do menu reset

;****************************************************************************
;Menu Erro Overflow 
;****************************************************************************	 
Place 2500H
MenuErroOverflow:							;Display do menu erro de overflow
	String "     ATENÇÃO    "				;linha 1 do display do menu erro
	String "                "				;linha 2 do display do menu erro
	String " Ocorre overflow"				;linha 3 do display do menu erro
	String "                "				;linha 4 do display do menu erro
	String "                "				;linha 5 do display do menu erro
	String "                "				;linha 6 do display do menu erro
    String " OK para voltar "				;linha 7 do display do menu erro

;****************************************************************************
;Menu Reset após a confirmação do RESET 
;****************************************************************************
Place 2580H
MenuResetConfirmado:						;Display do menu reset
	String "   MENU RESET   "				;linha 1 do display do menu reset
	String "                "				;linha 2 do display do menu reset
	String "  Limpeza total "				;linha 3 do display do menu reset
	String "  com  sucesso! "				;linha 4 do display do menu reset
	String "                "				;linha 5 do display do menu reset
	String " OK para voltar "				;linha 6 do display do menu reset
    String " menu principal "				;linha 7 do display do menu reset

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;																	Programas Principais 
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;****************************************************************************
;Programa Principal
;****************************************************************************

Place 0000H
Incio:										;Inicio do Programa
	MOV R0, ProgramaPrincipal				;Coloca em R0 o endereço da tag ProgramaPrincipal
	JMP R0									;Salta para tag ProgramaPrincipal

Place 3000H									;Início onde o código ficará guardado na memória 

ProgramaPrincipal:
	MOV SP, StackPointer					;Colocar o endereço da pilha na SP
	CALL LimpaDisplay						;Chamada a função limpa display, que faz limpeza do display
	CALL LimpaPerifericos					;Chamada a função limpa periféricos para limpar os periféricos de entrada 
	
Liga:
	MOV R0, ON_OFF							;Coloca no resgisto R0 o valor atual do botão ON/OFF
	MOVB R1, [R0]							;Passamos o valor guardado no byte de R0 e guardamos no resgisto R1
	CMP R1, 1								;Verifica se o botão está ligado 
	JNE Liga								;Se continuar a zero, então volta a verificar o estado atual até ser ligado a balança
	
Ligado: 
	MOV R2, MenuPrincipal					;Coloca em R2 o endereço do "MenuPrincipal"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuPrincipal"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada 

Le_Opcao:
	CALL RDesliga							;Chamada a rotina "RDesliga" , a qualquer a balança pode ser desligada 
	MOV R0, SEL_NR_MENU						;Coloca no registo R0 o endereço do periférico de entrada "SEL_NR_MENU"
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "SEL_NR_MENU"
	CMP R1, 0								;Compara o valor do registo R1 com constante zero 
	JEQ Le_Opcao							;Caso sejam iguais continua o lendo a opção que está a ser colocada no perifério "SEL_NR_MENU"
	CMP R1, MBalanca						;Compara o valor do resgisto R1 com o valor da constante "MBalanca"
	JEQ MeBalanca 							;Caso ambos os valores sejam iguais então salta para o endereço "MeBalanca", assim podendo escolher um alimento
	CMP R1, MTotal							;Compara o valor do resgisto R1 com o valor da constante "MTotal"
	JEQ MeTotal 							;Caso ambos os valores sejam iguais então salta para o endereço "MeTotal", assim podendo visualizar os total de macronutrientes e calorias
	CMP R1, MReset							;Compara o valor do resgisto R1 com o valor da constante "MReset"
	JEQ MeReset								;Caso ambos os valores sejam iguais então salta para o endereço "MeReset", assim podendo dar reset ao total de macronutrientes e calorias ou cancelar
                                            ;Caso nenhumas das opções acima tenha sido escolhida então aparece uma mensagem de erro
	MOV R2, MenuErro						;Coloca em R2 o endereço do "MenuErro"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuErro"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada 
	CALL RErro								;Chamada a rotina "RErro" para validar o OK (periférico "OK") do "MenuErro"

;****************************************************************************
;Menu Total
;****************************************************************************
MeTotal:
	MOV R2, MenuTotal						;Coloca em R2 o endereço do "MenuTotal"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuTotal"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada 
	MOV R0, OK								;Coloca no registo R0 o endereço do periférico de entrada "OK"
Ciclo_menutotal:
	CALL RDesliga							;Chamada a rotina "RDesliga" , a qualquer a balança pode ser desligada 
	CALL Converte_to_CHAR_M					;Chamada a rotina "Converte_to_CHAR" para converter o valor dos macronutrientes em hexadecimal em char
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "OK"
	CMP R1 , 1								;Compara o valor do registo R1 com constante 1
	JNE Ciclo_menutotal						;Caso sejam diferentes, salta para a tag "Ciclo_menutotal"
	JMP Ligado								;Caso sejam iguais então salta para tag "Ligado", siginifica que o utilizador colocou "OK" a 1, após
											;ter visualizado os totais de macronutrientes e calorias regressou para o menu principal
;****************************************************************************
;Menu Reset
;****************************************************************************
MeReset:
	MOV R2, MenuReset						;Coloca em R2 o endereço do "MenuReset"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuReset"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada 
	MOV R3,SEL_NR_MENU             		    ;Coloca no registo R3 o endereço do periférico de entrada "SEL_NR_MENU"
	MOV R0, OK								;Coloca no registo R0 o endereço do periférico de entrada "OK"
	
Ciclo_menureset:
	CALL RDesliga							;Chamada a rotina "RDesliga" , a qualquer a balança pode ser desligada 	
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "OK"
	MOVB R4, [R3]							;Coloca no registo R4 o contéudo do endereço do periférico de entrada "SEL_NR_MENU"
	CMP R4 ,1								;Compara o valor do registo R4 com constante 1
	JEQ  Reset_memoria						;Caso ambos os valores sejam iguais então salta para a tag "Reset_memoria"
	CMP R1, 1								;Compara o valor do registo R1 com constante 1
	JNE Ciclo_menureset						;Caso sejam diferentes, salta para a tag "Ciclo_menureset"
	JMP Ligado								;Caso ambos os valores sejam iguais, salta para tag "Ligado", o que significa que cancelou o reset
											;ao total do macronutrientes e calorias
											
Reset_memoria:								
	MOV R2, MenuResetConfirmado				;Coloca em R2 o endereço do "MenuResetConfirmado"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuResetConfirmado"
	CALL LimpaMacronutrientes				;Chamada a rotina "LimpaMacronutrientes" para limpar os totais de P, C ,F e Cal  
	CALL LimpaMemoriaSecundaria				;Chamada a rotina "LimpaMemoriaSecundaria" para limpar valores  de P, C ,F e Cal na memória secundária, significando que havendo overflow, os valores não somados ao total dos macronutrientes e calorias	
	JMP Verificacao							;Salta para tag "Verificacao", que verifica o "OK" para voltar ao menu principal

;****************************************************************************
;Menu Balança
;****************************************************************************		
MeBalanca:
	MOV R2, MenuBalanca1  					;Coloca em R2 o endereço do "MenuBalanca1"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuBalanca1"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada
	MOV R0, CHANGE							;Coloca no registo R0 o endereço do periférico de entrada "CHANGE"
	
Ciclo_menubalanca:	
	CALL RDesliga							;Chamada a rotina "RDesliga" , a qualquer a balança pode ser desligada 	
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "CHANGE"
	CMP R1, 1								;Compara o registo R1 com a constante 1
	JEQ Mudar1								;Caso ambos os valores sejam iguais então para o tag "Mudar1", que sigifica que o botão "CHANGE" é 1, assim mudando para o menu "MenuBalanca2"	
											;Caso sejam diferente então irá para rotina "Verifica_selecao" para ver se algum dos alimentos foi selecionado
	CALL Verifica_selecao					;Chamada a rotina "Verifica_selecao", verificando se algum alimento foi selecionado
	JMP Ciclo_menubalanca					;Caso contrário, permace no ciclo saltando para a tag "Ciclo_menubalanca"
	
Mudar1:
	MOV R2, MenuBalanca2  					;Coloca em R2 o endereço do "MenuBalanca2"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuBalanca2"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada
	MOV R0, CHANGE							;Coloca no registo R0 o endereço do periférico de entrada "CHANGE"
	
Ciclo_menubalanca1:	
	CALL RDesliga							;Chamada a rotina "RDesliga" , a qualquer a balança pode ser desligada 	
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "CHANGE"
	CMP R1, 1								;Compara o registo R1 com a constante 1
	JEQ Mudar2								;Caso ambos os valores sejam iguais então para o tag "Mudar2", que sigifica que o botão "CHANGE" é 1, assim mudando para o menu "MenuBalanca2"	
											;Caso sejam diferente então irá para rotina "Verifica_selecao" para ver se algum dos alimentos foi selecionado
	CALL Verifica_selecao					;Chamada a rotina "Verifica_selecao", verificando se algum alimento foi selecionado
	JMP Ciclo_menubalanca1					;Caso contrário, permace no ciclo saltando para a tag "Ciclo_menubalanca1"
	
Mudar2:
	MOV R2, MenuBalanca3  					;Coloca em R2 o endereço do "MenuBalanca3"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuBalanca3"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada 
	MOV R0, CHANGE							;Coloca no registo R0 o endereço do periférico de entrada "CHANGE"
	
Ciclo_menubalanca2:	
	CALL RDesliga							;Chamada a rotina "RDesliga" , a qualquer a balança pode ser desligada 	
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "CHANGE"
	CMP R1, 1								;Compara o registo R1 com a constante 1
	JEQ Mudar3								;Caso ambos os valores sejam iguais então para o tag "Mudar3", que sigifica que o botão "CHANGE" é 1, assim mudando para o menu "MenuBalanca2"	
											;Caso sejam diferente então irá para rotina "Verifica_selecao" para ver se algum dos alimentos foi selecionado
	CALL Verifica_selecao					;Chamada a rotina "Verifica_selecao", verificando se algum alimento foi selecionado
	JMP Ciclo_menubalanca2					;Caso contrário, permace no ciclo saltando para a tag "Ciclo_menubalanca2"
	
Mudar3:
	MOV R2, MenuBalanca4  					;Coloca em R2 o endereço do "MenuBalanca4"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuBalanca4"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada 
	MOV R0, CHANGE							;Coloca no registo R0 o endereço do periférico de entrada "CHANGE"
	
Ciclo_menubalanca3:
	CALL RDesliga							;Chamada a rotina "RDesliga" , a qualquer a balança pode ser desligada 	
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "CHANGE"
	CMP R1, 1								;Compara o registo R1 com a constante 1
	JEQ Mudar4								;Caso ambos os valores sejam iguais então para o tag "Mudar4", que sigifica que o botão "CHANGE" é 1, assim mudando para o menu "MenuBalanca2"	
											;Caso sejam diferente então irá para rotina "Verifica_selecao" para ver se algum dos alimentos foi selecionado
	CALL Verifica_selecao					;Chamada a rotina "Verifica_selecao", verificando se algum alimento foi selecionado
	JMP Ciclo_menubalanca3					;Caso contrário, permace no ciclo saltando para a tag "Ciclo_menubalanca3"
	
Mudar4:
	MOV R2, MenuBalanca5  					;Coloca em R2 o endereço do "MenuBalanca5"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuBalanca5"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada 
	MOV R0, CHANGE							;Coloca no registo R0 o endereço do periférico de entrada "CHANGE"
	
Ciclo_menubalanca4:	
	CALL RDesliga							;Chamada a rotina "RDesliga" , a qualquer a balança pode ser desligada 	
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "CHANGE"
	CMP R1, 1								;Compara o registo R1 com a constante 1
	JEQ MeBalanca							;Caso ambos os valores sejam iguais então para o tag "MeBalanca, que sigifica que o botão "CHANGE" é 1, assim voltando para o inicio, mudando para o menu "MeBalanca"	
											;Caso sejam diferente então irá para rotina "Verifica_selecao" para ver se algum dos alimentos foi selecionado

	CALL Verifica_selecao					;Chamada a rotina "Verifica_selecao", verificando se algum alimento foi selecionado
	MOV R3, OK								;Coloca no registo R3 o endereço do periférico de entrada "OK"
	MOVB R3,[R3]							;Coloca no registo R3 o contéudo do endereço do periférico de entrada "OK"
	CMP R3, 1								;Compara o registo R3 com a constante 1
	JNE Ciclo_menubalanca4					;Caso os valores não sejam iguais permace no ciclo saltando para a tag "Ciclo_menubalanca4"
	JMP  Ligado								;Caso os valores sejam iguais então salta para tag "Ligado" , sigifica que o "OK" está ativo então volta para o menu principal do programa

;****************************************************************************
;Menu Balança Principal
;****************************************************************************

MeBalancaPrincipal:
	CALL Validacao							;Chamada a rotina "Validacao" , porque após selecionar o alimento é necessário validar com "OK" para passar ao "MenuBalancaPrincipal"
	MOV R2, MenuBalancaPrincipal			;Coloca em R2 o endereço do "MenuBalancaPrincipal"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuBalancaPrincipal"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada 
	MOV R0 , Linha_inic						;Coloca no registo R0 o valor da constante "Linha_inic", que contêm endereço do display onde deve começar a ser escrito o nome do alimento selecionado
	MOV R1, Linha_end						;Coloca no registo R1 o valor da constante "Linha_end", que contêm endereço do displau onde deve terminar a ser escrito o nome do alimento selecionado

Ciclo_MostraLinha:
	MOVB R4, [R9]							;Coloca em R4 o conteúdo no endereço do alimento selecionado
	MOVB [R0], R4							;Coloca na posição de memória R0 (colando o primeiro byte que aparece na String do nome do alimento selecionado) o valor do registo R4
	ADD R9, 1								;Incrementa 1 ao registo R9, assim andando no nome um byte, para ser possível ser escrito o próximo char que aparece
	ADD R0,1								;Adiciona ao resgisto a constante 1, para ser possivel ser adicionado o seguinte char até o fim da linha do display
	CMP R0, R1								;Compara R0 e R1
	JLE Ciclo_MostraLinha					;Enquanto o R0 for menor ou igual ao registo R1 salta para a tag "Ciclo_MostraLinha", pois caso contrário já foi preenchida a linha inteira do display
											;com o nome do alimento selecionado e já é possivel inserir o peso
PesoInserido:	
	CALL RDesliga							;Chamada a rotina "RDesliga" , a qualquer a balança pode ser desligada 	
	MOV R6, PESO							;Coloca no registo R6 o endereço do periférico de entrada "PESO"
	MOV R8, [R6]							;Coloca no registo R8 conteúdo do endereço do periférico de entrada "PESO"
	MOV R7, 3000							;Coloca no registo R7 a constante 3000 (peso máximo que pode ser inserido na balança em gramas)
	CMP R8, R7								;Compara o valor do registo R8 com o valor do registo R7
	JLE Converte							;Caso o valor do registo R8 (peso) seja menor ou igual que o valor do R7 (3000), salta para tag "Converte", significa que o peso foi aceite 
	MOV R8, 0								;Caso o valor do registo tenha sido maior que 3000, então coloca no registo R8 a constante 0
	MOV [R7] , R8							;Coloca na posição de memória R7 (colocando zero, assim significa que o peso ultrapassou os 3000 e fica zero no display) o valor do registo R8

Converte:	
	CALL Converte_to_CHAR					;Chamada a rotina "Converte_to_CHAR" para converter o valor inserido em hexadecial em char
	MOV R0, SEL_NR_MENU						;Coloca no registo R6 o endereço do periférico de entrada "SEL_NR_MENU"
	MOVB R1, [R0]							;Coloca em R1 o conteúdo do endereço do periférico de entrada "SEL_NR_MENU"
	MOV R3, 1								;Coloca em R3 a constante 1
	CMP R1, R3 								;Compara o valor do registo R1 com o valor do R3 (para ver se utilizador confirmou que queria registar o alimento)
	JNE Verifica_OK							;Caso os valores sejam diferentes então salta para tag "Verifica_OK", ficando espera que o utilizador sai do menu balanca principal, podendo sempre alterar o peso a ser inserido 
	MOV R10, [R6]							;Caso os valores sejam iguais sigifica que foi registado o alimento, então no registo R10 é colocado o conteúdo de R6 (peso inserido)
	CALL CalculadoraMacros					;Chamada a rotina "CalculadoraMacros" para calcular os macronutrientes ficando guardado na memória secundária os cálculos
	CMP R8, 1								;No fim da rotina o registo R8 contêm o valor de 0 ou 1 (0 caso não houver ocorrencia de overflow ou 1 caso houver) assim comparando o valor do registo R8 a constante 1 
	JEQ ErroExcessoOver						;Caso os valores sejam iguais salta para a tag "ErroExcessoOver"
	CALL CalculadoraCalorias				;Chamada a rotina "CalculadoraCalorias" para calcular a quantidade de calorias ficando guardado na memória secundária os cálculos
	CMP R8, 1								;No fim da rotina o registo R8 contêm o valor de 0 ou 1 (0 caso não houver ocorrencia de overflow ou 1 caso houver) assim comparando o valor do registo R8 a constante 1 
	JEQ ErroExcessoOver						;Caso os valores sejam iguais salta para a tag "ErroExcessoOver"
	CALL MemoriaMacroSecundaria				;Chamada a rotina "MemoriaMacroSecundaria" para adicionar o que está guardado na memória secundária com a memória principal
	CMP R8, 1								;No fim da rotina o registo R8 contêm o valor de 0 ou 1 (0 caso não houver ocorrencia de overflow ou 1 caso houver) assim comparando o valor do registo R8 a constante 1 
	JEQ ErroExcessoOver						;Caso os valores sejam iguais salta para a tag "ErroExcessoOver"
	CALL MemoriaMacro 						;Caso não haja overflow é chamada a rotina "MemoriaMacro", que serve para passar o valores que estão na memória secundária para a memória principal onde estão os valores definitivos que
											;serão apresentados no menu total
	CALL LimpaMemoriaSecundaria
	
Verifica_OK:
	MOV R0, OK								;Coloca no registo R0 o endereço do periférico de entrada "OK"
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "OK"
	CMP R1 ,1								;Compara R1 com a constante 1
	JNE PesoInserido						;Caso os valores sejam diferentes salta para tag "PesoInserido", significando que o ultilizador ainda não deu "OK" para voltar para o "MenuPrincipal"
	JMP Ligado								;Caso os valores sejam iguais então salta para tag "Ligado" , sigifica que o "OK" está ativo então volta para o "MenuPrincipal"

ErroExcessoOver:
	MOV R2, MenuErroOverflow				;Coloca em R2 o endereço do "MenuErroOverflow"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuErroOverflow"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada
	CALL LimpaMemoriaSecundaria				;Chamada a rotina "LimpaMemoriaSecundaria" para limpar valores  de P, C ,F e Cal na memória secundária, significando que havendo overflow, os valores não somados ao total dos macronutrientes e calorias	

Verificacao:	
	MOV R0, OK								;Coloca no registo R0 o endereço do periférico de entrada "OK"
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "OK"
	CMP R1 ,1								;Compara R1 com a constante 1
	JNE Verificacao							;Caso os valores não sejam iguais, então volta para a tag "Verificacao"
	JMP Ligado								;Caso os valores sejam iguais então salta para tag "Ligado" , sigifica que o "OK" está ativo então volta para o menu principal do programa


;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;																		Rotinas
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;****************************************************************************
;Rotina Verifica Selecao
;****************************************************************************

Verifica_selecao:
	PUSH R4									;---------------------------------------------------------------------------
	PUSH R5									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R6									;
	PUSH R7									;---------------------------------------------------------------------------
	MOV R4, SEL_NR_MENU						;Coloca no registo R4 o endereço do periférico de entrada "SEL_NR_MENU"
	MOVB R5, [R4]							;Coloca no registo R5 o contéudo do endereço do periférico de entrada "SEL_NR_MENU"
	MOV R9, R5								;Coloca no registo R9 o valor o registo R5 (o numero do alimento selecionado)
	MOV R6, 1AH								;Coloca no registo R6 a constante 1AH (26 em decimal pois a selecção do alimento vai só até 26)
	CMP R9, R6								;Compara o valor do registo R9 com o valor do registo R6
	JLE Opcao_certa							;Caso o valor de R9 seja menor ou igual a R6, sigifica que a opcão é certa
	MOV R2, MenuErro						;Coloca em R2 o endereço do "MenuBalancaPrincipal"
	CALL MostraDisplay						;Chamada a rotina "MostraDisplay" para mostrar no display o "MenuErro"
	CALL LimpaPerifericos					;Chamada a rotina "LimpaPerifericos" para limpar os periféricos de entrada
	CALL RErro								;Caso o valor de R9 tenha sido maior que o valor R6, é feita a chamada da rotina "RErro" que mostra uma mensagem a dizer que foi selecionado
											;um alimento não válido
Opcao_certa:
	SUB R9, 1								;Subtrai ao registo R9 a constante 1 (para que seja possível aceder coloco a base da tabela onde contêm o primeiro elemento)
	MOV R7 , 20H							;Coloca em R7 a constante 20H 
	MUL R9, R7								;Multiplica o valor do registo R9 com o valor do registo R7, pois as Strings com os nomes do alimentos é de 20H em 20H na memória
	MOV R7, Base_Tabela						;Coloca em R7 o endereço da constante "Base_Tabela" (onde começa na memória a tabela)
	ADD R9, R7								;Adiciona o valor do registo R9 com o valor do registo R7 
	CMP R5, 0								;Compara o valor do R5 com a constante 0 
	JNZ MeBalancaPrincipal					;Caso não seja zero, então salta para a tag "MeBalancaPrincipal" onde estará a balança com o nome do alimento escolhido
											;Compara com zero o registo R5 pois apesar do número ser menor que 26, escoher 0 não é uma opção
	POP R7									;----------------------------------------------------------------------------
	POP R6									;Retira da pilha os registos guardados
	POP R5									;
	POP R4									;----------------------------------------------------------------------------
	RET
	
;****************************************************************************
;Rotina Valida seleção
;****************************************************************************

Validacao:
	PUSH R0									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R1									;----------------------------------------------------------------------------
	MOV R0, OK								;Coloca no registo R0 o endereço do periférico de entrada "OK"
	
Ciclo_V:
	MOVB R1, [R0]							;Coloca no registo R1 o contéudo do endereço do periférico de entrada "OK"
	CMP R1, 1								;Compara R1 com a constante 1
	JEQ Fim_Validacao						;Caso os valores sejam iguais, então salta para a tag "Fim_Rotina", pois para selecionar o alimento é necessário dar "OK" para validar essa seleção
	JMP Ciclo_V								;Caso não sejam iguais, então salta para a tag Ciclo_V
	
Fim_Validacao:
	POP R1									;----------------------------------------------------------------------------
	POP R0									;Retira da pilha os registos guardados
	RET 

;****************************************************************************
;Rotina Calcula Macronutrientes
;****************************************************************************
CalculadoraMacros:
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;
	PUSH R2									;
	PUSH R3									;
	PUSH R4									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R5									;
	PUSH R6									;
	PUSH R7 								;
	PUSH R9									;----------------------------------------------------------------------------
	MOV R0, SEL_NR_MENU						;Coloca no registo R0 o endereço do periférico de entrada "SEL_NR_MENU"
	MOV R5, 0								;Coloca em R5 o valor da constante 0
	MOVB [R0], R5							;Coloca na posição de memória R0 (colocando zero) o valor do registo R5
	
	MOV R8, 0 								;Coloca em R8 a constante 0 , para indicação se ocorreu ou não overflow no fim da rotina, pois caso este registo não mude para 1 no fim da rotina, então não ocorre overflow
	MOV R0, R9			 					;Coloca em R0 o valor de R9, assim passando o endereço do alimento que foi selecionado
	MOV R2, 10H								;Coloca em R2 a constante 10H (16 em decimal), pois os macronutrientes estão mais 10H da posição de memória do nome de cada um dos alimentos
	MOV R3, 64H								;Coloca em R3 a constante 64H (100 em decimal)
	MOV R4, 3 								;Coloca em R4 a constante 3 (contador) 
	MOV R5, LocalizacaoMemoriaPA			;Coloca em R5 o endereço da constante "LocalizacaoMemoriaPA" , esta constante contêm a localização na memória secundária onde vai ficar guardado as proteínas totais
	
Cont_Calculadora:
	MOV R1, R10								;Coloca em R1 o valor de R10 que é o valor do peso que foi inserido
	MOVB R7, [R0]							;Coloca em R7 o conteúdo do registo R0 ( que contêm as proteínas do alimento foi selecionado )
	MUL R1, R7								;Multiplica o valor R1 com o valor R7 (multiplicando o peso pelas proteínas do alimento selecionado)
	JV ErroOverflow							;Salta caso haja overflow para a tag "ErroOverflow"
	MOV R6, R1								;Coloca em R6 o valor de R1 (resultado da multiplicaçaão do peso pelas proteínas para que não se perca esse valor em R1)
	DIV R1, R3								;Divide o valor do R1 com o valor de R3 , pois divide-se o resultado da multiplicação por 100 devido a que as proteínas estão por cada 100g de peso do alimento)
	MOD R6, R3								;Resto da divisão inteira do valor do resgisto R6 com o valor do registo R3 (necessário para os arredondamentos)
	MOV R9, 32H								;Coloca em R9 a constante 32H (50 em decimal)
	CMP R6, R9 								;Compara valor de R6 com o valor de R9 pois é necessário ver se o resto da divisão deu menor que 50 para arredondar para cima ou para baixo
	JLT Continua							;Caso o valor de R6 seja menor que o valor em R9, sigifica que foi menor que 50 então salta para a tag "Continua" mantendo o valor que deu na divisão inteira
	ADD R1, 1								;Caso o valor de R6 seja maior ou igual ao valor de R9 então é necessário somar 1 ao registo R1, que tem o valor da divisão assim havendo arredondamento 

Continua:
	MOV [R5], R1 							;Coloca na posição de memória R5 (guardando assim o valor das proteínas na memória secundária) o valor do registo R1
	ADD R5, R2								;Adiciona ao valor do registo R5 o valor do registo R2, assim saltando na memória 10H para guardar o macronutriente seguinte
	ADD R0, 1								;Adiciona o valor do registo R0 a constante 1 (fazendo com que na tabela esteja a ser percorrido o macronutriente seguinte)
	SUB R4, 1								;Subtrai o valor do registo R4 a constante 1 (para saber que um dos 3 macronutrientes já foi calculado)
	CMP R4, 0								;Compara o valor do registo R4 com a constante 0 
	JEQ Fim_Calculadora						;Caso sejam iguais, então sigifica que o contador chegou ao fim e já foi calculado os macronutrientes (proteínas, hidratos de carbono e gorduras) e salta para tag "Fim_Calculadora"
	JMP Cont_Calculadora					;Caso sejam diferentes sigifica que irá calcular o macronutriente seguinte saltando para a tag "Cont_Calculadora"

ErroOverflow:
	MOV R8,1								;Coloca em R8 a constante 1, significando que houve ocorrencia de overflow

Fim_Calculadora:
	POP R9									;----------------------------------------------------------------------------
	POP R7									;
	POP R6									;
	POP R5									;
	POP R4									;Retira da pilha os registos guardados
	POP R3									;
	POP R2									;
	POP R1 									;
	POP R0									;----------------------------------------------------------------------------
	RET 

;****************************************************************************
;Rotina Calcula Calorias 
;****************************************************************************
CalculadoraCalorias:	
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;
	PUSH R2 								;
	PUSH R3									;Guarda na pilha os registos que são alterados	na rotina 
	PUSH R4									;
	PUSH R5									;---------------------------------------------------------------------------- 
	MOV R8, 0 								;Coloca em R8 a constante 0 , para indicação se ocorreu ou não overflow no fim da rotina, pois caso este registo não mude para 1 no fim da rotina, então não ocorre overflow
	MOV R0, LocalizacaoMemoriaPA			;Coloca em R0 o endereço da constante "LocalizacaoMemoriaPA" , esta constante contêm a localização na memória secundária onde estão guardado as proteínas calculadas
	MOV R1 , [R0]							;Coloca o conteúdo do registo R0 no registo R1 (contêm o número de proteínas calculadas na memória secundária)
	MOV R2, LocalizacaoMemoriaCA			;Coloca em R2 o endereço da constante "LocalizacaoMemoriaCA" , esta constante contêm a localização na memória secundária onde estão guardado os hidratos de carbono calculadas
	MOV R3, [R2]							;Coloca o conteúdo do registo R2 no registo R3 (contêm o número de hidratos de carbonos  calculadas na memória secundária)
	MOV R4, LocalizacaoMemoriaFA			;Coloca em R4 o endereço da constante "LocalizacaoMemoriaF" , esta constante contêm a localização na memória secundária onde estão guardado as gorduras calculadas
	MOV R5,[R4]								;Coloca o conteúdo do registo R4 no registo R5 (contêm o número de gorduras calculadas na memória secundária)
	MOV R6, 4								;Coloca em R6 a constante 4 (necessária para a multiplicação do calculo das calorias)
	MOV R7 , 9								;Coloca em R7 a constante 9 (necessária para a multiplicação do calculo das calorias)

Calcula_Calorias:
	ADD R1, R3 								;Adiciona o valor do resgisto R1 e o valor R3 ( pois as proteínas e os hidratos de carbono vão ser ambos multiplicados por 4, facilitando as contas)
	MUL R1 , R6								;Multiplica o valor de R1 (resultado da soma) com o valor de R6 (constante 4)
	JV ErroOverflowCalorias					;Salta caso haja overflow para a tag "ErroOverflowCalorias"
	MUL R5, R7								;Multica o valor de R5 com o valor de R7 (multiplicando as gorduras por 9)
	JV ErroOverflowCalorias					;Salta caso haja overflow para a tag "ErroOverflowCalorias"
	ADD R1, R5								;Adiciona o valor de R1 o valor de R5 (o resultado terá (P + C) * 4 + F * 9)
	MOV R3 , LocalizacaoMemoriaCalA			;Coloca em R3 o endereço da constante "LocalizacaoMemoriaCalA" , esta constante contêm a localização na memória secundária onde vai ficar guardado as calorias calculadas
	MOV [R3], R1							;Coloca na posição de memória R3 (guardando assim o valor das calorias na memória secundária) o valor do registo R1
	JMP Fim_Calculadora_Calorias

ErroOverflowCalorias:
	MOV R8, 1								;Coloca em R8 a constante 1, significando que houve ocorrencia de overflow
	
Fim_Calculadora_Calorias:	
	POP R5									;----------------------------------------------------------------------------
	POP R4									;
	POP R3									;Retira da pilha os registos guardados
	POP R2									;
	POP R1									;
	POP R0									;----------------------------------------------------------------------------
	RET



;****************************************************************************
;Rotina MemoriaMacroSecundaria  
;****************************************************************************
MemoriaMacroSecundaria:
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;
	PUSH R2									;
	PUSH R3									;
	PUSH R4									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R5									;
	PUSH R6									;----------------------------------------------------------------------------

	MOV R8, 0 								;Coloca em R8 a constante 0 , para indicação se ocorreu ou não overflow no fim da rotina, pois caso este registo não mude para 1 no fim da rotina, então não ocorre overflow
	MOV R0, LocalizacaoMemoriaP				;Coloca em R0 o endereço da constante "LocalizacaoMemoriaP" , esta constante contêm a localização na memória principal onde estão guardado as proteínas totais
	MOV R1, LocalizacaoMemoriaPA			;Coloca em R1 o endereço da constante "LocalizacaoMemoriaPA" , esta constante contêm a localização na memória secundária onde estão guardado as proteínas calculadas
	MOV R2, 10H								;Coloca em R2 a constante 10H (16 em decimal), pois os macronutrientes estão mais 10H da posição de memória do nome de cada um dos alimentos
	MOV R5, 4								;Coloca em R5 a constante 4 (contador)

Ciclo_soma:	
	MOV R3, [R0]							;Coloca o conteúdo do registo R0 no registo R3 (contêm o número de proteínas totais na memória principal)
	MOV R4, [R1]							;Coloca o conteúdo do registo R1 no registo R4 (contêm o número de proteínas calculadas na memória secundária)
	ADD R3, R4								;Adiciona ao valor do registo R3 o valor do registo R4 (adiciona o valor das proteínas totais com o valor das proteinas calculadas)
	JV ErroOverflowSoma						;Salta caso haja overflow para a tag "ErroOverflowSoma"
	ADD R0, R2								;Adiciona ao valor do registo R0 o valor do registo R2, assim saltando na memória 10H para localização na memoria principal do macronutriente seguinte
	ADD R1, R2								;Adiciona ao valor do registo R1 o valor do registo R2, assim saltando na memória 10H para localização na memoria secundária do macronutriente seguinte
	SUB R5, 1								;Subtrai o valor do registo R5 a constante 1 (para saber que já percorreu os macronutrientes e calorias)
	CMP R5, 0								;Compara o valor do registo R5 com a constante 0 
	JNE Ciclo_soma							;Caso sejam diferentes volta para a tag "Ciclo_soma"
	JMP Fim_rotina							;Caso sejam iguais, então sigifica que o contador chegou ao fim e já foi adicionado os macronutrientes (proteínas, hidratos de carbono e gorduras) e calorias entre a 
											;a memória principal e secundária, assim saltando para tag "Fim_rotina"
	
ErroOverflowSoma:
	MOV R8, 1								;Coloca em R8 a constante 1, significando que houve ocorrencia de overflow
	
Fim_rotina:
	POP R6									;----------------------------------------------------------------------------
	POP R5									;
	POP R4									;Retira da pilha os registos guardados
	POP R3									;
	POP R2									;
	POP R1 									;
	POP R0									;----------------------------------------------------------------------------
	RET 



;****************************************************************************
;Menu MemoriaMacro
;****************************************************************************
MemoriaMacro:
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;
	PUSH R2									;
	PUSH R3									;
	PUSH R4									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R5									;
	PUSH R6									;----------------------------------------------------------------------------
	MOV R0, LocalizacaoMemoriaP				;Coloca em R0 o endereço da constante "LocalizacaoMemoriaP" , esta constante contêm a localização na memória principal onde estão guardado as proteínas totais
	MOV R1, LocalizacaoMemoriaPA			;Coloca em R1 o endereço da constante "LocalizacaoMemoriaPA" , esta constante contêm a localização na memória secundária onde estão guardado as proteínas calculadas
	MOV R2, 10H								;Coloca em R2 a constante 10H (16 em decimal), pois os macronutrientes estão mais 10H da posição de memória do nome de cada um dos alimentos
	MOV R5, 4								;Coloca em R5 a constante 4 (contador)

Ciclo_Guarda_Memoria:	
	MOV R3, [R0]							;Coloca o conteúdo do registo R0 no registo R3 (contêm o número de proteínas totais na memória principal)
	MOV R4, [R1]							;Coloca o conteúdo do registo R1 no registo R4 (contêm o número de proteínas calculadas na memória secundária)
	ADD R3, R4								;Adiciona ao valor do registo R3 o valor do registo R4 (adiciona o valor das proteínas totais com o valor das proteinas calculadas)
	MOV [R0], R3							;Coloca na posição de memória R0 (guardando assim o valor das proteínas na memória principal) o valor do registo R3
	ADD R0, R2								;Adiciona ao valor do registo R0 o valor do registo R2, assim saltando na memória 10H para localização na memoria principal do macronutriente seguinte
	ADD R1, R2								;Adiciona ao valor do registo R1 o valor do registo R2, assim saltando na memória 10H para localização na memoria secundária do macronutriente seguinte
	SUB R5, 1								;Subtrai o valor do registo R5 a constante 1 (para saber que já percorreu os macronutrientes e calorias)
	CMP R5, 0								;Compara o valor do registo R5 com a constante 0 
	JNE Ciclo_Guarda_Memoria				;Caso sejam diferentes volta para a tag "Ciclo_Guarda_Memoria", quando o contador ficar igual a zero, significa	que os macronutrientes e as calorias já estão na memoria principal, que será apresentada no menu total
	POP R6									;----------------------------------------------------------------------------
	POP R5									;
	POP R4									;Retira da pilha os registos guardados
	POP R3									;
	POP R2									;
	POP R1 									;
	POP R0									;----------------------------------------------------------------------------
	RET 

;****************************************************************************
;Rotina Converte to char
;****************************************************************************

Converte_to_CHAR:
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;
	PUSH R2									;
	PUSH R3									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R4 								;
	PUSH R5									;
	PUSH R8 								;----------------------------------------------------------------------------
	MOV R0, 10								;Coloca em R0 o valor 10 para fazer as divisões
	MOV R2,	LocalizacaoPesoDisplay			;Coloca em R2 o endreço base do display onde ficará visualizado o peso
	ADD R2, 3								;Adiciona ao valor de R2 a constante 3 , sendo a osiçao do 1º caracter preencher
	MOV R3, 0								;Coloca em R3 a constante 0, assim R3 tem número total de caracteres já preenchidos

ProximoCarater:
	MOV R4, R8								;Coloca em R4 o valor do registo R8, para não perder o valor ao fazer o calculo do resto
	MOD R4, R0								;R4 fica com o resto da divisao inteira por R0 (10) -D
	DIV R8, R0								;R1 fica com o quociente da divisão inteira por R0 (10) -X
	MOV R5, 48
	ADD R5, R4 								;Adiciona 48 ao resto para obter o caracter em ASCII
	MOVB [R2], R5 							;Guarda no display o caracter
	SUB R2, 1								;Subtrai R2 a constante 1 para obter próxima posiçao a preencher
	ADD R3, 1								;Adiciona ao registo R3 a constante 1 para incrementar o número total de carateres já preenchidos
	CMP R8, 0								;Verifica se x já é zero
	JNE ProximoCarater						;Caso não seja zero , passa para o próximo caracter

PreencherVazios:
	CMP R3, NR_TOT_CAR						;Verifica se já preencheu todos
	JEQ Fim_Rotina							;Se sim termina
	MOV R5, caraterVazio					;Caso contrário, preenche com o carácter vazio
	MOVB [R2], R5							;Coloca na posição de memória do registo R2 o valor de R5 (assim prenchendo o resto com caracteres vazios)
	SUB R2, 1								;Próxima posição a preencher
	ADD R3, 1								;Incrementamos o numero total de carateres ja preenchidos
	JMP PreencherVazios						;Salta para a tag "PreencherVazios"
	
Fim_Rotina:
	POP R8									;----------------------------------------------------------------------------
	POP R5									;
	POP R4									;
	POP R3									;Retira da pilha os registos guardados
	POP R2									;
	POP R1									;
	POP R0									;----------------------------------------------------------------------------
	RET		
	
;****************************************************************************
;Rotina Converte to char Macronutrientes
;****************************************************************************
Converte_to_CHAR_M:
    PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;
	PUSH R2									;
	PUSH R3									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R4 								;
	PUSH R5									;
	PUSH R6									;
	PUSH R7									;
	PUSH R8 								;----------------------------------------------------------------------------
	MOV R8, 4								;Coloca em R8 a constante 3 (contador)
	MOV R7, LocalizacaoMemoriaP				;Coloca em R7 o endereço da constante "LocalizacaoMemoriaP" , esta constante contêm a localização na memória onde estão guardado as proteínas totais
	MOV R6,[R7]								;Coloca o conteúdo do registo R7 no registo R6 (contêm o número de proteínas totais)
	MOV R9, LocalizacaoPDisplay				;Coloca em R9 o endreço base do display onde ficará visualizado as proteínas (para não perder o valor)
	MOV R2,	LocalizacaoPDisplay				;Coloca em R2 o endreço base do display onde ficará visualizado as proteínas
	
Ciclo:
	MOV R0, 10								;Coloca em R0 o valor 10 para fazer as divisões
	ADD R2, 3								;Adiciona ao valor de R2 a constante 3 , sendo a osiçao do 1º caracter preencher
	MOV R3, 0								;Coloca em R3 a constante 0, assim R3 tem número total de caracteres já preenchidos
	
ProximoCarater_M:
	MOV R4, R6								;Coloca em R4 o valor do registo R6, para não perder o valor ao fazer o calculo do resto
	MOD R4, R0								;R4 fica com o resto da divisao inteira por R0 (10) -D
	DIV R6, R0								;R1 fica com o quociente da divisão inteira por R0 (10) -X
	MOV R5, 48
	ADD R5, R4 								;Adiciona 48 ao resto para obter o caracter em ASCII
	MOVB [R2], R5 							;Guarda no display o caracter
	SUB R2, 1								;Subtrai R2 a constante 1 para obter próxima posiçao a preencher
	ADD R3, 1								;Adiciona ao registo R3 a constante 1 para incrementar o número total de carateres já preenchidos
	CMP R6, 0								;Verifica se x já é zero
	JNE ProximoCarater_M					;Caso não seja zero , passa para o proximo caracter

PreencherVazios_M:
	CMP R3, NR_TOT_CAR						;Verifica se já preencheu todos
	JEQ Fim_Rotina_M						;Se sim termina
	MOV R5, caraterVazio					;Caso contrário, preenche com o carácter vazio
	MOVB [R2], R5							;Coloca na posição de memória do registo R2 o valor de R5 (assim prenchendo o resto com caracteres vazios)
	SUB R2, 1								;Próxima posição a preencher
	ADD R3, 1								;Incrementamos o numero total de carateres ja preenchidos
	JMP PreencherVazios_M

Fim_Rotina_M:
	MOV R1 , 10H							;Coloca em R1 a constante 10H (16 em decimal) para puder passar depois para prencher os seguintes macronutrientes e calorias
	ADD R9 , R1								;Adiciona o valor R9 o valor R1 para passar a linha seguinte 
	MOV R2, R9								;Coloca em R2 o valor de R9 (R2 é o localização para colocar o próximo macronutriente ou caloria no display)
	ADD R7 ,R1								;Adiciona o valor R7 o valor R1 (assim também na memória salta uma linha acedendo a memória do seguinte macronutriente ou calorias)
	MOV R6 , [R7]							;Coloca o conteúdo do registo R7 no registo R6 (contêm o número total do macronutriente seguinte)
	SUB R8, 1								;Subtrai 1 ao contador
	CMP R8, 0								;Compara com o contador com 0
	JNE Ciclo								;Enquanto o contador não é zero vai preenchendo e colocando no dislay o valor das proteinas, hidratos de carbono, gorduras e calorias no display, caso contrário termina 
	POP R8									;----------------------------------------------------------------------------
	POP R7 									;
	POP R6									;
	POP R5									;
	POP R4									;Retira da pilha os registos guardados
	POP R3									;
	POP R2									;
	POP R1									;
	POP R0									;----------------------------------------------------------------------------
	RET		

;****************************************************************************
;Rotina Erro
;****************************************************************************
RErro:
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;Guarda na pilha os registos que são alterados	na rotina
	MOV R0, OK								;Coloca no registo R0 o endereço do periférico "OK"
	
Erro:
	MOVB R1, [R0]							;Coloca no registo R1 o valor do carater do periférico "OK"
	CMP R1 ,1								;Compara o registo R1 com o valor constante 1
	JNE Erro								;Caso não seja R1 igual a 1 então salta para o ciclo "Erro"
	JMP Ligado								;Caso os valores sejam iguais então salta para tag "Ligado" , sigifica que o "OK" está ativo então volta para o menu principal do programa
	POP R1									;Retira da pilha os registos guardados
	POP R0									;----------------------------------------------------------------------------
	RET 

;****************************************************************************
;Rotina Limpa Display
;****************************************************************************
LimpaDisplay:								
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R2									;----------------------------------------------------------------------------
	MOV R0, Display_inic					;Coloca em R0 o endereço do íncio do display
	MOV R1, Display_end						;Coloca em R1 o endereço do fim do display
	
Ciclolimpa:	
	MOV R2, caraterVazio					;Coloca em R2 o carater vazio 
	MOVB [R0], R2							;Coloca na memória na posição do R0 o carater vazio, assim limpando a primeira linha do display
	ADD R0, 1								;Incrementa o valor 1 ao valor do registo R0
	CMP R0, R1								;Compara o registo R0 e R1
	JLE Ciclolimpa							;Verifica se já está no final do display, caso não tenha chegado ao fim do display salta para "Ciclolimpa"
	POP R2									;----------------------------------------------------------------------------
	POP R1									;Retira da pilha os registos guardados
	POP R0									;----------------------------------------------------------------------------
	RET 

;****************************************************************************
;Rotina Limpa Macronutrientes
;**************************************************************************** 
LimpaMacronutrientes:
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;
	PUSH R2									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R3									;
	PUSH R5									;----------------------------------------------------------------------------
	MOV R0, LocalizacaoMemoriaP				;Coloca em R0 o endereço do "LocalizacaoMemoriaP"
	MOV R1, LocalizacaoMemoriaC				;Coloca em R1 o endereço do "LocalizacaoMemoriaC"
	MOV R2, LocalizacaoMemoriaF				;Coloca em R2 o endereço do "LocalizacaoMemoriaF"
	MOV R3, LocalizacaoMemoriaCal			;Coloca em R3 o endereço do "LocalizacaoMemoriaCal"
	MOV R5, 0								;Coloca em R5 o valor da constante 0
	MOV [R0], R5							;Coloca na posição de memória do periférico "LocalizacaoMemoriaP" o valor do registo R5, assim limpando a memoria
	MOV [R1], R5							;Coloca na posição de memória do periférico "LocalizacaoMemoriaC" o valor do registo R5, assim assim limpando a memoria
	MOV [R2], R5							;Coloca na posição de memória do periférico "LocalizacaoMemoriaF" o valor do registo R5, assim limpando a memoria
	MOV [R3], R5							;Coloca na posição de memória do periférico LocalizacaoMemoriaCal" o valor do registo R5, assim limpando a memoria
	POP R5									;----------------------------------------------------------------------------
	POP R3									;
	POP R2									;Retira da pilha os registos guardados
	POP R1									;
	POP R0									;----------------------------------------------------------------------------
	RET 


;****************************************************************************
;Rotina Limpa Memória Secundária
;**************************************************************************** 
LimpaMemoriaSecundaria:
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;
	PUSH R2									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R3									;
	PUSH R5									;----------------------------------------------------------------------------
	MOV R0, LocalizacaoMemoriaPA			;Coloca em R0 o endereço do "LocalizacaoMemoriaPA"
	MOV R1, LocalizacaoMemoriaCA			;Coloca em R1 o endereço do "LocalizacaoMemoriaCA"
	MOV R2, LocalizacaoMemoriaFA			;Coloca em R2 o endereço do "LocalizacaoMemoriaFA"
	MOV R3, LocalizacaoMemoriaCalA			;Coloca em R3 o endereço do "LocalizacaoMemoriaCalA"
	MOV R5, 0								;Coloca em R5 o valor da constante 0
	MOV [R0], R5							;Coloca na posição de memória do periférico "LocalizacaoMemoriaPA" o valor do registo R5, assim limpando a memoria secundária
	MOV [R1], R5							;Coloca na posição de memória do periférico "LocalizacaoMemoriaCA" o valor do registo R5, assim assim limpando a memoria secundária
	MOV [R2], R5							;Coloca na posição de memória do periférico "LocalizacaoMemoriaFA" o valor do registo R5, assim limpando a memoria secundária
	MOV [R3], R5							;Coloca na posição de memória do periférico LocalizacaoMemoriaCalA" o valor do registo R5, assim limpando a memoria secundária
	POP R5									;----------------------------------------------------------------------------
	POP R3									;
	POP R2									;Retira da pilha os registos guardados
	POP R1									;
	POP R0									;----------------------------------------------------------------------------
	RET 

;****************************************************************************
;Rotina Limpa Periféricos
;**************************************************************************** 
LimpaPerifericos:
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;
	PUSH R2									;Guarda na pilha os registos que são alterados	na rotina
	PUSH R3									;
	PUSH R4									;----------------------------------------------------------------------------
	MOV R0, ON_OFF							;Coloca em R0 o endereço do periférico de entrada "ON_OFF"
	MOV R1, SEL_NR_MENU						;Coloca em R1 o endereço do periférico de entrada "SEL_NR_MENU"
	MOV R2, OK								;Coloca em R2 o endereço do periférico de entrada "OK"
	MOV R3, CHANGE							;Coloca em R3 o endereço do periférico de entrada "CHANGE"
	MOV R4, PESO 							;Coloca em R4 o endereço do periférico de entrada "PESO"
	MOV R5, 0								;Coloca em R5 o valor da constante 0
	MOVB [R0], R5							;Coloca na posição de memória do periférico "ON_OFF" o valor do registo R5, assim limpando o periférico
	MOVB [R1], R5							;Coloca na posição de memória do periférico "SEL_NR_MENU" o valor do registo R5, assim limpando o periférico
	MOVB [R2], R5							;Coloca na posição de memória do periférico "OK" o valor do registo R5, assim limpando o periférico
	MOVB [R3], R5							;Coloca na posição de memória do periférico "CHANGE" o valor do registo R5, assim limpando o periférico
	MOV [R4], R5							;Coloca na posição de memória do periférico "PESO" o valor do registo R5, assim limpando o periférico
	POP R4 									;----------------------------------------------------------------------------
	POP R3									;
	POP R2									;Retira da pilha os registos guardados
	POP R1									;
	POP R0									;----------------------------------------------------------------------------
	RET 

;****************************************************************************
;Rotina Mostra Display 
;****************************************************************************

MostraDisplay:
	PUSH R0									;----------------------------------------------------------------------------
	PUSH R1									;Guarda na pilha os registos que são alterados na rotina
	PUSH R3 								;----------------------------------------------------------------------------
	MOV R0, Display_inic					;Endereço do ínicio do display
	MOV R1, Display_end						;Endereço do final do display
	
Ciclomostra:
	MOV R3, [R2]							;Copia palavra do menu
	MOV [R0], R3							;Copia coloca no display
	ADD R2, 2								;Incrementa o valor 2 ao valor da palavra do menu
	ADD R0, 2								;Incrementa o valor 2 ao valor da memória do display
	CMP R0, R1								;Compara o valor do resgisto R0 com o valor do registo R1
	JLE Ciclomostra							;Caso o valor de R0 seja menor ou igual que R1 o cilo continua, caso seja maior termina
	POP R3									;----------------------------------------------------------------------------
	POP R1									;Retira da pilha os registos guardados
	POP R0									;----------------------------------------------------------------------------
	RET 	
	
;****************************************************************************
;Rotina Desligar
;****************************************************************************
RDesliga:
	PUSH R0									;Guarda na pilha os registos que são alterados na rotina
	PUSH R1									;----------------------------------------------------------------------------
	MOV R0, ON_OFF							;Coloca no registo R0 o endereço do periférico "OK"
	MOVB R1, [R0]							;Coloca no registo R1 o valor do carater do periférico "OK"
	CMP R1 ,1								;Compara o registo R1 com o valor constante 1
	JNE Fim									;Caso seja diferentes então salta paraa tag "Fim" e termina a rotina
	JMP ProgramaPrincipal					;Caso sejam iguais salta para ºProgramaPrincipal" onde o display está vazio
	
Fim:
	POP R1									;----------------------------------------------------------------------------
	POP R0									;Retira da pilha os registos guardados
	RET

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Tabela com os macro nutrientes por cada 100 g de um dado alimento
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Place 6000H
	String "     Aveia      "
	String 11,56,7
Place 6020H
	String "  Pão de forma  "
	String 9,42,3
Place 6040H
	String "    Batata      "
	String 3,19,0
Place 6060H
	String "    Arroz       "
	String 7,25,0
Place 6080H
	String "    Feijão      "
	String 10,13,0
Place 60A0H
	String "    Legumes     "
	String 3,7,0
Place 60C0H
	String "    Tomate      "
	String 1,3,0
Place 60E0H
	String "     Banana     "
	String 1,23,0
Place 6100H
	String "     Laranja    "
	String 1,12,0
Place 6120H
	String "      Maçã      "
	String 1,14,0
Place 6140H
	String "      Kiwi      "
	String 1,15,0
Place 6160H
	String "   Bolacha Choc "
	String 9,59,22
Place 6180H
	String "  Pizza Q&F PD  "
	String 13,25,9
Place 61A0H
	String "     Amêndoas   "
	String 25,6,55
Place 61C0H
	String "     Linhaça    "
	String 18,34,36
Place 61E0H
	String "      Azeite    "
	String 0,0,100
Place 6200H
	String "    Leite Magro "
	String 3,4,0
Place 6220H
	String "      Whey      "
	String 80,8,4
Place 6240H
	String "     Salmão     "
	String 21,0,15
Place 6260H
	String "    Pescada     "
	String 20,0,1
Place 6280H
	String "    Atum        "
	String 25,0,2
Place 62A0H
	String "    Porco       "
	String 22,0,15
Place 62C0H
	String " Frango (peito) "
	String 25,0,4
Place 62E0H
	String "   Peru (peito) "
	String 28,0,1
Place 6300H
	String "      Ovo       "
	String 7,0,5
Place 6320H 
	String "    Queijo      "
	String 28,0,13