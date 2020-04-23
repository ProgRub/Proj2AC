;constantes:
Normal 					    EQU 20 		;3.7 kWh
Semirapido 				    EQU 60 		;22 kWh
Rapido 					    EQU 100 	;50 kWh
CustoNormal 			    EQU 1		;custo do carregamento normal
CustoSemiRapido 		    EQU 2 		;custo do carregamento semirápido
CustoRapido 			    EQU 3 		;custo do carregamento rápido
EnderecoBateriaNormal   	EQU 1200H ;endereço onde é guardado o valor da bateria para o carregamento normal
EnderecoBateriaSemiRapido   EQU 1202H ;endereço onde é guardado o valor da bateria para o carregamento semi-rápido
EnderecoBateriaRapido   	EQU 1204H ;endereço onde é guardado o valor da bateria para o carregamento rápido

InicioDisplay 				EQU 0030H
FimDisplay 					EQU 009FH

;endereços de memória relativos aos inputs:
OK                          EQU 00B0H     ;endereço do botão OK
InputID                     EQU 00D0H     ;endereço onde inserir o ID do cliente
InputCodSeguranca           EQU 00D2H     ;endereço onde inserir o código de segurança do cliente
InputSaldo                  EQU 00D4H     ;endereço onde inserir o ID do cliente
InputBateria         	    EQU 00D6H     ;endereço onde inserir o código de segurança do cliente
InputOpcao    			    EQU 00E0H     ;endereço onde inserir o tipo de carregamento
InputTempo                  EQU 00E2H     ;endereço onde inserir o tempo desejado
InputIncrementoBateria      EQU 00E4H 	  ;endereço onde inserir a bateria a adicionar à bateria selecionada

;endereços relativos à base de dados
Base_Tabela_Dados 		    EQU 1100H ;endereço do início da base de dados
CodSeguranca 			    EQU 02H ;aumento relativo ao inicio dos dados do cliente para ler o código de segurança
Saldo 					    EQU 04H ;aumento relativo ao inicio dos dados do cliente para ler o saldo
BateriaCarro 				EQU 06H ;aumento relativo ao inicio dos dados do cliente para ler quanta bateria o carro do cliente tem
Proximo 					EQU 08H ;salto a executar para ler os dados do próximo cliente
EnderecoTamanho 			EQU 10FEH ;endereço que contém o número de clientes na base de dados

StackPointer 				EQU 8000H ;endereço da pilha



;*****************************************************************************************************************************************
;                                           DISPLAYS
;*****************************************************************************************************************************************
PLACE 2000H
Display_InputVerifyCliente:
    String "  VERIFICACAO   "
    String "                "
    String "  INTRODUZA ID  "
    String "                "
    String " E CODIGO SEG.  "
    String "                "
	String " OK - continuar "

PLACE 2080H
Display_VerificacaoSucesso:
    String "                "
    String "                "
    String "   AUTORIZADO   "
    String "   COM SUCESSO  "
    String "                "
	String " OK - continuar "

PLACE 2100H
Display_VerificacaoFalhada:
	String "     ATENCAO    "
    String "                "
    String "                "
    String "                "
    String " NAO AUTORIZADO "
    String "                "
    String "                "
	String " OK - continuar "

PLACE 2180H
Display_InsereEnergia:
    String " CARREGAR POSTO "
    String "Escolha bateria:"
    String "1)- Normal      "
    String "2)- Semi-Rapido "
    String "3)- Rapido      "
    String "4)- Avancar     "
	String " OK - continuar "

PLACE 2200H
Display_InsereEnergiaQuanta:
    String " CARREGAR POSTO "
    String "  Quanto quer   "
    String "   carregar?    "
    String "                "
    String "                "
    String "                "
	String " OK - continuar "

PLACE 2280H
Display_NiveisDeEnergia:
    String " ESTADO DO POSTO"
    String "Normal:         "
    String "SemiRapido:     "
    String "                "
    String "Rapido:         "
    String "                "
	String " OK - continuar "

PLACE 2300H
Display_EscolheCarregamento:
	String " ESCOLHA O TIPO	"
	String "DE CARREGAMENTO:"
	String "  1- Normal     "
	String "  2- Semi-Rapido"
	String "  3- Rapido     " 
	String "                "
	String " OK - continuar "

PLACE 2380H
Display_OpcaoInvalida:
	String "    ATENCAO     "
	String "                "
	String "     OPCAO      "
	String "    INVALIDA    "
	String "                "
	String "                "
	String " OK - continuar "

PLACE 2400H
Display_EscolherTempo:
	String " ESCOLHA O TEMPO"
	String "DE CARREGAMENTO:"
	String "                "
	String "                "
	String "    Tempo:      "
	String "                "
	String " OK - continuar "

PLACE 2480H
Display_TempoInvalido:
	String "     OPCAO      "
	String "    INVALIDA    "
	String "                "
	String "tempo tem de ser"
	String "   superior a 0 "
	String "                "
	String " OK - continuar "

PLACE 2500H
Display_Debito:
	String "  CARREGAMENTO  "
	String "                "
	String "   Saldo:       "
	String "                "
	String "   Custo:       "
	String "                "
	String " OK - continuar "

PLACE 2580H
Display_SaldoInsuficiente:
	String "     ATENCAO    "
	String "                "
	String "     SALDO      "
	String "  INSUFICIENTE  "
	String "                "
	String "                "
	String " OK - continuar "

PLACE 2600H
Display_InfoCarregamento:
	String "  CARREGAMENTO  "
	String "                "
	String "   Tipo:        "
	String "                "
	String "   Duracao:     "
	String "                "
	String " OK - continuar "

PLACE 2680H
Display_CarregamentoConcluido:
	String "                "
	String "                "
	String "  CARREGAMENTO  "
	String "    CONCLUIDO   "
	String "                "
	String "                "
	String " OK - continuar "
PLACE 2700H
Display_Overflow:
	String "     ATENCAO    "
	String "                "
	String "     OCORREU    "
	String "    OVERFLOW    "
	String "                "
	String "                "
	String " OK - continuar "

PLACE 2780H
Display_UltrapassaCargaMaxima:
	String "     ATENCAO    "
	String " O CARREGAMENTO "
	String "IRA ULTRAPASSAR "
	String " A CARGA MAXIMA "
	String "   DA BATERIA   "
	String "                "
	String " OK - continuar "
	
PLACE 2800H
Display_TempoUltrapassa:
	String "                "
	String "     ATENCAO    "
	String " NAO HA ENERGIA "
	String " SUFICIENTE PARA"
	String " O CARREGAMENTO "
	String "   PRETENDIDO   "
	String "                "
	String " OK - continuar "

PLACE 2880H
Display_AlterarBaseDeDados:
	String " BASE DE DADOS  "
	String "Pretende fazer  "
	String "alteracoes na   "
	String "base de dados?  "
	String "1- Sim          "
	String "2- Nao          "
	String " OK - continuar "

PLACE 2900H
Display_CriarOuAlterar:
	String " BASE DE DADOS  "
	String "Pretende criar  "
	String "um cliente ou   "
	String "alterar um?     "
	String "1- Criar        "
	String "2- Alterar Dados"
	String " OK - continuar "

PLACE 2980H
Display_QualCliente:
	String " BASE DE DADOS  "
	String "Insira o ID e   "
	String "codigo de seg.  "
	String "do cliente que  "
	String "pretende alterar"
	String "                "
	String " OK - continuar "

PLACE 2A00H
Display_InserirDadosParaAlterar:
	String " BASE DE DADOS  "
	String "Insira o ID,    "
	String "codigo de seg., "
	String "saldo e bateria "
	String "do carro novos  "
	String "para alterar    "
	String " OK - continuar "

PLACE 2A80H
Display_DadosAlterados:
	String " BASE DE DADOS  "
	String "                "
	String " DADOS ALTERADOS"
	String "  COM SUCESSO!  "
	String "                "
	String "                "
	String " OK - continuar "

PLACE 2B00H
Display_ClienteNaoEstaNaDatabase:
	String " BASE DE DADOS  "
	String "                "
	String "   Cliente nao  "
	String "  esta na base  "
	String "    de dados    "
	String "                "
	String " OK - continuar "

PLACE 2B80H
Display_InserirDadosNovos:
	String " BASE DE DADOS  "
	String "Insira o ID,    "
	String "codigo de seg., "
	String "saldo e bateria "
	String "do carro do novo"
	String "    cliente     "
	String " OK - continuar "

PLACE 2C00H
Display_SaldoInvalido:
	String " BASE DE DADOS  "
	String "                "
	String " SALDO INVALIDO "
	String "   (tem de ser  "
	String "    positivo)   "
	String "                "
	String " OK - continuar "

PLACE 2C80H
Display_BateriaInvalida:
	String " BASE DE DADOS  "
	String "BATERIA DO CARRO" 
	String "    INVALIDA    "
	String "   (tem de ser  "
	String "positiva e menor"
	String "     que 100)   "
	String " OK - continuar "

PLACE 2D00H
Display_NovoClienteCriado:
	String " BASE DE DADOS  "
	String "                "
	String "  NOVO CLIENTE  "
	String "     CRIADO!    "
	String "                "
	String "                "
	String " OK - continuar "

