;constantes:
Normal 					EQU 20 		;3.7 kWh
Semirapido 				EQU 60 		;22 kWh
Rapido 					EQU 100 	;50 kWh
CustoNormal 			EQU 1		;custo do carregamento normal
CustoSemiRapido 		EQU 2 		;custo do carregamento semirápido
CustoRapido 			EQU 3 		;custo do carregamento rápido
EnderecoBateriaNormal   	EQU 1200H ;endereço onde é guardado o valor da bateria para o carregamento normal
EnderecoBateriaSemiRapido   EQU 1202H ;endereço onde é guardado o valor da bateria para o carregamento semi-rápido
EnderecoBateriaRapido   	EQU 1204H ;endereço onde é guardado o valor da bateria para o carregamento rápido

InicioDisplay EQU 0030H
FimDisplay EQU 009FH

;endereços de memória relativos aos inputs:
OK                         EQU 00B0H     ;endereço do botão OK
CANCEL                     EQU 00B2H     ;endereço do botão Cancel
InputID                 EQU 00D0H     ;endereço onde inserir o ID do cliente
InputCodSeguranca         EQU 00D2H     ;endereço onde inserir o código de segurança do cliente
InputSaldo                 EQU 00D4H     ;endereço onde inserir o ID do cliente
InputBateria         EQU 00D6H     ;endereço onde inserir o código de segurança do cliente
InputTipoCarregamento    EQU 00E0H     ;endereço onde inserir o tipo de carregamento
InputTempo                 EQU 00E2H     ;endereço onde inserir o tempo desejado
InputIncrementoBateria  EQU 00E4H ;endereço onde inserir a bateria a adicionar à bateria selecionada

;endereços relativos à base de dados
Base_Tabela_Dados EQU 1100H ;endereço do início da base de dados
CodSeguranca EQU 02H ;aumento relativo ao inicio dos dados do cliente para ler o código de segurança
Saldo EQU 04H ;aumento relativo ao inicio dos dados do cliente para ler o saldo
BateriaCarro EQU 06H ;aumento relativo ao inicio dos dados do cliente para ler quanta bateria o carro do cliente tem
Proximo EQU 08H ;salto a executar para ler os dados do próximo cliente
EnderecoTamanho EQU 10FEH ;endereço que contém o número de clientes na base de dados

StackPointer EQU 8000H ;endereço da pilha
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
    String "                "
    String "   AUTORIZADO   "
    String "                "
    String "                "
	String " OK - continuar "

PLACE 2100H
Display_VerificacaoFalhada:
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
MenuEscolheCarregamento:
	String " ESCOLHA O TIPO	"
	String "DE CARREGAMENTO:"
	String "  1- Normal     "
	String "  2- Semi-Rapido"
	String "  3- Rapido     " 
	String "                "
	String " OK - continuar "

PLACE 2380H
MenuOpcaoInvalida:
	String "                "
	String "                "
	String "     OPCAO      "
	String "    INVALIDA    "
	String "                "
	String "                "
	String " OK - continuar "

PLACE 2400H
MenuEscolherTempo:
	String " ESCOLHA O TEMPO"
	String "DE CARREGAMENTO:"
	String "                "
	String "                "
	String "    Tempo:      "
	String "                "
	String " OK - continuar "

PLACE 2480H
MenuTempoInvalido:
	String "     OPCAO      "
	String "    INVALIDA    "
	String "                "
	String "tempo tem de ser"
	String "   superior a 0 "
	String "                "
	String " OK - continuar "

PLACE 2500H
MenuDebito:
	String "  CARREGAMENTO  "
	String "                "
	String "   Saldo:       "
	String "                "
	String "   Custo:       "
	String "                "
	String " OK - continuar "

PLACE 2580H
MenuSaldoInsuficiente:
	String "                "
	String "                "
	String "     SALDO      "
	String "  INSUFICIENTE  "
	String "                "
	String "                "
	String " OK - continuar "

PLACE 2600H
MenuInfoCarregamento:
	String "  CARREGAMENTO  "
	String "                "
	String "   Tipo:        "
	String "                "
	String "   Duracao:     "
	String "                "
	String " OK - continuar "

PLACE 2680H
MenuCarregamentoConcluido:
	String "                "
	String "                "
	String "  CARREGAMENTO  "
	String "    CONCLUIDO   "
	String "                "
	String "                "
	String " OK - continuar "
