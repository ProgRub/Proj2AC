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
InputTipoCarregamento    EQU 00E0H     ;endereço onde inserir o tipo de carregamento
InputTempo                 EQU 00E2H     ;endereço onde inserir o tempo desejado
InputIncrementoBateria  EQU 00E4H ;endereço onde inserir a bateria a adicionar à bateria selecionada

;endereços relativos à base de dados
Base_Tabela_Dados EQU 1100H ;endereço do início da base de dados
CodSeguranca EQU 02H ;aumento relativo ao inicio dos dados do cliente para ler o código de segurança
Saldo EQU 04H ;aumento relativo ao inicio dos dados do cliente para ler o saldo
BateriaCarro EQU 06H ;aumento relativo ao inicio dos dados do cliente para ler quanta bateria o carro do cliente tem
Proximo EQU 08H ;salto a executar para ler os dados do próximo cliente
Tamanho EQU 3 ;número de clientes na base de dados

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

;***********************************************************************************************************************************
;           ROTINA InsereEnergia
;   Responsável por recarregar as baterias dos postos, se o utilizador assim desejar
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
    MOV R8,Tamanho ;R8 é o número de clientes na base de dados
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
EscolhaCarregamento:
    MOV R3, EnderecoBateriaNormal ;mete em R3 o endereço onde está guardado o valor da bateria do posto normal
    MOV R4, EnderecoBateriaSemiRapido ;mete em R4 o endereço onde está guardado o valor da bateria do posto semirapido
    MOV R5, EnderecoBateriaRapido ;mete em R5 o endereço onde está guardado o valor da bateria do posto rapido
    MOV R0,[R3] ;guarda em R0 o valor da bateria do posto normal, e aqui fica ao longo do programa
    MOV R1, [R4] ;guarda em R1 o valor da bateria do posto semirapido, e aqui fica ao longo do programa
    MOV R2,[R5] ;guarda em R2 o valor da bateria do posto rapido, e aqui fica ao longo do programa 
	MOV R6, CustoNormal								;coloca no registo 0 o valor do custo do carregamento do tipo normal
	MOV R7, CustoSemiRapido							;coloca no registo 1 o valor do custo do carregamento do tipo semi-rápido
	MOV R8, CustoRapido								;coloca no registo 2 o valor do custo do carregamento do tipo rápido
	MOV R9, MenuEscolheCarregamento ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    MOV R5, InputTipoCarregamento ;coloca no registo 5 o endereço de onde ler o tipo de carregamento
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
	MOVB R3, [R5]					                ;coloca no registo 3 o tipo de carregamento escolhido pelo utilizador
	CALL LimpaPerifericosEntrada
	CMP R3, R6										;compara o registo 3 com o registo 0
	JEQ EscolhaTempo
	CMP R3, R7										;compara o registo 3 com o registo 1
	JEQ EscolhaTempo								;verifica se a comparação anterior é verdadeira
	CMP R3, R8										;compara o registo 3 com o registo 2
	JEQ EscolhaTempo								;verifica se a comparação anterior é verdadeira
	MOV R9, MenuOpcaoInvalida ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
	JMP EscolhaCarregamento							;volta para o menu inicial

EscolhaTempo: 
	MOV R9, MenuEscolherTempo ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R5, InputTempo   ;coloca no registo 6 o endereço de onde ler quanto tempo carregar
	MOV R4, [R5]	;coloca no registo 4 o tempo escolhido pelo utilizador
	CALL LimpaPerifericosEntrada
	CMP R3,R6										;compara o registo 3 com o registo 0
	JNE VerificaEscolhaTempoSuperiorSemiRapido
	MOV R5, R4
	MOV R9, Normal
	MUL R5, R9
	CMP R5, R0
	JGT SemBateriaParaCarregamento
	JMP FimVerificacoes
VerificaEscolhaTempoSuperiorSemiRapido:
	CMP R3, R7										;compara o registo 3 com o registo 1
	JNE VerificaEscolhaTempoSuperiorRapido
	MOV R5, R4
	MOV R9, Semirapido
	MUL R5, R9
	CMP R5, R1
	JGT SemBateriaParaCarregamento
	JMP FimVerificacoes
VerificaEscolhaTempoSuperiorRapido:
	MOV R5, R4
	MOV R9, Rapido
	MUL R5, R9
	CMP R5, R2
	JGT SemBateriaParaCarregamento