PLACE 2D80H
Display_IncrementaBateriaInvalido:
	String "     ATENCAO    "
	String "                "
	String "   VALOR DEVE   "
	String "  SER POSITIVO! "
	String "                "
	String "                "
	String " OK - continuar "

PLACE 2E00H
Display_BateriaCarregada:
	String " CARREGAR POSTO "
	String "                "
	String "    BATERIA     "
	String "   CARREGADA!   "
	String "                "
	String "                "
	String " OK - continuar "


;*****************************************************************************************************************************************
;                                               MAIN
;*****************************************************************************************************************************************

PLACE 0000H
Inicio:
    MOV R0,Main
    PUSH R0
    POP R0
    JMP R0


;*****************************************************************************************************************************************
;                                               PROGRAMA
;*****************************************************************************************************************************************
PLACE 6000H
Main:
    MOV SP, StackPointer ;mete em SP o endereço do início da pilha
    CALL Programa ;chama-se o programa
    JMP Fim

Programa:
    CALLF LimpaDisplay ;limpa o display
    CALL AlteraBaseDeDados ;rotina para alterar a base de dados
    CALL InsereEnergia ;rotina para carregar os postos
    CALL NiveisDeEnergia ;rotina para indicar se os postos estão operacionais
    MOV R4,-1 ;mete em R4 o valor -1 para fins de comparação
    CMP R10,R4 ;compara-se o valor em R10 com R4 (-1)
    JEQ Programa ;se são iguais, isto significa que nenhum dos postos tem o nível mínimo de bateria e volta-se ao início do programa
    CALL Verificacao_Cliente ;rotina para efetuar a verificação do cliente
	MOV R4, -1 ;mete em R4 o valor -1 para comparar com R10, o indice do cliente verificado (possivelmente)
	CMP R10, R4 ;se R10 for igual a -1 (R4), significa que o cliente não está na base de dados e o utilizador não foi verificado
	JEQ Programa ;se tal acontecer, volta-se ao inicio do programa
    CALL Carregamento ;rotina para efetuar o carregamento do carro
	JMP Programa ;voltar ao início do programa
    RET

;*************************************************************************************************************************************
;                                       ROTINA AlteraBaseDeDados
;                       Responsável por inserir novos clientes ou alterar dados de clientes
;                       na base de dados
;**************************************************************************************************************************************

AlteraBaseDeDados:
    PUSH R0 ;*********************************************************************************************************************
    PUSH R1 ;
    PUSH R2 ;
    PUSH R3 ;
    PUSH R4 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R5 ;
    PUSH R6 ;
    PUSH R7 ;
    PUSH R8 ;*********************************************************************************************************************
AlterarOuNao: ;Inicio da rotina
    MOV R2, InputOpcao ;mete-se em R2 o endereço de onde ler a opção que o utilizador escolhe
    MOV R9, Display_AlterarBaseDeDados ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOVB R0,[R2] ;move o byte endereçado por R2, onde está a opção selecionada pelo utilizador, para R0
    CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
    CMP R0,1 ;compara a opção selecionada pelo utilizador com 1
    JEQ CriarOuAlterar ;se for igual, o utilizador indicou que pretende alterar a base de dados
    CMP R0,2 ;se R0 não é igual a 1, compara-se a 2
    JNE OpcaoInvalidaDatabase  ;se R0 não é igual a 2, o utilizador inseriu uma opção inválida
    JMP FimFunc4 ;se R0 é igual a 2, o utilizador indicou que não pretende alterar a base de dados e salta-se para o fim desta rotina
OpcaoInvalidaDatabase: ;instruções relativas ao registo de uma opção inválida inserida pelo utilizador
    MOV R9, Display_OpcaoInvalida ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP AlterarOuNao ;volta ao início da rotina
CriarOuAlterar: ;a rotina chega aqui se o utilizador indicou que quer fazer alterações à base de dados
    MOV R9, Display_CriarOuAlterar ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOVB R0,[R2] ;move o byte endereçado por R2, onde está a opção selecionada pelo utilizador, para R0
    CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
    CMP R0,1 ;compara a opção selecionada pelo utilizador com 1
    JNE AlterarDados ;se R0 não é igual a 1, o utilizador ou pretende alterar os dados de um cliente existente ou inseriu uma opção inválida, por isso salta-se para a tag AlterarDados
    MOV R8,Base_Tabela_Dados ;mete-se em R8 o início da base de dados
    MOV R9,EnderecoTamanho ;mete-se em R9 o endereço onde está guardado o tamanho da base de dados
    MOV R10,[R9] ;mete-se em R10 o tamanho da base de dados (endereçado por R9)
    MOV R7,Proximo ;mete-se em R7 o tamanho do salto a ser efetuado para saltar dos dados de um cliente para os dados de outro
    MUL R10,R7 ;esta multiplicação do tamanho pelo valor Proximo garante que o novo cliente é criado no fim da base de dados
    ADD R8,R10 ;adiciona-se o valor da multiplicação anterior ao início da base de dados, para gravar-se os dados inseridos no fim da base de dados
    MOV R5, InputID ;mete em R5 o endereço de onde se lê o ID do novo cliente
    MOV R6, InputCodSeguranca ;mete em R6 o endereço de onde se lê o código de segurança do novo cliente
    MOV R7, InputSaldo ;mete em R7 o endereço de onde se lê o saldo do novo cliente
    MOV R4, InputBateria ;mete em R7 o endereço de onde se lê quanta bateria o carro do cliente terá
    MOV R9, Display_InserirDadosNovos ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R0,[R5] ;mete em R0 o valor do ID do novo cliente que o utilizador meteu
    MOV R1,[R6] ;mete em R1 o valor do código de segurança do novo cliente que o utilizador meteu
    MOV R2,[R7] ;mete em R2 o valor do saldo do novo cliente que o utilizador meteu
    MOV R3,[R4] ;mete em R3 o valor da bateria do carro do novo cliente que o utilizador meteu
    CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
    CMP R2,0 ;compara o valor do saldo com zero
    JLT SaldoInvalido ;se o saldo que o utilizador inseriu para o novo cliente for negativo, efetua-se este salto e o novo cliente não é criado
    CMP R3,0 ;compara o valor da bateria do carro com zero
    JLT BateriaInvalida ;se o valor da bateria do carro for negativo, efetua-se este salto e o novo cliente não é criado
    MOV R7,100 ;mete em R7 o valor 100 para fins de comparação
    CMP R3,R7 ;compara o valor da bateria do carro com R7, que é 100
    JGT BateriaInvalida ;se o valor da bateria do carro for maior que 100, efetua-se este salto e o novo cliente não é criado
    MOV R5,CodSeguranca ;mete em R5 o incremento relativo ao inicio dos dados de um cliente de onde se lê o código de segurança dele
    MOV R6,Saldo ;mete em R6 o incremento relativo ao inicio dos dados de um cliente de onde se lê o saldo dele
    MOV R7,BateriaCarro ;mete em R7 o incremento relativo ao inicio dos dados de um cliente de onde se lê o valor da bateria do carro dele
    MOV [R8],R0 ;mete em R8, que é o fim da base de dados, onde se vai inserir o novo cliente, o ID deste 
    MOV [R8+R5],R1 ;mete em R8 + R5, o lugar onde está o código de segurança de um cliente, o código de segurança do novo cliente
    MOV [R8+R6],R2 ;mete em R8 + R6, o lugar onde está o saldo de um cliente, o saldo do novo cliente
    MOV [R8+R7],R3 ;mete em R8 + R7, o lugar onde está o valor da bateria do carro do cliente, o valor da bateria do carro do novo cliente
    MOV R1,EnderecoTamanho ;mete em R1 o endereço onde está guardado o tamanho da base de dados para fins de atualização
    MOV R0,[R1] ;mete em R0 o tamanho da base de dados
    ADD R0,1 ;incrementa-se o tamanho por 1, pois foi criado um novo cliente
    MOV [R1],R0 ;atualiza-se o tamanho guardado em memória com o novo tamanho, em R0
    MOV R9, Display_NovoClienteCriado ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP AlterarOuNao ;Volta ao início do programa
AlterarDados: ;A rotina chega aqui se o utilizador ou pretende alterar os dados de um cliente existente ou inseriu uma opção inválida
    CMP R0,2 ;Compara a opção escolhida pelo utilizador com 2
    JNE OpcaoInvalidaDatabase ;se é diferente de 2, o utilizador inseriu uma opção inválida efetua-se este salto; se é igual a 2, procede-se para as instruções abaixo
    MOV R5,InputID ;mete-se em R5 o endereço de onde se lerá o ID do cliente ao qual a alterar os dados
    MOV R6, InputCodSeguranca ;mete-se em R6 o endereço de onde se lerá o código de segurança do cliente ao qual alterar os dados
    MOV R8, Base_Tabela_Dados ;mete-se em R8 o início da base de dados
    MOV R3,0 ;mete-se em R3 o índice
    MOV R4,CodSeguranca ;mete-se em R4 o "salto" relativo ao início dos dados de um cliente para ler o código de segurança deste na base de dados
    MOV R9, Display_QualCliente ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R0,[R5] ;mete em R0 o ID que o utilizador inseriu
    MOV R1,[R6] ;mete em R1 o código de segurança que o utilizador inseriu
    CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