PLACE 2700H
Display_Overflow:
	String "                "
	String "                "
	String "     OCORREU    "
	String "    OVERFLOW    "
	String "                "
	String "                "
	String " OK - continuar "

PLACE 2780H
Display_UltrapassaCargaMaxima:
	String "                "
	String " O CARREGAMENTO "
	String "IRA ULTRAPASSAR "
	String " A CARGA MAXIMA "
	String "   DA BATERIA   "
	String "                "
	String " OK - continuar "
	
PLACE 2800H
Display_TempoUltrapassa:
	String "                "
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
PLACE 0000H
Inicio:
    MOV R0,Main
    JMP R0
PLACE 6000H
Main:
    MOV SP, StackPointer
    CALL Programa
    JMP Fim

Programa:
    CALL LimpaDisplay
    CALL AlteraBaseDeDados
    CALL InsereEnergia
    CALL NiveisDeEnergia
    MOV R4,-1
    CMP R10,R4
    JEQ Programa    
    CALL Verificacao_Cliente
	MOV R4, -1 ;mete em R4 o valor -1 para comparar com R10, o indice do cliente verificado (possivelmente)
	CMP R10, R4 ;se R10 for igual a -1 (R4), significa que o cliente não está na base de dados e a verificação falhou
	JEQ Programa ;se tal acontecer, volta-se ao inicio do programa
    CALL Carregamento
	JMP Programa
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
AlterarOuNao:
    MOV R2, InputTipoCarregamento
    MOV R9, Display_AlterarBaseDeDados
    CALL RefreshDisplay
    MOVB R0,[R2]
    CMP R0,1
    JEQ CriarOuAlterar
    CMP R0,2
    JNE OpcaoInvalidaDatabase
    JMP FimFunc4
OpcaoInvalidaDatabase:
    MOV R9, MenuOpcaoInvalida
    CALL RefreshDisplay
    JMP AlterarOuNao
CriarOuAlterar:
    CALL LimpaPerifericosEntrada
    MOV R9, Display_CriarOuAlterar
    CALL RefreshDisplay
    MOVB R0,[R2]
    CMP R0,1
    JNE AlterarDados
    MOV R8,Base_Tabela_Dados
    MOV R9,EnderecoTamanho
    MOV R10,[R9]
    MOV R7,Proximo
    MUL R10,R7
    ADD R8,R10
    MOV R5, InputID
    MOV R6, InputCodSeguranca
    MOV R7, InputSaldo
    MOV R4, InputBateria
    MOV R9, Display_InserirDadosNovos
    CALL RefreshDisplay
    MOV R0,[R5]
    MOV R1,[R6]
    MOV R2,[R7]
    MOV R3,[R4]
    CMP R2,0
    JN SaldoInvalido
    CMP R3,0
    JN BateriaInvalida
    MOV R7,100
    CMP R3,R7
    JGT BateriaInvalida
    MOV R5,CodSeguranca
    MOV R6,Saldo
    MOV R7,BateriaCarro
    MOV [R8],R0
    MOV [R8+R5],R1
    MOV [R8+R6],R2
    MOV [R8+R7],R3
    MOV R1,EnderecoTamanho
    MOV R0,[R1]
    ADD R0,1
    MOV [R1],R0
    MOV R9, Display_NovoClienteCriado
    CALL RefreshDisplay
    JMP AlterarOuNao
AlterarDados:
    CMP R0,2
    JNE OpcaoInvalidaDatabase
    CALL LimpaPerifericosEntrada
    MOV R5,InputID
    MOV R6, InputCodSeguranca
    MOV R8, Base_Tabela_Dados
    MOV R3,0
    MOV R4,CodSeguranca
    MOV R9, Display_QualCliente
    CALL RefreshDisplay
    MOV R0,[R5]
    MOV R1,[R6]
Ciclo_AlterarDados:
    MOV R5, [R8] ;R3 tem o valor do ID da tabela de base de dados a verificar
    MOV R6, [R8+R4] ;R4 tem o valor de código de segurança da tabela de base de dados a verificar
    CMP R0,R5 
    JNE ContinuarTabela ;se R7(ID do utilizador) for diferente de R3(ID a ser verificado na tabela), avançar para o próximo, se possivel
    CMP R1,R6
    JNE ContinuarTabela ;se R8(Código de segurança do utilizador) for diferente de R4(código de segurança a ser verificado na tabela), avançar para o próximo, se possivel
	MOV R10, Proximo
	SHR R3,1
    MUL R10,R3 ;mete no registo 10 o indice do cliente verificado com sucesso, para ser utilizado posteriormente para verificar o seu saldo
    JMP AlterarDadosCliente ;se não saltou anteriormente, então o utilizador foi verificado com sucesso e pode carregar o seu veículo