FimVerificacoes:
	CMP R4, 0		;se o valor do registo 4 for superior a 0, verifica o saldo do utilizador
	JGT VerificaSaldo
	MOV R9, MenuTempoInvalido ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    JMP EscolhaTempo


SemBateriaParaCarregamento:
	MOV R9, Display_TempoUltrapassa ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
	JMP FimFunc3

VerificaSaldo:
    MOV R7,R4
	MUL R4, R3	;R4 contém o custo da operação de carregamento agora
    MOV R5, Base_Tabela_Dados
    ADD R5,R10
    MOV R6,[R5+Saldo]
	CMP R4, R6	;compara o custo do carregamento com o saldo do utilizador
	JLE ForneceEnergia ;se a comparação for verdadeira, salta para o "tag" Debito
	MOV R9, MenuSaldoInsuficiente ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
	JMP NaoForneceEnergia	;salta para o "tag" NãoForneceEnergia

ForneceEnergia:
	MOV R9, MenuInfoCarregamento ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R4,R7
	MOV R9,R7
	MOV R6, CustoNormal ;coloca no registo 2 o custo do carregamento normal
	MOV R7, CustoSemiRapido ;coloca no registo 3 o custo do carregamento semi-rapido
	MOV R8, CustoRapido ;coloca no registo 4 o custo do carregamento rapido
	CMP R3, R6	;verifica se o carregamento pretendido é o normal									
	JEQ	ForneceEnergiaNormal	;salta para o "tag" AtualizaPostoNormal
	CMP R3, R7	;verifica se o carregamento pretendido é o semi-rapido
	JEQ	ForneceEnergiaSemiRapido ;salta para o "tag" AtualizaPostoSemiRapido
	CMP R3,	R8		;verifica se o carregamento pretendido é o rapido
	JEQ ForneceEnergiaRapido	;salta para o "tag" AtualizaPostoRapido

ForneceEnergiaNormal:
    MOV R5, Base_Tabela_Dados
    ADD R5,R10
	MOV R6, [R5+BateriaCarro] ;coloca no registo 0 o valor da bateria do vehiculo do utilizador
	MOV R7, Normal ;coloca no registo 1 o valor do carregamento normal
	ADD R6, R7 ;soma o carregamento à bateria do vehiculo
	MOV R8, 100 ;coloca no registo 5 a constante 100
	CMP R6, R8 ;compara o registo 0 com o registo 5
	JGT BateriaCarregada ;se o valor do registo 0 for superior ou igual a 100, salta para o "tag" BateriaCarregada
	MOV [R5+BateriaCarro], R6 ;atualiza o valor da bateria do vehiculo
	SUB R4,1 ;subtrai ao tempo 
	CMP R4,0 ;se o valor do registo 4 chegar a 0, atualiza os valores de energia do posto
	JEQ AtualizaValoresEnergia ;salta para o "tag" AtualizaPostoNormal
    JMP ForneceEnergiaNormal ;salta para o "tag" ForneceEnergiaNormal
	
ForneceEnergiaSemiRapido:
    MOV R5, Base_Tabela_Dados
    ADD R5,R10
	MOV R6, [R5+BateriaCarro] ;coloca no registo 0 o valor da bateria do vehiculo do utilizador
	MOV R7, Semirapido ;coloca no registo 1 o valor do carregamento sermi-rapido
	ADD R6, R7 ;soma o carregamento à bateria do vehiculo
	MOV R8, 100 ;coloca no registo 5 a constante 100
	SUB R4,1 ;subtrai ao tempo
	CMP R6, R8 ;compara o registo 0 com o registo 5
	JGT BateriaCarregada ;se o valor do registo 0 for superior ou igual a 100, salta para o "tag" BateriaCarregada
	MOV [R5+BateriaCarro], R6 ;atualiza o valor da bateria do vehiculo
	CMP R4,0 ;se o valor do registo 4 chegar a 0, atualiza os valores de energia do posto
	JEQ AtualizaValoresEnergia ;salta para o "tag" AtualizaPostoSemiRapido
    JMP ForneceEnergiaSemiRapido ;salta para o "tag" ForneceEnergiaSemiRapido

ForneceEnergiaRapido:
	MOV R9,1
	MOV R4,0
	JMP BateriaCarregada ;salta para o "tag" BateriaCarregada