Ciclo_AlterarDados: ;ciclo em que se percorre a base de dados
    MOV R5, [R8] ;R5 tem o valor do ID da tabela de base de dados a verificar
    MOV R6, [R8+R4] ;R6 tem o valor de código de segurança da tabela de base de dados a verificar
    CMP R0,R5 ;compara-se o ID inserido pelo utilizador com o ID do cliente a ser verificado atualmente
    JNE ContinuarTabela ;se os valores forem diferentes, efetua-se este salto para avançar para o próximo cliente, se não estivermos já no último cliente da base de dados
    CMP R1,R6 ;compara-se o código de segurança inserido pelo utilizador com o código de segurança do cliente a ser verificado atualmente
    JNE ContinuarTabela ;se os valores forem diferentes, efetua-se este salto para avançar para o próximo cliente, se não estivermos já no último cliente da base de dados
	MOV R10, Proximo ;se tanto o ID como o código de segurança são iguais, guarda-se em R10 o incremento a efetuar para ler os dados de um novo cliente
    MUL R10,R3 ;multiplicamos o valor de Proximo pelo índice para obtermos em R10 o incremento a adicionar ao início da base de dados para alterarmos os dados do cliente verificado
    JMP AlterarDadosCliente ;efetua-se o salto para a parte que tratará de alterar os dados do cliente que o utilizador selecionou
ContinuarTabela: ;esta parte avança para verificar os dados do próximo cliente, porque previamente os dados que o utilizador inseriu e os que estão na base de dados não coincidiam
    ADD R3,1 ;adiciona-se ao índice 1 para indicar que avançamos um cliente
    MOV R9,EnderecoTamanho ;mete em R9 o endereço onde encontra-se o tamanho da base de dados
    MOV R7,[R9] ;R7 é o número de clientes na base de dados
    CMP R3,R7 ;compara-se o índice com o tamanho da base de dados
    JEQ ClienteNaoPresente ;se é igual, chegou-se ao fim da base de dados e efetua-se este salto
    MOV R2,Proximo ;se não é igual, mete-se em R2 o valor de Proximo para avançarmos para o próximo cliente a verificar
    ADD R8,R2 ;avanca a base para o próximo cliente a verificar
    JMP Ciclo_AlterarDados ;faz o salto para o ciclo para verificarmos este próximo cliente
ClienteNaoPresente: ;esta parte da rotina indica ao utilizador que os dados (ID e código de segurança) que inseriu não coincidem com os dados de nenhum cliente na base de dados
    MOV R9, Display_ClienteNaoEstaNaDatabase ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP AlterarOuNao ;salta-se para o ínicio da função
AlterarDadosCliente: ;chega-se aqui se encontrou-se na base de dados o cliente ao qual o utilizador pretende alterar os dados
    MOV R5, InputID ;mete em R5 o endereço de onde se lê o novo ID do cliente ao qual alterarermos os dados
    MOV R6, InputCodSeguranca ;mete em R6 o endereço de onde se lê o novo código de segurança do cliente ao qual alterarermos os dados
    MOV R7, InputSaldo ;mete em R7 o endereço de onde se lê o novo saldo do cliente ao qual alterarermos os dados
    MOV R4, InputBateria ;mete em R7 o endereço de onde se lê quanta bateria o carro do cliente terá agora que iremos alterar os seus dados
    MOV R9, Display_InserirDadosParaAlterar ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R0,[R5] ;mete em R0 o novo valor do ID do cliente, que o utilizador meteu
    MOV R1,[R6] ;mete em R1 o novo valor do código de segurança do cliente, que o utilizador meteu
    MOV R2,[R7] ;mete em R2 o novo valor do saldo do cliente, que o utilizador meteu
    MOV R3,[R4] ;mete em R3 o novo valor da bateria do carro do cliente, que o utilizador meteu
    CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
    CMP R2,0 ;compara o valor do saldo com zero
    JLT SaldoInvalido ;se o saldo que o utilizador inseriu para o novo cliente for negativo, efetua-se este salto e o novo cliente não é criado
    CMP R3,0 ;compara o valor da bateria do carro com zero
    JLT BateriaInvalida ;se o valor da bateria do carro for negativo, efetua-se este salto e o novo cliente não é criado
    MOV R7,100 ;mete em R7 o valor 100 para fins de comparação
    CMP R3,R7 ;compara o valor da bateria do carro com R7, que é 100
    JGT BateriaInvalida ;se o valor da bateria do carro for maior que 100, efetua-se este salto e o novo cliente não é criado
    MOV R8,Base_Tabela_Dados ;mete em R8 o início da base de dados
    ADD R8,R10 ;acrescenta ao início da base de dados o R10 que foi definido anteriormente como sendo o incremento a adicionar ao início da base de dados para chegarmos aos dados do cliente pretendido pelo utilizador
    MOV R5,CodSeguranca ;mete em R5 o incremento relativo ao inicio dos dados de um cliente de onde se lê o código de segurança dele
    MOV R6,Saldo ;mete em R6 o incremento relativo ao inicio dos dados de um cliente de onde se lê o saldo dele
    MOV R7,BateriaCarro ;mete em R7 o incremento relativo ao inicio dos dados de um cliente de onde se lê o valor da bateria do carro dele
    MOV [R8],R0 ;atualizar o ID do cliente com o ID que o utilizador inseriu
    MOV [R8+R5],R1 ;atualizar o código de segurança do cliente com o código de segurança que o utilizador inseriu
    MOV [R8+R6],R2 ;atualizar o saldo do cliente com o saldo do cliente que o utilizador inseriu
    MOV [R8+R7],R3 ;atualizar o valor da bateria do carro do cliente com o valor que o utilizador inseriu
    MOV R9,Display_DadosAlterados ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP AlterarOuNao ;Voltar ao início da rotina
SaldoInvalido: ;a rotina chega aqui se o valor que o utilizador inseriu como possível saldo é inválido (valor negativo)
    MOV R9, Display_SaldoInvalido ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP AlterarOuNao ;volta ao início da rotina
BateriaInvalida: ;a rotina chega aqui se o valor que o utilizador inseriu como possível valor da bateria do carro é inválido (valor negativo ou superior a 100)
    MOV R9, Display_BateriaInvalida ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP AlterarOuNao ;volta ao início da rotina
FimFunc4: ;Fim da rotina, chega aqui se o utilizador já não pretende fazer alterações à base de dados
    POP R8 ;*********************************************************************************************************************
    POP R7 ;
    POP R6 ;
    POP R5 ;
    POP R4 ; Retira da pilha os registos guardados no início da rotina
    POP R3 ;
    POP R2 ;
    POP R1 ;
    POP R0 ;*********************************************************************************************************************
    RET

;***********************************************************************************************************************************
;                                   ROTINA InsereEnergia
;                   Responsável por recarregar as baterias dos postos, se o utilizador assim desejar
;***********************************************************************************************************************************

InsereEnergia:
    PUSH R0 ;*********************************************************************************************************************
    PUSH R1 ;
    PUSH R2 ;
    PUSH R3 ;
    PUSH R4 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R5 ;
    PUSH R6 ;
    PUSH R7 ;
    PUSH R8 ;*********************************************************************************************************************
InicioInsereEnergia:
    MOV R6, InputOpcao ;R6 contém o endereço de onde se lê o input de qual bateria carregar
    MOV R9, Display_InsereEnergia ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOVB R4, [R6]  ;R4 contém a seleção de qual bateria carregar, por parte do utilizador
	CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
    MOV R6, EnderecoBateriaNormal ;mete em R6 o endereço onde está guardado o valor da bateria do posto normal
    MOV R7, EnderecoBateriaSemiRapido ;mete em R7 o endereço onde está guardado o valor da bateria do posto semirapido
    MOV R8, EnderecoBateriaRapido ;mete em R8 o endereço onde está guardado o valor da bateria do posto rapido
    MOV R0,[R6] ;guarda em R0 o valor da bateria do posto normal presente na memória
    MOV R1, [R7] ;guarda em R1 o valor da bateria do posto semirapido presente na memória
    MOV R2,[R8] ;guarda em R2 o valor da bateria do posto rapido presente na memória
    MOV R6,R0 ;guarda em R6 o valor original da bateria do posto normal, caso o utilizador carregue a bateria com um valor inválido
    MOV R7,R1 ;guarda em R7 o valor original da bateria do posto semirapido, caso o utilizador carregue a bateria com um valor inválido
    MOV R8,R2 ;guarda em R8 o valor original da bateria do posto rapido, caso o utilizador carregue a bateria com um valor inválido
    MOV R5,4 ;mete em R5 o valor da opção de avançar, que é 4
    CMP R4,R5 ;compara a opção escolhida pelo utilizador com o valor em R5 (4)
    JNE IncrementaNormal ;se não são iguais, o utilizador ou pretende carregar uma das baterias ou inseriu uma opção inválida, efetua-se o salto para verificar posteriormente
    JMP FimFunc1 ;se são iguais, salta-se para o fim da função