ContinuarTabela:
    MOV R10,-1
    ADD R3,2
    MOV R2,R3 ;R7 serve para verificar se o indice é igual ao tamanho
    MOV R9,EnderecoTamanho
    MOV R7,[R9] ;R8 é o número de clientes na base de dados
    SHR R2,1 ;dividir por 2, para a verificação do índice com o tamanho
    CMP R2,R7
    JEQ ClienteNaoPresente ;chegou ao fim da base
    MOV R2,Proximo
    ADD R8,R2 ;avanca a base para o proximo cliente a verificar
    JMP Ciclo_AlterarDados
ClienteNaoPresente:
    MOV R9, Display_ClienteNaoEstaNaDatabase ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP FimFunc4
AlterarDadosCliente:
    MOV R5, InputID
    MOV R6, InputCodSeguranca
    MOV R7, InputSaldo
    MOV R4, InputBateria
    MOV R9, Display_InserirDadosParaAlterar
    CALL RefreshDisplay
    CALL LimpaPerifericosEntrada
    MOV R0,[R5]
    MOV R1,[R6]
    MOV R2,[R7]
    MOV R3,[R4]
    CMP R2,0
    JLT SaldoInvalido
    CMP R3,0
    JLT BateriaInvalida
    MOV R7,100
    CMP R3,R7
    JGT BateriaInvalida
    MOV R8,Base_Tabela_Dados
    ADD R8,R10
    MOV R6,CodSeguranca
    MOV R4,BateriaCarro
    MOV R7,Saldo
    MOV [R8],R0
    MOV [R8+R6],R1
    MOV [R8+R7],R2
    MOV [R8+R4],R3
    MOV R9,Display_DadosAlterados
    CALL RefreshDisplay
    JMP AlterarOuNao
SaldoInvalido:
    MOV R9, Display_SaldoInvalido
    CALL RefreshDisplay
    JMP AlterarOuNao
BateriaInvalida:
    MOV R9, Display_BateriaInvalida
    CALL RefreshDisplay
    JMP AlterarOuNao
FimFunc4:
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
    MOV R6, InputTipoCarregamento ;R6 contém o endereço de onde se lê o input de qual bateria carregar
    MOV R9, Display_InsereEnergia ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOVB R4, [R6]  ;R4 contém a seleção de qual bateria carregar, por parte do utilizador
	CALL LimpaPerifericosEntrada
    MOV R6, EnderecoBateriaNormal ;mete em R3 o endereço onde está guardado o valor da bateria do posto normal
    MOV R7, EnderecoBateriaSemiRapido ;mete em R4 o endereço onde está guardado o valor da bateria do posto semirapido
    MOV R8, EnderecoBateriaRapido ;mete em R5 o endereço onde está guardado o valor da bateria do posto rapido
    MOV R0,[R6] ;guarda em R0 o valor da bateria do posto normal, e aqui fica ao longo do programa
    MOV R1, [R7] ;guarda em R1 o valor da bateria do posto semirapido, e aqui fica ao longo do programa
    MOV R2,[R8] ;guarda em R2 o valor da bateria do posto rapido, e aqui fica ao longo do programa
    MOV R5,4
    CMP R4,R5
    JNE IncrementaNormal
    JMP FimFunc1
IncrementaNormal:
	CALL LimpaPerifericosEntrada
    MOV R5, CustoNormal
    CMP R4, R5
    JNE IncrementaSemiRapido ;se verificar-se que a bateria escolhida não é a normal, procede-se para a verificação das outras baterias
	MOV R9, Display_InsereEnergiaQuanta ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R5, InputIncrementoBateria ;R5 contém o endereço de onde se lê o input de quanto carregar a bateria
    MOV R3, [R5] ;R3 contém o valor a adicionar à bateria selecionada, se possivel
    ADD R0, R3 ;adicionamos a R0 (bateria normal) o valor que o utilizador inseriu
    JV OverflowBateria ;se ocorrer overflow informar
    JMP FimFunc1 ;se não ocorrer overflow, avançar para o display dos niveis de energia