BateriaCarregada:
	MOV R6, 100 ;coloca no registo 0 a constante 100
	MOV [R5+BateriaCarro], R6 ;atualiza o valor da bateria do vehiculo
	JMP AtualizaValoresEnergia ;salta para o "tag" AtualizaValoresEnergia
	
NaoForneceEnergia:
    JMP FimFunc3
	
Debito:
	MOV R6, [R5+Saldo]
	SUB R6, R7
	MOV [R5+Saldo],R6 ;atualiza o saldo do utilizador 
	MOV R9, MenuDebito ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
	RET	
	
AtualizaValoresEnergia:
	MOV R7,R9
	CMP R4,0
	JEQ Excedeu
	JMP NaoExcedeu 
	
Excedeu:
	MOV R9, Display_UltrapassaCargaMaxima ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador

NaoExcedeu:
	SUB R7, R4
	MOV R4, R7
	MUL R7,R3
	CALL Debito
	MOV R6, CustoNormal ;coloca no registo 2 o custo do carregamento normal
	MOV R7, CustoSemiRapido ;coloca no registo 3 o custo do carregamento semi-rapido
	MOV R8, CustoRapido ;coloca no registo 4 o custo do carregamento rapido
	CMP R3, R6	;verifica se o carregamento pretendido é o normal									
	JEQ	AtualizaPostoNormal	;salta para o "tag" AtualizaPostoNormal
	CMP R3, R7	;verifica se o carregamento pretendido é o semi-rapido
	JEQ	AtualizaPostoSemiRapido ;salta para o "tag" AtualizaPostoSemiRapido
	CMP R3,	R8		;verifica se o carregamento pretendido é o rapido
	JEQ AtualizaPostoRapido	;salta para o "tag" AtualizaPostoRapido

AtualizaPostoNormal:
	MOV R6, Normal ;coloca no registo 4 a energia do carregamento normal por hora
	MUL R6, R4 ;coloca no registo 6 a energia do carregamento total
	SUB R0, R6 ;subtrai o valor da energia do carregamento total à bateria do posto normal
	JMP CarregamentoConcluido
	
AtualizaPostoSemiRapido:
	MOV R6, Semirapido ;coloca no registo 4 a energia do carregamento semi-rapido por hora
	MUL R6, R4 ;coloca no registo 6 a energia do carregamento total
	SUB R1, R6  ;subtrai o valor da energia do carregamento total à bateria do posto semi-rapido
	JMP CarregamentoConcluido

AtualizaPostoRapido:
	MOV R6, Rapido ;coloca no registo 4 a energia do carregamento rapido por hora
	MUL R6, R4 ;coloca no registo 6 a energia do carregamento total
	SUB R2, R6  ;subtrai o valor da energia do carregamento total à bateria do posto rapido
CarregamentoConcluido:
	MOV R9, MenuCarregamentoConcluido ;Mete no registo 9, onde está o endereço do display a mostrar, o display que pretendemos mostrar
    CALL RefreshDisplay ;Mostra o display metido anteriormente em R9 ao utilizador
    MOV R6, EnderecoBateriaNormal ;mete em R3 o endereço onde está guardado o valor da bateria do posto normal
    MOV R7, EnderecoBateriaSemiRapido ;mete em R4 o endereço onde está guardado o valor da bateria do posto semirapido
    MOV R8, EnderecoBateriaRapido ;mete em R5 o endereço onde está guardado o valor da bateria do posto rapido
    MOV [R6], R0
    MOV [R7], R1
    MOV [R8], R2
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
    PUSH R2 ; Guarda na pilha os registos alterados durante esta rotina
    PUSH R3 ;
    PUSH R4 ;
    PUSH R5 ;*********************************************************************************************************************
    MOV R0, InputCodSeguranca
    MOV R1, InputID
    MOV R2, InputIncrementoBateria
    MOV R3, InputTempo
    MOV R4, InputTipoCarregamento
    MOV R5,0
    MOV [R0],R5
    MOV [R1],R5
    MOV [R2],R5
    MOV [R3],R5
    MOV [R4],R5
    POP R5 ;*********************************************************************************************************************
    POP R4 ;
    POP R3 ;
    POP R2 ; Retira da pilha os registos guardados no início da rotina
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