IncrementaNormal:
    MOV R5, CustoNormal ;mete em R5 o valor de opção correspondente a carregar a bateria do posto Normal, que coincide com o custo do carregamento (1)
    CMP R4, R5 ;compara a opção escolhida pelo utilizador com o valor em R5 (1)
    JNE IncrementaSemiRapido ;se verificar-se que a bateria escolhida não é a normal, procede-se para a verificação das outras baterias
	MOV R9, Display_InsereEnergiaQuanta ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R5, InputIncrementoBateria ;R5 contém o endereço de onde se lê o input de quanto carregar a bateria
    MOV R3, [R5] ;R3 contém o valor a adicionar à bateria selecionada, se possivel
	CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
    CMP R3,0 ;compara o valor que o utilizador inseriu com 0
    JLT IncrementaBateriaInvalido ;se o valor que o utilizador inseriu é negativo (menor que 0), efetua-se este salto pois o utilizador não pode tirar bateria aqui, só adicionar
    ADD R0, R3 ;adicionamos a R0 (bateria normal) o valor que o utilizador inseriu
    CMP R0, 0 ;comparamos o valor da bateria após a adição com 0, para verificar se ocorreu overflow
    JLT OverflowBateria ;se ocorrer overflow efetuar este salto para informar o utilizador
    JMP AtualizaPostos ;se não ocorrer overflow, atualizamos os valores dos postos em memória
IncrementaSemiRapido:
    MOV R5,CustoSemiRapido ;mete em R5 o valor de opção correspondente a carregar a bateria do posto Semirapido, que coincide com o custo do carregamento (2)
    CMP R4,R5 ;compara a opção escolhida pelo utilizador com o valor em R5 (2)
    JNE IncrementaRapido ;se verificar-se que a bateria escolhida não é a semirapida, procede-se para a verificação das outras baterias
	MOV R9, Display_InsereEnergiaQuanta ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R5, InputIncrementoBateria ;R5 contém o endereço de onde se lê o input de quanto carregar a bateria
    MOV R3, [R5] ;R3 contém o valor a adicionar à bateria selecionada, se possivel
	CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
    CMP R3,0 ;compara o valor que o utilizador inseriu com 0
    JLT IncrementaBateriaInvalido ;se o valor que o utilizador inseriu é negativo (menor que 0), efetua-se este salto pois o utilizador não pode tirar bateria aqui, só adicionar
    ADD R1,R3 ;adicionamos a R1 (bateria semirapido) o valor que o utilizador inseriu
    CMP R1,0 ;comparamos o valor da bateria após a adição com 0, para verificar se ocorreu overflow
    JLT OverflowBateria ;se ocorrer overflow efetuar este salto para informar o utilizador
    JMP AtualizaPostos ;se não ocorrer overflow, atualizamos os valores dos postos em memória
IncrementaRapido:
    MOV R5, CustoRapido ;mete em R5 o valor de opção correspondente a carregar a bateria do posto Rapido, que coincide com o custo do carregamento (3)
    CMP R4, R5 ;compara a opção escolhida pelo utilizador com o valor em R5 (3)
    JNE OpcaoInvalida ;se verificar-se que a bateria escolhida não é a rapida, então o utilizador inseriu uma opção inválida
	MOV R9, Display_InsereEnergiaQuanta ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R5, InputIncrementoBateria ;R5 contém o endereço de onde se lê o input de quanto carregar a bateria
    MOV R3, [R5] ;R3 contém o valor a adicionar à bateria selecionada, se possivel
	CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
    CMP R3,0 ;compara o valor que o utilizador inseriu com 0
    JLT IncrementaBateriaInvalido ;se o valor que o utilizador inseriu é negativo (menor que 0), efetua-se este salto pois o utilizador não pode tirar bateria aqui, só adicionar
    ADD R2,R3 ;adicionamos a R2 (bateria rapido) o valor que o utilizador inseriu
    CMP R2,0 ;comparamos o valor da bateria após a adição com 0, para verificar se ocorreu overflow
    JLT OverflowBateria ;se ocorrer overflow efetuar este salto para informar o utilizador
    JMP AtualizaPostos ;se não ocorrer overflow, atualizamos os valores dos postos em memória
OverflowBateria: ;se ocorreu overflow, faz-se reset dos valores das baterias com os valores guardados no início da rotina
	MOV R0,R6 ;reset do valor da bateria do posto normal
    MOV R1,R7 ;reset do valor da bateria do posto semirapido
    MOV R2,R8 ;reset do valor da bateria do posto rapido
    MOV R9, Display_Overflow ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP FimFunc1
    JMP InicioInsereEnergia ;volta ao início da rotina
IncrementaBateriaInvalido: ;a rotina chega aqui se o utilizador quer tirar em vez de carregar bateria a um posto
    MOV R9,Display_IncrementaBateriaInvalido ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP InicioInsereEnergia ;volta ao início da rotina
OpcaoInvalida:
    MOV R9,Display_OpcaoInvalida ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
	CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
    JMP InicioInsereEnergia ;voltar ao início da rotina
AtualizaPostos:
    MOV R9, Display_BateriaCarregada ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R6, EnderecoBateriaNormal ;mete em R6 o endereço onde está guardado o valor da bateria do posto normal
    MOV R7, EnderecoBateriaSemiRapido ;mete em R7 o endereço onde está guardado o valor da bateria do posto semirapido
    MOV R8, EnderecoBateriaRapido ;mete em R8 o endereço onde está guardado o valor da bateria do posto rapido
    MOV [R6], R0 ;atualiza o valor da bateria do posto normal guardado em memória
    MOV [R7], R1 ;atualiza o valor da bateria do posto semirapido guardado em memória
    MOV [R8], R2 ;atualiza o valor da bateria do posto rapido guardado em memória
    JMP InicioInsereEnergia
FimFunc1:
    POP R8 ;*********************************************************************************************************************
    POP R7 ;
    POP R6 ;
    POP R5 ;
    POP R4 ; Retira da pilha os registos guardados no início da rotina
    POP R3 ;
    POP R2 ;
    POP R1 ;
    POP R0 ;*********************************************************************************************************************
    RET

;**********************************************************************************************************************************************
;                       ROTINA NiveisDeEnergia
;           Responsável por mostrar ao utilizador quais dos postos estão funcionais ou não funcionais
;**********************************************************************************************************************************************
NiveisDeEnergia:
    PUSH R0 ;*********************************************************************************************************************
    PUSH R1 ;
    PUSH R2 ;
    PUSH R3 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R4 ;
    PUSH R5 ;
    PUSH R6 ;
    PUSH R7 ;*********************************************************************************************************************
	MOV R10,0
    MOV R3, EnderecoBateriaNormal ;mete em R3 o endereço onde está guardado o valor da bateria do posto normal
    MOV R4, EnderecoBateriaSemiRapido ;mete em R4 o endereço onde está guardado o valor da bateria do posto semirapido
    MOV R5, EnderecoBateriaRapido ;mete em R5 o endereço onde está guardado o valor da bateria do posto rapido
    MOV R0,[R3] ;guarda em R0 o valor da bateria do posto normal presente na memória
    MOV R1, [R4] ;guarda em R1 o valor da bateria do posto semirapido presente na memória
    MOV R2,[R5] ;guarda em R2 o valor da bateria do posto rapido presente na memória
    MOV R3,0 ;R3 contará quantas bateria estiverem abaixo do nivel mínimo
    MOV R4,Normal ;R7 contém o nivel mínimo que a bateria normal deve ter para ser considerada funcional (carregamento de uma hora)
    MOV R5,Semirapido ;R8 contém o nivel mínimo que a bateria semirapida deve ter para ser considerada funcional (carregamento de uma hora)
    MOV R6,Rapido ;R9 contém o nivel mínimo que a bateria rapida deve ter para ser considerada funcional (carregamento de uma hora)
    CMP R0,R4 ;compara o valor da bateria do posto normal com o seu valor mínimo
    JGE VerificaSemiRapido ;se verificarmos que a bateria normal tem o nivel mínimo, verificamos as restantes
    ADD R3,1 ;caso contrario, adicionamos 1 ao contador e verifica-se a bateria semirapida
VerificaSemiRapido:
    CMP R1,R5 ;compara o valor da bateria do posto semirapido com o seu valor mínimo
    JGE VerificaRapido ;se verificarmos que a bateria semirapida tem o nivel mínimo, verificamos a bateria rapida
    ADD R3,1 ;caso contrario, adicionamos 1 ao contador e verifica-se a bateria rapida
VerificaRapido:
    CMP R2, R6 ;compara o valor da bateria do posto rapido com o seu valor mínimo
    JGE FimFunc ;se verificarmos que a bateria rapida tem o nivel mínimo, o posto esta operacional e salta-se para o fim da rotina
    ADD R3,1 ;caso contrário, adicionamos 1 ao contador
    CMP R3,3 ;compara-se o valor do contador com 3 (o número de baterias)
    JNE FimFunc ;se o contador não é igual a 3, o posto está operacional e salta-se para o fim da função
    MOV R10,-1 ;caso contrário, mete-se o R10 a -1 para o programa não avançar para a verificação do utilizador
FimFunc:
    MOV R9,Display_NiveisDeEnergia ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    CALL Display_NiveisDeEnergia_InserirInformacao ;chama a rotina que insere a informação sobre os estados dos postos no display
    POP R7 ;*********************************************************************************************************************
    POP R6 ;
    POP R5 ;
    POP R4 ; Retira da pilha os registos guardados no início da rotina
    POP R3 ;
    POP R2 ;
    POP R1 ;
    POP R0 ;*********************************************************************************************************************
    RET