IncrementaSemiRapido:
    MOV R5,CustoSemiRapido
    CMP R4,R5
    JNE IncrementaRapido ;verificar se escolheu carregar a bateria semirapida, se não avançar
	MOV R9, Display_InsereEnergiaQuanta ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R5, InputIncrementoBateria ;R5 contém o endereço de onde se lê o input de quanto carregar a bateria
    MOV R3, [R5] ;R3 contém o valor a adicionar à bateria selecionada, se possivel
    ADD R1,R3 ;adicionamos a R1 (bateria semirapido) o valor que o utilizador inseriu
    JV OverflowBateria; se ocorrer overflow informar
    JMP FimFunc1 ;avançar para o display dos niveis de energia
IncrementaRapido:
    MOV R5, CustoRapido
    CMP R4, R5
    JNE OpcaoInvalida ;verificar se escolheu carregar a bateria rapida, se não avançar
	MOV R9, Display_InsereEnergiaQuanta ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R5, InputIncrementoBateria ;R5 contém o endereço de onde se lê o input de quanto carregar a bateria
    MOV R3, [R5] ;R3 contém o valor a adicionar à bateria selecionada, se possivel
    ADD R2,R3 ;adicionamos a R2 (bateria rapido) o valor que o utilizador inseriu
    JV OverflowBateria ;se ocorrer overflow informar
    JMP FimFunc1 ;avançar para o fim da função
OverflowBateria:
    MOV R9, Display_Overflow ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP FimFunc1
OpcaoInvalida:
    MOV R9,MenuOpcaoInvalida ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
	CALL LimpaPerifericosEntrada
    JMP InicioInsereEnergia
FimFunc1:
    MOV R6, EnderecoBateriaNormal ;mete em R3 o endereço onde está guardado o valor da bateria do posto normal
    MOV R7, EnderecoBateriaSemiRapido ;mete em R4 o endereço onde está guardado o valor da bateria do posto semirapido
    MOV R8, EnderecoBateriaRapido ;mete em R5 o endereço onde está guardado o valor da bateria do posto rapido
    MOV [R6], R0
    MOV [R7], R1
    MOV [R8], R2
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
    MOV R0,[R3] ;guarda em R0 o valor da bateria do posto normal, e aqui fica ao longo do programa
    MOV R1, [R4] ;guarda em R1 o valor da bateria do posto semirapido, e aqui fica ao longo do programa
    MOV R2,[R5] ;guarda em R2 o valor da bateria do posto rapido, e aqui fica ao longo do programa 
    MOV R3,0 ;R6 contará quantas bateria estiverem abaixo do nivel minimo
    MOV R4,Normal ;R7 contém o nivel minimo que a bateria normal deve ter para ser considerada funcional
    MOV R5,Semirapido ;R8 contém o nivel minimo que a bateria semirapida deve ter para ser considerada funcional
    MOV R6,Rapido ;R9 contém o nivel minimo que a bateria rapida deve ter para ser considerada funcional
    CMP R0,R4
    JGE VerificaSemiRapido ;se verificarmos que a bateria normal tem o nivel minimo, verificamos as restantes
    ADD R3,1 ;caso contrario, adicionamos 1 ao contador
VerificaSemiRapido:
    CMP R1,R5
    JGE VerificaRapido ;se verificarmos que a bateria semirapida tem o nivel minimo, verificamos a bateria rapida
    ADD R3,1 ;caso contrario, adicionamos 1 ao contador
VerificaRapido:
    CMP R2, R6
    JGE FimFunc ;se verificarmos que a bateria rapida tem o nivel minimo, o posto esta operacional
    ADD R3,1 ;caso contrario, adicionamos 1 ao contador
    MOV R7,3 ;R10 guarda o valor 3 para comparar ao contador
    CMP R3,R7
    JNE FimFunc
    MOV R10,-1
FimFunc:
    MOV R9,Display_NiveisDeEnergia ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    CALL Display_NiveisDeEnergia_InserirInformacao
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
    MOV R9, Display_InputVerifyCliente ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R0, Base_Tabela_Dados ;mover para R0 a base da tabela de dados, será a base dos dados do cliente que estamos a verifica e contém o ID deste
    MOV R1, 0 ;R1 será o índice
    MOV R2, CodSeguranca ;R2 será a posição na tabela onde está o código de segurança do cliente
    MOV R3, InputID ;R5 é o endereço de onde se lê o ID do utilizador
    MOV R4, InputCodSeguranca ;R6 é o endereço de onde se lê o código de segurança do utilizador
    MOV R5, [R3] ;R7 é o ID que o utilizador inseriu
    MOV R6, [R4] ;R8 é o código de segurança que o utilizador inseriu
	CALL LimpaPerifericosEntrada