;*************************************************************************************************************************************************
;                                       ROTINA Verificacao_Cliente
;                       Responsável por receber o ID e código de segurança do utilizador e compará-los
;                       com os valores presentes na base de dados para ver se pode efetuar um carregamento
;*************************************************************************************************************************************************
Verificacao_Cliente:
    PUSH R0 ;*********************************************************************************************************************
    PUSH R1 ;
    PUSH R2 ;
    PUSH R3 ;
    PUSH R4 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R5 ;
    PUSH R6 ;
    PUSH R7 ;
    PUSH R8 ;*********************************************************************************************************************
    MOV R3, InputID ;R3 é o endereço de onde se lê o ID do utilizador
    MOV R4, InputCodSeguranca ;R4 é o endereço de onde se lê o código de segurança do utilizador
    MOV R9, Display_InputVerifyCliente ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R5, [R3] ;R5 é o ID que o utilizador inseriu
    MOV R6, [R4] ;R6 é o código de segurança que o utilizador inseriu
	CALLF LimpaPerifericosEntrada ;limpa os endereços de onde se lê os inputs do utilizador
    MOV R0, Base_Tabela_Dados ;mover para R0 a base da tabela de dados, será a base dos dados do cliente que estamos a verificar e contém o ID deste
    MOV R1, 0 ;R1 será o índice
    MOV R2, CodSeguranca ;R2 será a posição na tabela onde está o código de segurança do cliente
Ciclo_Verify_Cliente:
    MOV R10,-1 ;mete-se em R10 o valor -1 para indicar, se chega-se ao fim da base de dados sem o utilizador ser verificado, que o utilizador não pode proceder para carregar o carro
    MOV R9,EnderecoTamanho ;mete-se no registo 9 o endereço de onde ler o tamanho da base de dados
    MOV R8,[R9] ;R8 é o número de clientes na base de dados (tamanho desta)
    CMP R1,R8  ;compara-se o índice com o tamanho da base de dados
    JEQ NaoVerificado ;se o índice é igual ao tamanho, chegou-se ao fim da base de dados sem o utilizador ser verificado
    MOV R3, [R0] ;R3 tem o valor do ID da tabela de base de dados a verificar
    MOV R4, [R0+R2] ;R4 tem o valor de código de segurança da tabela de base de dados a verificar
    CMP R5,R3  ;compara-se o ID inserido pelo utilizador com o ID da base de dados a verificar
    JNE VerificacaoFalhada ;se são diferentes avançar para o próximo, se possivel
    CMP R6,R4 ;compara-se o código de segurança inserido pelo utilizador com o código de segurança da tabela de base de dados a verificar
    JNE VerificacaoFalhada ;se são diferentes avançar para o próximo, se possivel
	MOV R10, Proximo ;caso contrário, mete-se em R10 o valor para passar aos dados de um próximo cliente
    MUL R10,R1 ;multiplica o valor de Proximo pelo índice, para se obter o início dos dados do cliente verificado relativamente ao início da base de dados
	MOV R9, Display_VerificacaoSucesso ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP FimFunc2 ;saltar para o fim da rotina pois o utilizador foi verificado com sucesso
VerificacaoFalhada: ;se os dados que o utilizador inseriu não coincidirem com os dados do cliente que estava a ser verificado efetua-se isto
    ADD R1,1 ;adiciona-se um ao índice
    MOV R3,Proximo ;caso contrário, mete-se em R3 o valor a acrescentar ao início dos dados do cliente não verificado para avançar para o próximo
    ADD R0,R3 ;avança a base para o proximo cliente a verificar
    JMP Ciclo_Verify_Cliente ;volta-se a verificar os dados do utilizador com o novo cliente a verificar
NaoVerificado: ;chega-se aqui se o utilizador não é verificado
    MOV R9, Display_VerificacaoFalhada ;Mete no registo 9 o endereço do display a mostrar ao utilizador
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
FimFunc2:
    POP R8 ;*********************************************************************************************************************
    POP R7 ;
    POP R6 ;
    POP R5 ;
    POP R4 ; Retira da pilha os registos guardados no início da rotina
    POP R3 ;
    POP R2 ;
    POP R1 ;
    POP R0 ;*********************************************************************************************************************
    RET
	
;***************************************************************************************************************************************************
;                           ROTINA Carregamento
;                   Responsável por efetuar o carregamento do carro do cliente previamente autorizado
;                   efetuando as verificações necessárias e atualizando os postos
;***************************************************************************************************************************************************
Carregamento: 
    PUSH R0 ;*********************************************************************************************************************
    PUSH R1 ;
    PUSH R2 ;
    PUSH R3 ;
    PUSH R4 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R5 ;
    PUSH R6 ;
    PUSH R7 ;
    PUSH R8 ;*********************************************************************************************************************
EscolhaCarregamento:														;VERIFICAR O TIPO DE CARREGAMENTO ESCOLHIDO PELO UTILIZADOR
    MOV R3, EnderecoBateriaNormal 											;mete em R3 o endereço onde está guardado o valor da bateria do posto normal
    MOV R4, EnderecoBateriaSemiRapido 										;mete em R4 o endereço onde está guardado o valor da bateria do posto semirapido
    MOV R5, EnderecoBateriaRapido 											;mete em R5 o endereço onde está guardado o valor da bateria do posto rapido
    MOV R0,[R3] 															;guarda em R0 o valor da bateria do posto normal, e aqui fica ao longo do programa
    MOV R1, [R4] 															;guarda em R1 o valor da bateria do posto semi-rapido, e aqui fica ao longo do programa
    MOV R2,[R5] 															;guarda em R2 o valor da bateria do posto rapido, e aqui fica ao longo do programa 
	MOV R6, CustoNormal														;coloca no registo 6 o valor do custo do carregamento do tipo normal
	MOV R7, CustoSemiRapido													;coloca no registo 7 o valor do custo do carregamento do tipo semi-rápido
	MOV R8, CustoRapido														;coloca no registo 8 o valor do custo do carregamento do tipo rápido
	MOV R9, Display_EscolheCarregamento 									;mete no registo 9, onde está o endereço do display que pretendemos mostrar (Display_EscolheCarregamento)
    MOV R5, InputOpcao 											            ;coloca no registo 5 o endereço de onde ler o tipo de carregamento
    CALL RefreshDisplay 													;mostra ao utilizador o display  metido anteriormente em R9 
	MOVB R3, [R5]					                						;coloca no registo 3 o tipo de carregamento escolhido pelo utilizador
	CALLF LimpaPerifericosEntrada                                            ;limpa os endereços de onde se lê os inputs do utilizador
	CMP R3, R6																;compara o registo 3 com o registo 6
	JEQ EscolhaTempo														;se o valor do registo 3 for igual ao valor do registo 6, salta para o tag "EscolhaTempo" - ou seja, escolheu o carregamento normal
	CMP R3, R7																;compara o registo 3 com o registo 7
	JEQ EscolhaTempo														;se o valor do registo 3 for igual ao valor do registo 7, salta para o tag "EscolhaTempo" - ou seja, escolheu o carregamento semi-rapido
	CMP R3, R8																;compara o registo 3 com o registo 8
	JEQ EscolhaTempo														;se o valor do registo 3 for igual ao valor do registo 8, salta para o tag "EscolhaTempo" - ou seja, escolheu o carregamento rapido
	MOV R9, Display_OpcaoInvalida 											;mete no registo 9, onde está o endereço do display que pretendemos mostrar (Display_OpcaoInvalida) ********************************************************													
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 										* ACONTECE SE FOR INSERIDO UM VALOR DIFERENTE DE 1,2,3 *
	JMP EscolhaCarregamento													;volta para o Display_ inicial (volta a escolher o tipo carregamento)								********************************************************

EscolhaTempo: 																;VERIFICAR O TEMPO ESCOLHIDO PELO UTILIZADOR
	MOV R9, Display_EscolherTempo 											;mete no registo 9, onde está o endereço do display que pretendemos mostrar
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 
    MOV R5, InputTempo   													;coloca no registo 5 o endereço de onde ler quanto tempo carregar
	MOV R4, [R5]															;coloca no registo 4 o tempo escolhido pelo utilizador
	CALLF LimpaPerifericosEntrada                                            ;limpa os endereços de onde se lê os inputs do utilizador
	CMP R3,R6																;compara o registo 3 com o registo 6
	JNE VerificaEscolhaTempoSuperiorSemiRapido								;se o valor do registo 3 for diferente do valor do registo 6, salta para o tag "VerificaEscolhaTempoSuperiorSemiRapido" - ou seja, é verificado se o tipo de carregamento não é normal
	MOV R5, R4																;coloca no registo 5 o valor do registo 4 (o tempo escolhido)
	MOV R9, Normal															;coloca no registo 9 o valor de energia de um carregamento Normal/hora
	MUL R5, R9																;é multiplicado o valor do registo 5 com o valor do registo 9 --> registo 5 com a energia total do carregamento (com o valor do tempo inserido pelo utilizador)
	CMP R5, R0																;compara o valor do registo 5 com o valor do registo 0 (valor da bateria Normal do posto)
	JGT SemBateriaParaCarregamento											;se o valor do registo 5 é superior ao valor do registo 0, salta para o tag "SemBateriaParaCarregamento" - as opções escolhidas pelo utilizador irão descarregar a bateria do posto
	JMP FimVerificacoes														;se for inferior ou igual, salta para o tag "FimVerificacoes"

VerificaEscolhaTempoSuperiorSemiRapido:
	CMP R3, R7																;compara o valor do registo 3 com o valor do registo 7
	JNE VerificaEscolhaTempoSuperiorRapido									;se o valor do registo 3 não for igual ao valor do registo 7, salta para o tag "VerificaEscolhaTempoSuperiorRapido" - ou seja, é verificado se o tipo de carregamento não é semi-rapido
	MOV R5, R4																;coloca no registo 5 o valor do registo 4 (o tempo escolhido)
	MOV R9, Semirapido														;coloca no registo 9 o valor da energia de um carregamento SemiRapido/hora
	MUL R5, R9																;é multiplicado o valor do registo 5 com o valor do registo 9 --> registo 5 com a energia total do carregamento
	CMP R5, R1																;compara o valor do registo 5 com o valor do registo 1 (valor da bateria Semi-Rapida do posto)
	JGT SemBateriaParaCarregamento											;se o valor do registo 5 é superior ao valor do registo 1, salta para o tag "SemBateriaParaCarregamento" - as opções escolhidas pelo utilizador irão descarregar a bateria do posto
	JMP FimVerificacoes														;se for inferior ou igual, salta para o tag "FimVerificacoes"

VerificaEscolhaTempoSuperiorRapido:	
	MOV R5, R4																;coloca no registo 5 o valor do registo 4 (o tempo escolhido)
	MOV R9, Rapido															;coloca no registo 9 o valor da energia de um carregamento Rapido/hora
	MUL R5, R9																;é multiplicado o valor do registo 5 com o valor do registo 9 --> registo 5 com a energia total do carregamento
	CMP R5, R2																;compara o valor do registo 5 com o valor do registo 2 (valor da bateria Rapida do posto)
	JGT SemBateriaParaCarregamento											;se o valor do registo 5 é superior ao valor do registo 1, salta para o tag "SemBateriaParaCarregamento" - as opções escolhidas pelo utilizador irão descarregar a bateria do posto
	
FimVerificacoes:
	CMP R4, 0																;compara o valor do registo 4 com a constante 0
	JGT VerificaSaldo														;se o valor do registo 4 for superior a 0, ou seja, o tempo for superior a 0, salta para o tag "VerificaSaldo"
	MOV R9, Display_TempoInvalido 											;mete no registo 9, onde está o endereço do display que pretendemos mostrar (Display_TempoInvalido)
    CALL RefreshDisplay 													;mostra o display metido anteriormente em R9 ao utilizador
    JMP EscolhaTempo														;salta para o tag "EscolhaTempo" --> tempo inválido


SemBateriaParaCarregamento:
	MOV R9, Display_TempoUltrapassa 										;mete no registo 9, onde está o endereço do display que pretendemos mostrar
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 
	JMP FimFunc3															;salta para o tag "FimFunc3"

VerificaSaldo:																;VERIFICAR SE O UTILIZADOR TEM SALDO SUFICIENTE PARA EFETUAR O CARREGAMENTO
    MOV R7,R4																;coloca no registo 7 o valor do registo 4 (o tempo escolhido pelo utilizador)
	MUL R4, R3																;é multiplicado o valor do registo 4 com o valor do registo 3, ou seja, o tempo pelo custo/hora do carregamento --> registo 4 com o valor do custo do carregamento
    MOV R5, Base_Tabela_Dados												;é colocado no registo 5 o valor o endereço do inicio da base de dados
    ADD R5,R10																;é adicionado ao registo 5 o valor do registo 10, ou seja, o indice do cliente 
    MOV R6,[R5+Saldo]														;é colocado no registo 6, o valor do saldo do cliente
	CMP R4, R6																;é comparado o valor do registo 4 com o valor do registo 6, ou seja, o custo do carregamento com o saldo do utilizador
	JLE ForneceEnergia 														;se o valor do registo 4 (o custo) for inferior ou igual ao do registo 6 (saldo), salta para o tag "ForneceEnergia", ou seja, o utilizador tem saldo suficiente
	MOV R9, Display_SaldoInsuficiente										;mete no registo 9, onde está o endereço do que pretendemos mostrar (Display_SaldoInsuficiente)		*****************************************************
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 										* ACONTECE SE O UTILIZADOR NÃO TEM SALDO SUFICIENTE *
	JMP NaoForneceEnergia													;salta para o tag "NãoForneceEnergia" 															*****************************************************
	
	
ForneceEnergia:																;VERIFICA O TIPO DE CARREGAMENTO A SER FORNECIDO
	MOV R9, Display_InfoCarregamento 										;mete no registo 9, onde está o endereço do display que pretendemos mostrar
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 
    MOV R4,R7																;coloca no registo 4 o valor do registo 7 (o tempo escolhido pelo utilizador)
	MOV R9,R7																;coloca no registo 4 o valor do registo 7 (o tempo escolhido pelo utilizador)
	MOV R6, CustoNormal 													;coloca no registo 6 o custo/hora do carregamento normal
	MOV R7, CustoSemiRapido 												;coloca no registo 7 o custo/hora do carregamento semi-rapido
	MOV R8, CustoRapido 													;coloca no registo 8 o custo/hora do carregamento rapido
	CMP R3, R6																;compara o valor do registo 3 (tipo de carregamento escolhido) com o valor do registo 6 (custo do carregamento Normal)									
	JEQ	ForneceEnergiaNormal												;se o valor do registo 3 for igual ao do registo 6, salta para o tag "ForneceEnergiaNormal" - ou seja, o carregamento escolhido é o normal
	CMP R3, R7																;compara o valor do registo 3 (tipo de carregamento escolhido) com o valor do registo 7 (custo do carregamento Semi-Rapido)	
	JEQ	ForneceEnergiaSemiRapido 											;se o valor do registo 3 for igual ao do registo 7, salta para o tag "ForneceEnergiaSemiRapido" - ou seja, o carregamento escolhido é o semi-rapido
	CMP R3,	R8																;compara o valor do registo 3 (tipo de carregamento escolhido) com o valor do registo 8 (custo do carregamento Rapido)	
	JEQ ForneceEnergiaRapido												;se o valor do registo 3 for igual ao do registo 8, salta para o tag "ForneceEnergiaRapido" - ou seja, o carregamento escolhido é o rapido


ForneceEnergiaNormal:														;FORNECE ENERGIA DO TIPO NORMAL
    MOV R5, Base_Tabela_Dados												;é colocado no registo 5 o valor o endereço do inicio da base de dados
    ADD R5,R10																;é adicionado ao registo 5 o valor do registo 10, ou seja, o indice do cliente
	MOV R6, [R5+BateriaCarro] 												;é colocado no registo 6, o valor da bateria do vehiculo do cliente
	MOV R7, Normal 															;coloca no registo 7 o valor de energia de um carregamento Normal/hora
	ADD R6, R7 																;é adicionado à bateria do vehiculo, o valor da energia do carregamento (20)
	MOV R8, 100 															;coloca no registo 8 a constante 100
	SUB R4,1 																;subtrai 1 ao registo 4 (ao tempo)
	CMP R6, R8 																;compara o valor do registo 6 com o valor do registo 8, ou seja, a bateria do vehiculo com a constante 100
	JGT BateriaCarregada 													;se o valor do registo 6 for superior ou igual a 100, salta para o tag "BateriaCarregada"
	MOV [R5+BateriaCarro], R6 												;atualiza o valor da bateria do vehiculo do cliente														
	CMP R4,0 																;compara o valor do registo 4 com a constante 0, ou seja, se o tempo chegou a 0
	JEQ AtualizaValoresEnergia 												;se o valor do registo 4 for 0, salta para o tag AtualizaValoresEnergia"
    JMP ForneceEnergiaNormal 												;salta para o "tag" ForneceEnergiaNormal"
	

ForneceEnergiaSemiRapido:													;FORNECE ENERGIA DO TIPO SEMIRAPIDO
    MOV R5, Base_Tabela_Dados												;é colocado no registo 5 o valor o endereço do inicio da base de dados
    ADD R5,R10																;é adicionado ao registo 5 o valor do registo 10, ou seja, o indice do cliente
	MOV R6, [R5+BateriaCarro] 												;é colocado no registo 6, o valor da bateria do vehiculo do cliente
	MOV R7, Semirapido 														;coloca no registo 7 o valor de energia de um carregamento Semi-Rapido/hora
	ADD R6, R7 																;é adicionado à bateria do vehiculo, o valor da energia do carregamento (60)
	MOV R8, 100 															;coloca no registo 8 a constante 100
	SUB R4,1 																;subtrai 1 ao registo 4 (ao tempo)
	CMP R6, R8 																;compara o valor do registo 6 com o valor do registo 8, ou seja, a bateria do vehiculo com a constante 100
	JGT BateriaCarregada 													;se o valor do registo 0 for superior ou igual a 100, salta para o tag "BateriaCarregada"
	MOV [R5+BateriaCarro], R6 												;atualiza o valor da bateria do vehiculo do cliente	
	CMP R4,0 																;compara o valor do registo 4 com a constante 0, ou seja, se o tempo chegou a 0
	JEQ AtualizaValoresEnergia 												;se o valor do registo 4 for 0, salta para o tag AtualizaValoresEnergia"
    JMP ForneceEnergiaSemiRapido 											;salta para o "tag" ForneceEnergiaSemiRapido"