Ciclo_Verify_Cliente:
    MOV R3, [R0] ;R3 tem o valor do ID da tabela de base de dados a verificar
    MOV R4, [R0+R2] ;R4 tem o valor de código de segurança da tabela de base de dados a verificar
    CMP R5,R3 
    JNE VerificacaoFalhada ;se R7(ID do utilizador) for diferente de R3(ID a ser verificado na tabela), avançar para o próximo, se possivel
    CMP R6,R4
    JNE VerificacaoFalhada ;se R8(Código de segurança do utilizador) for diferente de R4(código de segurança a ser verificado na tabela), avançar para o próximo, se possivel
	MOV R10, Proximo
	SHR R1,1
    MUL R10,R1 ;mete no registo 10 o indice do cliente verificado com sucesso, para ser utilizado posteriormente para verificar o seu saldo
	MOV R9, Display_VerificacaoSucesso ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP FimFunc2 ;se não saltou anteriormente, então o utilizador foi verificado com sucesso e pode carregar o seu veículo
VerificacaoFalhada:
    MOV R10,-1
    ADD R1,2
    MOV R7,R1 ;R7 serve para verificar se o indice é igual ao tamanho
    MOV R9,EnderecoTamanho
    MOV R8,[R9] ;R8 é o número de clientes na base de dados
    SHR R7,1 ;dividir por 2, para a verificação do índice com o tamanho
    CMP R7,R8 
    JEQ NaoVerificado ;chegou ao fim da base
    MOV R3,Proximo
    ADD R0,R3 ;avanca a base para o proximo cliente a verificar
    JMP Ciclo_Verify_Cliente
NaoVerificado:
    MOV R9, Display_VerificacaoFalhada ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
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
	MOV R9, MenuEscolheCarregamento 										;mete no registo 9, onde está o endereço do display que pretendemos mostrar (MenuEscolheCarregamento)
    MOV R5, InputTipoCarregamento 											;coloca no registo 5 o endereço de onde ler o tipo de carregamento
    CALL RefreshDisplay 													;mostra ao utilizador o display  metido anteriormente em R9 
	MOVB R3, [R5]					                						;coloca no registo 3 o tipo de carregamento escolhido pelo utilizador
	CALL LimpaPerifericosEntrada											;é feita a limpeza dos perifericos de entrada, tomando o valor inicial (0)
	CMP R3, R6																;compara o registo 3 com o registo 6
	JEQ EscolhaTempo														;se o valor do registo 3 for igual ao valor do registo 6, salta para o tag "EscolhaTempo" - ou seja, escolheu o carregamento normal
	CMP R3, R7																;compara o registo 3 com o registo 7
	JEQ EscolhaTempo														;se o valor do registo 3 for igual ao valor do registo 7, salta para o tag "EscolhaTempo" - ou seja, escolheu o carregamento semi-rapido
	CMP R3, R8																;compara o registo 3 com o registo 8
	JEQ EscolhaTempo														;se o valor do registo 3 for igual ao valor do registo 8, salta para o tag "EscolhaTempo" - ou seja, escolheu o carregamento rapido
	MOV R9, MenuOpcaoInvalida 												;mete no registo 9, onde está o endereço do display que pretendemos mostrar (MenuOpcaoInvalida) ********************************************************													
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 										* ACONTECE SE FOR INSERIDO UM VALOR DIFERENTE DE 1,2,3 *
	JMP EscolhaCarregamento													;volta para o menu inicial (volta a escolher o tipo carregamento)								********************************************************

EscolhaTempo: 																;VERIFICAR O TEMPO ESCOLHIDO PELO UTILIZADOR
	MOV R9, MenuEscolherTempo 												;mete no registo 9, onde está o endereço do display que pretendemos mostrar
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 
    MOV R5, InputTempo   													;coloca no registo 5 o endereço de onde ler quanto tempo carregar
	MOV R4, [R5]															;coloca no registo 4 o tempo escolhido pelo utilizador
	CALL LimpaPerifericosEntrada											;é feita a limpeza dos perifericos de entrada, tomando o valor inicial (0)
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
	MOV R9, MenuTempoInvalido 												;mete no registo 9, onde está o endereço do display que pretendemos mostrar (MenuTempoInvalido)
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
	MOV R9, MenuSaldoInsuficiente											;mete no registo 9, onde está o endereço do que pretendemos mostrar (MenuSaldoInsuficiente)		*****************************************************
    CALL RefreshDisplay 													;mostra ao utilizador o display metido anteriormente em R9 										* ACONTECE SE O UTILIZADOR NÃO TEM SALDO SUFICIENTE *
	JMP NaoForneceEnergia													;salta para o tag "NãoForneceEnergia" 															*****************************************************
	
	