ForneceEnergiaRapido:														;FORNECE ENERGIA DO TIPO RAPIDO
	MOV R9,1																;coloca no registo 9 a constante 1
	MOV R4,0																;coloca no registo 4 a constante 0

BateriaCarregada:															;QUANDO A BATERIA DO VEHICULO ULTRAPASSA OS 100%
	MOV R6, 100 															;coloca no registo 6 a constante 100
	MOV [R5+BateriaCarro], R6 												;atualiza o valor da bateria do vehiculo do cliente (coloca a 100)
	JMP AtualizaValoresEnergia 												;salta para o tag "AtualizaValoresEnergia"
	
NaoForneceEnergia:															;NÃO É FORNECIDA ENERGIA
    JMP FimFunc3															;salta para o tag "FimFunc3"
	

AtualizaValoresEnergia:														;VERIFICA SE O TEMPO CHEGOU A 0 NO FIM DO CARREGAMENTO DA BATERIA
	MOV R7,R9																;coloca no registo 7 o valor do registo 9 (o tempo escolhido pelo utilizador)
	CMP R4,0																;compara o valor do registo 4 com a constante 0
	JEQ Excedeu																;se o valor do registo 4 for 0, salta para o tag "Excedeu"
	JMP NaoExcedeu 															;caso contrário, salta para o tag "NaoExcedeu"

	
Excedeu:																	;SE O TEMPO CHEGOU A 0 NO FIM DO CARREGAMENTO DA BATERIA
	MOV R9, Display_UltrapassaCargaMaxima 									;mete no registo 9, onde está o endereço do display que pretendemos mostrar (Display_UltrapassaCargaMaxima)
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 

NaoExcedeu:																	;SE O TEMPO NÃO CHEGOU A 0 NO FIM DO CARREGAMENTO DA BATERIA (não foi necessário o tempo todo inserido pelo utilizador)
	SUB R7, R4																;é subtraido ao registo 7 (o tempo inserido) o valor do registo 4 (o valor do tempo que sobrou)
	MOV R4, R7																;é colocado no registo 4 o valor do tempo que foi necessario para o carregamento da bateria
	MUL R7,R3																;é multiplicado o valor do registo 7 com o valor do registo 3, ou seja, o valor do tempo necessario com o valor do custo do tipo de carregamento escolhido -> registo 7 com o valor do custo do carregamento
	CALL Debito																;é feito o pagamento do carregamento
	MOV R6, CustoNormal 													;coloca no registo 6 o custo/hora do carregamento normal
	MOV R7, CustoSemiRapido 												;coloca no registo 7 o custo/hora do carregamento semi-rapido
	MOV R8, CustoRapido 													;coloca no registo 8 o custo/hora do carregamento rapido
	CMP R3, R6																;compara o valor do registo 3 com o valor do registo 6									
	JEQ	AtualizaPostoNormal													;se o valor do registo 3 for igual ao do registo 6, salta para o tag "AtualizaPostoNormal" -> o carregamento foi Normal
	CMP R3, R7																;compara o valor do registo 3 com o valor do registo 7	
	JEQ	AtualizaPostoSemiRapido 											;se o valor do registo 3 for igual ao do registo 7, salta para o tag "AtualizaPostoSemiRapido" -> o carregamento foi Semi-Rapido
	CMP R3,	R8																;compara o valor do registo 3 com o valor do registo 8
	JEQ AtualizaPostoRapido													;se o valor do registo 3 for igual ao do registo 7, salta para o tag "AtualizaPostoRapido" -> o carregamento foi Rapido


Debito:																		;REALIZA O PAGAMENTO DO CARREGAMENTO
	MOV R6, [R5+Saldo]														;coloca no registo 6 o valor do saldo do cliente
	SUB R6, R7																;subtrai ao registo 6 o valor do registo 7 (o custo do carregamento)
	MOV [R5+Saldo],R6 														;atualiza o saldo do utilizador 
	MOV R9, Display_Debito 														;mete no registo 9, onde está o endereço do display que pretendemos mostrar
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 
	RET	

AtualizaPostoNormal:														;ATUALIZA O VALOR DA BATERIA DO POSTO NORMAL
	MOV R6, Normal 															;coloca no registo 6 o valor da energia de um carregamento Normal/hora (20)
	MUL R6, R4 																;é multiplicado o registo 6 (a energia do carregamento) com valor do registo 4 (o valor do tempo que foi necessario para o carregamento da bateria)
	SUB R0, R6 																;subtrai ao registo 0 (bateria Normal do posto) o valor do registo 6 (o valor da energia fornecida no carregamento)
	JMP CarregamentoConcluido												;salta para o tag "CarregamentoConcluido"
	
AtualizaPostoSemiRapido:													;ATUALIZA O VALOR DA BATERIA DO POSTO SEMI-RAPIDO
	MOV R6, Semirapido														;coloca no registo 6 o valor da energia de um carregamento Semi-Rapido/hora (60)
	MUL R6, R4 																;é multiplicado o registo 6 (a energia do carregamento) com valor do registo 4 (o valor do tempo que foi necessario para o carregamento da bateria)
	SUB R1, R6  															;subtrai ao registo 1 (bateria Semi-Rapida do posto) o valor do registo 6 (o valor da energia fornecida no carregamento)
	JMP CarregamentoConcluido												;salta para o tag "CarregamentoConcluido"

AtualizaPostoRapido:														;ATUALIZA O VALOR DA BATERIA DO POSTO RAPIDO
	MOV R6, Rapido 															;coloca no registo 6 o valor da energia de um carregamento Rapido/hora (100)
	MUL R6, R4 																;é multiplicado o registo 6 (a energia do carregamento) com valor do registo 4 (o valor do tempo que foi necessario para o carregamento da bateria)
	SUB R2, R6  															;subtrai ao registo 2 (bateria Rapida do posto) o valor do registo 6 (o valor da energia fornecida no carregamento)
	
CarregamentoConcluido:														;ATUALIZA VALORES DAS BATERIAS DO POSTO (CARREGAMENTO CONCLUIDO)
	MOV R9, Display_CarregamentoConcluido 										;mete no registo 9, onde está o endereço do display que pretendemos mostrar
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 
    MOV R6, EnderecoBateriaNormal 											;coloca no registo 6 o endereço onde está guardado o valor da bateria do posto normal
    MOV R7, EnderecoBateriaSemiRapido 										;coloca no registo 7 o endereço onde está guardado o valor da bateria do posto semi-rapido
    MOV R8, EnderecoBateriaRapido 											;coloca no registo 8 o endereço onde está guardado o valor da bateria do posto rapido
    MOV [R6], R0															;atualiza o valor da bateria do posto normal
    MOV [R7], R1															;atualiza o valor da bateria do posto semi-rapido
    MOV [R8], R2															;atualiza o valor da bateria do posto rapido
	
FimFunc3:
    POP R8 ;*********************************************************************************************************************
    POP R7 ;
    POP R6 ;
    POP R5 ;
    POP R4 ; Retira da pilha os registos guardados no início da rotina
    POP R3 ;
    POP R2 ;
    POP R1 ;
    POP R0 ;*********************************************************************************************************************
	RET
    
;******************************************************************************************************************************************
;                                       ROTINA VerificaOK
;                       Responsável por registar que o utilizador "carregou" no OK
;******************************************************************************************************************************************
VerificaOK:
    PUSH R0 ;*********************************************************************************************************************
    PUSH R1 ; Guarda na pilha os registos alterados durante esta rotina
            ;*********************************************************************************************************************
CicloVerOK:
    MOV R0, OK ;mete em R0 o endereço de onde ver se o utilizador "carregou" OK
    MOVB R1, [R0] ;mete em R1 o valor lido do endereço R0
    CMP R1,1
    JNE CicloVerOK ;só quando o utilizador mudar o valor para 1 é que se lê os inputs do utilizador
    MOV R1,0
    MOVB[R0],R1
    POP R1  ;*********************************************************************************************************************
    POP R0  ; Retira da pilha os registos guardados no início da rotina
            ;*********************************************************************************************************************
    RETF

;***************************************************************************************************************************************
;                                   ROTINA RefreshDisplay
;                       Responsável por atualizar o display que o utilizador vê consoante o 
;                       display a mostrar, indicado pelo registo R9
;***************************************************************************************************************************************
RefreshDisplay:
    PUSH R0 ;*********************************************************************************************************************
    PUSH R1 ;
    PUSH R2 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R3 ;*********************************************************************************************************************
    MOV R0,InicioDisplay ;mete em R0 o início do display
    MOV R1,FimDisplay ;mete em R1 o fim do display