ForneceEnergia:																;VERIFICA O TIPO DE CARREGAMENTO A SER FORNECIDO
	MOV R9, MenuInfoCarregamento 											;mete no registo 9, onde está o endereço do display que pretendemos mostrar
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
	MOV R9, MenuDebito 														;mete no registo 9, onde está o endereço do display que pretendemos mostrar
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
	MOV R9, MenuCarregamentoConcluido 										;mete no registo 9, onde está o endereço do display que pretendemos mostrar
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
    CMP R1,0
    JEQ CicloVerOK ;só quando o utilizador mudar o valor para diferente de 0 é que se lê os inputs do utilizador
    MOV R1,0
    MOVB [R0],R1
    POP R1  ;*********************************************************************************************************************
    POP R0  ; Retira da pilha os registos guardados no início da rotina
            ;*********************************************************************************************************************
    RET

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
    MOV R0,InicioDisplay
    MOV R1,FimDisplay
Ciclo_RefreshDisplay:
    MOV R2,[R9]
    MOV [R0],R2
    ADD R0,2
    ADD R9,2
    CMP R0,R1
    JLE Ciclo_RefreshDisplay
    MOV R3, Display_NiveisDeEnergia
    MOV R0,InicioDisplay
    SUB R1,R0
    ADD R1,1
    ADD R3,R1
    CMP R9,R3
    JEQ FimRefreshDiplay
	CALL VerificaOK
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
    MOV R0, InputCodSeguranca
    MOV R1, InputID
    MOV R2, InputIncrementoBateria
    MOV R3, InputTempo
    MOV R4, InputTipoCarregamento
    MOV R5, InputSaldo
    MOV R6, InputBateria
    MOV R7,0
    MOV [R0],R7
    MOV [R1],R7
    MOV [R2],R7
    MOV [R3],R7
    MOV [R4],R7
    MOV [R5],R7
    MOV [R6],R7
    POP R7 ;*********************************************************************************************************************
    POP R6 ;
    POP R5 ;
    POP R4 ; Retira da pilha os registos guardados no início da rotina
    POP R3 ;
    POP R2 ;
    POP R1 ;
    POP R0 ;*********************************************************************************************************************
    RET
    
;**********************************************************************************************************************************
;                                       ROTINA LimpaDisplay
;                       Como o nome indica, "limpa" o display mostrado ao utilizador,
;                       preenchendo-o com espaços
;**********************************************************************************************************************************
LimpaDisplay:
    PUSH R0 ;*********************************************************************************************************************
    PUSH R1 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R2 ;*********************************************************************************************************************
    MOV R0,InicioDisplay
    MOV R1,FimDisplay
Ciclo_LimpaDisplay:
    MOV R2,32
    MOVB [R0],R2
    ADD R0,1
    CMP R0,R1
    JLE Ciclo_LimpaDisplay
    POP R2 ;*********************************************************************************************************************
    POP R1 ; Retira da pilha os registos guardados no início da rotina
    POP R0 ;*********************************************************************************************************************
    RET

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
    CALL EscreveFuncional
    JMP InfoSemiRapido
NaoFuncionalNormal:
    MOV R6,22
    ADD R6,R5
    CALL EscreveNao_Func
InfoSemiRapido:
    MOV R4,Semirapido
    CMP R1,R4
    JLT NaoFuncionalSemiRapido
    MOV R6,47
    ADD R6,R5
    CALL EscreveFuncional
    JMP InfoRapido
NaoFuncionalSemiRapido:
    MOV R6,42
    ADD R6,R5
    MOV R3,1
    CALL EscreveNao
    CALL EscreveFuncional
InfoRapido:
    MOV R4,Rapido
    CMP R2,R4
    JLT NaoFuncionalRapido
    MOV R6,79
    ADD R6,R5
    CALL EscreveFuncional
    JMP FimF
NaoFuncionalRapido:
    MOV R6,72
    ADD R6,R5
    MOV R3,3
    CALL EscreveNao
    CALL EscreveFuncional
FimF:
    CALL VerificaOK
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
    RET

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
    RET

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
    RET
	
Fim:
    JMP Fim