Ciclo_RefreshDisplay:
    MOV R2,[R9] ;mete-se em R2 o conteúdo do display que queremos apresentar, indicado por R9
    MOV [R0],R2 ;mete-se no display mostrado ao utilizador o conteúdo de R2
    ADD R0,2 ;avança-se para a próxima palavra o display mostrado ao utilizador
    ADD R9,2 ;avança-se para a próxima palavra o display que pretendemos mostrar ao utilizador
    CMP R0,R1 ;compara-se R0, posição atual no display, com o fim do display (R1)
    JLE Ciclo_RefreshDisplay ;se ainda não chegámos ao fim (é menor ou igual) volta-se ao início do ciclo
    MOV R3, Display_NiveisDeEnergia ;mete-se em R3 o endereço do display dos niveis de energia
    MOV R0,InicioDisplay ;mete-se em R0 o início do display novamente
    SUB R1,R0 ;subtrai-se o fim do display pelo início, para termos o número total de bytes
    ADD R1,1 ;adicionamos 1 para chegarmos às 7 linhas de 16 bytes
    ADD R3,R1 ;adiciona-se a R3 (endereço do display dos niveis de energia) o valor de R1
    CMP R9,R3 ;compara-se o valor de R9 com R3 pois se o display que atualizamos (indicado por R9) é o display dos Niveis de Energia, ainda há informação a ser escrita no display
    JEQ FimRefreshDiplay ;por isso, se R9 é igual a R3, efetua-se este salto para não se chamar o VerificaOK pois falta escrever no display os estados dos postos
	CALLF VerificaOK ;regista se o utilizador quer procedir
FimRefreshDiplay:
    POP R3 ;*********************************************************************************************************************
    POP R2 ;
    POP R1 ; Retira da pilha os registos guardados no início da rotina
    POP R0 ;*********************************************************************************************************************
    RET

;******************************************************************************************************************************************
;                               ROTINA LimpaPerifericosEntrada
;                       Esta rotina, como o nome indica, "limpa" os endereços de onde se lê
;                       os dados que o utilizador insira
;******************************************************************************************************************************************
LimpaPerifericosEntrada:
    PUSH R0 ;*********************************************************************************************************************
    PUSH R1 ;
    PUSH R2 ;
    PUSH R3 ;
    PUSH R4 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R5 ;
    PUSH R6 ;
    PUSH R7 ;*********************************************************************************************************************
    MOV R0, InputCodSeguranca       ;*************************************************************************************
    MOV R1, InputID                 ;
    MOV R2, InputIncrementoBateria  ;
    MOV R3, InputTempo              ; Endereços dos periféricos a "limpar" (por a 0)
    MOV R4, InputOpcao              ;
    MOV R5, InputSaldo              ;
    MOV R6, InputBateria            ;*************************************************************************************
    MOV R7, 0                       ;mete-se no registo 7 o 0 para limpar os periféricos
    MOV [R0],R7                     ;*************************************************************************************
    MOV [R1],R7                     ;
    MOV [R2],R7                     ;
    MOV [R3],R7                     ; Limpeza dos periféricos de entrada
    MOV [R4],R7                     ;
    MOV [R5],R7                     ;
    MOV [R6],R7                     ;*************************************************************************************
    POP R7 ;*********************************************************************************************************************
    POP R6 ;
    POP R5 ;
    POP R4 ; Retira da pilha os registos guardados no início da rotina
    POP R3 ;
    POP R2 ;
    POP R1 ;
    POP R0 ;*********************************************************************************************************************
    RETF
    
;**********************************************************************************************************************************
;                                       ROTINA LimpaDisplay
;                       Como o nome indica, "limpa" o display mostrado ao utilizador,
;                       preenchendo-o com espaços
;**********************************************************************************************************************************
LimpaDisplay:
    PUSH R0 ;*********************************************************************************************************************
    PUSH R1 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R2 ;*********************************************************************************************************************
    MOV R0,InicioDisplay ;mete-se em R0 o início do display
    MOV R1,FimDisplay ;mete-se em R1 o fim do display
    MOV R2,20 ;mete-se em R2 um caratér vazio (valor em código ASCII de 20)
Ciclo_LimpaDisplay:
    MOVB [R0],R2 ;mete-mos no byte endereçado por R0 o caratér vazio
    ADD R0,1 ;avança-se para o próximo byte
    CMP R0,R1 ;verifica-se se chegou-se ao fim do display
    JLE Ciclo_LimpaDisplay ;se não, volta-se ao início do ciclo
    POP R2 ;*********************************************************************************************************************
    POP R1 ; Retira da pilha os registos guardados no início da rotina
    POP R0 ;*********************************************************************************************************************
    RETF

;*********************************************************************************************************************************************
;                                           ROTINA Display_NiveisDeEnergia_InserirInformacao
;                           Responsável por verificar os valores das baterias dos postos e escrever
;                           no display mostrado ao utilizador o estado dos postos conforme os valores
;                           das baterias (Funcional indica que a bateria está acima do valor mínimo de um carregamento de uma hora)
;*********************************************************************************************************************************************
Display_NiveisDeEnergia_InserirInformacao:
    PUSH R3 ;*********************************************************************************************************************
    PUSH R4 ;
    PUSH R5 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R6 ;*********************************************************************************************************************
    MOV R5, InicioDisplay
    MOV R4,Normal
    CMP R0,R4
    JLT NaoFuncionalNormal
    MOV R6,22
    ADD R6,R5
    CALLF EscreveFuncional
    JMP InfoSemiRapido
NaoFuncionalNormal:
    MOV R6,22
    ADD R6,R5
    CALLF EscreveNao_Func
InfoSemiRapido:
    MOV R4,Semirapido
    CMP R1,R4
    JLT NaoFuncionalSemiRapido
    MOV R6,47
    ADD R6,R5
    CALLF EscreveFuncional
    JMP InfoRapido
NaoFuncionalSemiRapido:
    MOV R6,42
    ADD R6,R5
    MOV R3,1
    CALLF EscreveNao
    CALLF EscreveFuncional
InfoRapido:
    MOV R4,Rapido
    CMP R2,R4
    JLT NaoFuncionalRapido
    MOV R6,79
    ADD R6,R5
    CALLF EscreveFuncional
    JMP FimF
NaoFuncionalRapido:
    MOV R6,72
    ADD R6,R5
    MOV R3,3
    CALLF EscreveNao
    CALLF EscreveFuncional
FimF:
    CALLF VerificaOK
    POP R6 ;*********************************************************************************************************************
    POP R5 ;*********************************************************************************************************************
    POP R4 ; Retira da pilha os registos guardados no início da rotina
    POP R3 ;*********************************************************************************************************************
    RET

;******************************************************************************************************************************************
;                           ROTINA EscreveNao
;                   Como o nome indica, esta rotina é responsável por escrever
;                   a palavra "Nao" através do código ASCII e avançar para a
;                   próxima linha, através de espaços
;******************************************************************************************************************************************
EscreveNao:
    MOV R4,78
    ADD R6,1
    MOVB [R6],R4
    ADD R6,1
    MOV R4,97
    MOVB [R6],R4
    ADD R6,1
    MOV R4,111
    MOVB [R6],R4
    ADD R6,1
CicloEspacos:
    MOV R4,32
    MOVB[R6],R4
    ADD R6,1
    SUB R3,1
    CMP R3,0
    JNE CicloEspacos
    RETF

;*************************************************************************************************************************************
;                                           ROTINA EscreveFuncional
;                       Semelhante à anterior, só que escreve "Funcional" em vez de "Nao"
;                       e não faz parágrafo, ao contrário da anterior
;*************************************************************************************************************************************
EscreveFuncional:
    MOV R4,70
    ADD R6,1
    MOVB [R6],R4
    ADD R6,1
    MOV R4,117
    MOVB [R6],R4
    ADD R6,1
    MOV R4,110
    MOVB [R6],R4
    ADD R6,1
    MOV R4,99
    MOVB [R6],R4
    ADD R6,1
    MOV R4,105
    MOVB [R6],R4
    ADD R6,1
    MOV R4,111
    MOVB [R6],R4
    ADD R6,1
    MOV R4,110
    MOVB [R6],R4
    ADD R6,1
    MOV R4,97
    MOVB [R6],R4
    ADD R6,1
    MOV R4,108
    MOVB [R6],R4
    ADD R6,1
    RETF

;********************************************************************************************************************************************
;                                               ROTINA EscreveNao_Func
;                               Semelhante às anteriores, só que esta escreve "Nao Func.".
;                               Só é utilizada para demonstrar que o posto normal não está operacional
;********************************************************************************************************************************************
EscreveNao_Func:
    MOV R4,78
    ADD R6,1
    MOVB [R6],R4
    ADD R6,1
    MOV R4,97
    MOVB [R6],R4
    ADD R6,1
    MOV R4,111
    MOVB [R6],R4
    MOV R4,32
    ADD R6,1
    MOVB [R6],R4
    MOV R4,70
    ADD R6,1
    MOVB [R6],R4
    ADD R6,1
    MOV R4,117
    MOVB [R6],R4
    ADD R6,1
    MOV R4,110
    MOVB [R6],R4
    ADD R6,1
    MOV R4,99
    MOVB [R6],R4
    ADD R6,1
    MOV R4,46
    MOVB [R6],R4
    RETF
	
Fim:
    JMP Fim