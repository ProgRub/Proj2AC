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
FimDisplay EQU 00AFH

;endereços de memória:
OK 						EQU 1020H 	;endereço do botão OK
CANCEL 					EQU 1022H 	;endereço do botão Cancel
;Display 				EQU 2000H 	;endereço do display
InputID 				EQU 1000H 	;endereço onde inserir o ID do aluno
InputCodSeguranca 		EQU 1002H 	;endereço onde inserir o código de segurança do aluno
InputTipoCarregamento	EQU 1010H 	;endereço onde inserir o tipo de carregamento
InputTempo 				EQU 1012H 	;endereço onde inserir o tempo desejado
InputIncrementoBateria  EQU 1014H ;endereço onde inserir a bateria a adicionar à bateria selecionada

;endereços relativos à base de dados
Base_Tabela_Dados EQU 1100H ;endereço do início da base de dados
CodSeguranca EQU 02H ;aumento relativo ao inicio dos dados do aluno para ler o código de segurança
Saldo EQU 04H ;aumento relativo ao inicio dos dados do aluno para ler o saldo
BateriaCarro EQU 06H ;aumento relativo ao inicio dos dados do aluno para ler quanta bateria o carro do aluno tem
Proximo EQU 08H ;salto a executar para ler os dados do próximo aluno
Tamanho EQU 1 ;número de alunos na base de dados

StackPointer EQU 8000H ;endereço da pilha

PLACE 2000H
Display_InputVerifyAluno:
   String "  VERIFICACAO   "
   String "                "
   String "  INTRODUZA ID  "
   String "                "
   String " E CODIGO SEG.  "
   String "   Carregue OK  "
   String "quando terminado"

PLACE 2080H
Display_VerificacaoSucesso:
   String "                "
   String "                "
   String "                "
   String "   AUTORIZADO   "
   String "                "
   String "   Carregue OK  "
   String " para continuar "

PLACE 2100H
Display_VerificacaoFalhada:
   String "                "
   String "                "
   String "                "
   String " NAO AUTORIZADO "
   String "                "
   String "   Carregue OK  "
   String " para continuar "

PLACE 2180H
Display_InsereEnergia:
   String " CARREGAR POSTO "
   String "Escolha bateria:"
   String "1)- Normal      "
   String "2)- Semi-Rapido "
   String "3)- Rapido      "
   String "4)- Fechar Posto"
   String "   Carregue OK  "

PLACE 2200H
Display_InsereEnergiaQuanta:
   String " CARREGAR POSTO "
   String "  Quanto quer   "
   String "   carregar?    "
   String "                "
   String "                "
   String "   Carregue OK  "
   String " para continuar "

PLACE 2280H
Display_NiveisDeEnergia_Caso1:
   String " ESTADO DO POSTO"
   String "Normal: Func    "
   String "SemiRapido: Func"
   String "Rapido: Func    "
   String "                "
   String "   Carregue OK  "
   String " para continuar "

PLACE 2300H
Display_NiveisDeEnergia_Caso2:
   String " ESTADO DO POSTO"
   String "Normal: Vazio   "
   String "SemiRapido: Func"
   String "Rapido: Func    "
   String "                "
   String "   Carregue OK  "
   String " para continuar "
   
PLACE 2380H
Display_NiveisDeEnergia_Caso3:
   String " ESTADO DO POSTO"
   String "Normal: Vazio   "
   String "SemiRapido:Vazio"
   String "Rapido: Func    "
   String "                "
   String "   Carregue OK  "
   String " para continuar "

PLACE 2400H
Display_NiveisDeEnergia_Caso4:
   String " ESTADO DO POSTO"
   String "Normal: Vazio   "
   String "SemiRapido:Vazio"
   String "Rapido: Vazio   "
   String "                "
   String "   Carregue OK  "
   String " para continuar "
   
PLACE 2480H
Display_NiveisDeEnergia_Caso5:
   String " ESTADO DO POSTO"
   String "Normal: Func    "
   String "SemiRapido:Vazio"
   String "Rapido: Func    "
   String "                "
   String "   Carregue OK  "
   String " para continuar "

PLACE 2500H
Display_NiveisDeEnergia_Caso6:
   String " ESTADO DO POSTO"
   String "Normal: Func    "
   String "SemiRapido:Vazio"
   String "Rapido: Vazio   "
   String "                "
   String "   Carregue OK  "
   String " para continuar "

PLACE 2580H
Display_NiveisDeEnergia_Caso7:
   String " ESTADO DO POSTO"
   String "Normal: Func    "
   String "SemiRapido: Func"
   String "Rapido: Vazio   "
   String "                "
   String "   Carregue OK  "
   String " para continuar "

PLACE 2600H
MenuEscolheCarregamento:
	String " ESCOLHA O TIPO	 "
	String "DE CARREGAMENTO: "
	String "                 "
	String "   1- Normal     "
	String "   2- Semi-Rápido"
	String "   3- Rápido     " 
	String "                 "
	String "OK para continuar"

PLACE 2680H
MenuOpcaoInvalida:
	String "                 "
	String "                 "
	String "     OPÇÃO       "
	String "    INVÁLIDA     "
	String "                 "
	String "                 "
	String "                 "
	String "OK para continuar"

PLACE 2700H
MenuEscolherTempo:
	String " ESCOLHA O TEMPO "
	String "DE CARREGAMENTO: "
	String "                 "
	String "                 "
	String "    Tempo:       "
	String "                 "
	String "                 "
	String "OK para continuar"

PLACE 2780H
MenuTempoInvalido:
	String "                 "
	String "     OPÇÃO       "
	String "    INVÁLIDA     "
	String "                 "
	String " tempo tem de ser"
	String "   superior a 0  "
	String "                 "
	String "OK para continuar"

PLACE 2800H
MenuDebito:
	String "  CARREGAMENTO   "
	String "                 "
	String "   Saldo:        "
	String "                 "
	String "   Custo:        "
	String "                 "
	String "                 "
	String "OK para continuar"

PLACE 2880H
MenuSaldoInsuficiente:
	String "                 "
	String "                 "
	String "     SALDO       "
	String "  INSUFICIENTE   "
	String "                 "
	String "                 "
	String "                 "
	String "OK para continuar"

PLACE 2900H
MenuInfoCarregamento:
	String "  CARREGAMENTO   "
	String "                 "
	String "   Tipo:         "
	String "                 "
	String "   Duração:      "
	String "                 "
	String "                 "
	String "OK para continuar"

PLACE 2980H
MenuCarregamentoConcluido:
	String "                 "
	String "                 "
	String "   CARREGAMENTO  "
	String "    CONCLUÍDO    "
	String "                 "
	String "                 "
	String "                 "
	String "OK para continuar"

PLACE 0000H
Inicio:
    MOV R0,Main
    JMP R0
PLACE 6000H
Main:
    MOV SP, StackPointer
    MOV R3, EnderecoBateriaNormal
    MOV R4, EnderecoBateriaSemiRapido
    MOV R5, EnderecoBateriaRapido
    MOV R0,[R3]
    MOV R1, [R4]
    MOV R2,[R5]
    MOV R3,0
    MOV R4,0
    MOV R5,0
    CALL Programa
    JMP Fim

Programa:
    CALL InsereEnergia
    CALL NiveisDeEnergia
    CALL Verificacao_Aluno
    CALL EscolhaCarregamento
    RET
InsereEnergia:
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6
    MOV R3, Display_InsereEnergia
    CALL RefreshDisplay
    MOV R5, InputIncrementoBateria ;R0 contém o endereço de onde se lê o input de quanto carregar a bateria
    MOV R6, InputTipoCarregamento ;R1 contém o endereço de onde se lê o input de qual bateria carregar
    CALL VerificaOK
    MOV R4,0 ;reset do valor lido do endereço de OK
    MOV R3, [R5] ;R2 contém a seleção de qual bateria carregar, por parte do utilizador
    MOV R4, [R6] ;R3 contém o valor a adicionar à bateria selecionada, se possivel
    MOV R5,CustoNormal
    CMP R3, R5
    JNE IncrementaSemiRapido ;se verificar-se que a bateria escolhida não é a normal, procede-se para a verificação das outras baterias
    ADD R0, R4 ;adicionamos a R5 (bateria) o valor que o utilizador inseriu
    JV OverflowBateria ;se ocorrer overflow informar
    JMP FimFunc1 ;se não ocorrer overflow, avançar para o display dos niveis de energia
IncrementaSemiRapido:
    MOV R5,CustoSemiRapido
    CMP R3,R5
    JNE IncrementaRapido ;verificar se escolheu carregar a bateria semirapida, se não avançar
    ADD R1,R4 ;adicionamos a R5 (bateria) o valor que o utilizador inseriu
    JV OverflowBateria; se ocorrer overflow informar
    JMP FimFunc1 ;avançar para o display dos niveis de energia
IncrementaRapido:
    MOV R5, CustoRapido
    CMP R3, R5
    JNE FimFunc1 ;verificar se escolheu carregar a bateria rapida, se não avançar
    ADD R2,R4 ;adicionamos a R5 (bateria) o valor que o utilizador inseriu
    JV OverflowBateria ;se ocorrer overflow informar
    JMP FimFunc1 ;avançar para o display dos niveis de energia
OverflowBateria:
    MOV R6,0
    MOV [R4],R6
FimFunc1:
    POP R6
    POP R5
    POP R4
    POP R3
    RET
    ; PLACE 0900H
    ; String "OVERFLOW"
    ; PLACE 0056H


NiveisDeEnergia:
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6
    PUSH R7    
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
    JGT FimFunc ;se verificarmos que a bateria rapida tem o nivel minimo, o posto esta operacional
    ADD R3,1 ;caso contrario, adicionamos 1 ao contador
    MOV R7,3 ;R10 guarda o valor 3 para comparar ao contador
    CMP R3,R7
    JNE FimFunc
    CALL InsereEnergia
FimFunc:
    POP R7
    POP R6
    POP R5
    POP R4
    POP R3
    RET

Verificacao_Aluno:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R8
    MOV R0, Base_Tabela_Dados ;mover para R0 a base da tabela de dados, será a base dos dados do aluno que estamos a verifica e contém o ID deste
    MOV R1, 0 ;R1 será o índice
    MOV R2, CodSeguranca ;R2 será a posição na tabela onde está o código de segurança do aluno
    CALL VerificaOK
    MOV R3, InputID ;R5 é o endereço de onde se lê o ID do utilizador
    MOV R4, InputCodSeguranca ;R6 é o endereço de onde se lê o código de segurança do utilizador
    MOV R5, [R3] ;R7 é o ID que o utilizador inseriu
    MOV R6, [R4] ;R8 é o código de segurança que o utilizador inseriu
Ciclo_Verify_Aluno:
    MOV R3, [R0] ;R3 tem o valor do ID da tabela de base de dados a verificar
    MOV R4, [R0+R2] ;R4 tem o valor de código de segurança da tabela de base de dados a verificar
    CMP R5,R3 
    JNE VerificacaoFalhada ;se R7(ID do utilizador) for diferente de R3(ID a ser verificado na tabela), avançar para o próximo, se possivel
    CMP R6,R4
    JNE VerificacaoFalhada ;se R8(Código de segurança do utilizador) for diferente de R4(código de segurança a ser verificado na tabela), avançar para o próximo, se possivel
    MOV R10,R1 ;mete no registo 10 o indice do aluno verificado com sucesso, para ser utilizado posteriormente para verificar o seu saldo
    JMP FimFunc2 ;se não saltou anteriormente, então o utilizador foi verificado com sucesso e pode carregar o seu veículo
VerificacaoFalhada:
    MOV R10,-1
    ADD R1,2
    MOV R7,R1 ;R7 serve para verificar se o indice é igual ao tamanho
    MOV R8,Tamanho ;R8 é o número de alunos na base de dados
    SHR R7,1 ;dividir por 2, para a verificação do índice com o tamanho
    CMP R7,R8 
    JEQ FimFunc2 ;chegou ao fim da base
    MOV R3,Proximo
    ADD R0,R3 ;avanca a base para o proximo aluno a verificar
    JMP Ciclo_Verify_Aluno
FimFunc2:
    POP R8
    POP R7
    POP R6
    POP R5
    POP R4
    POP R3
    POP R2
    POP R1
    POP R0
    RET
	
Fim:
    JMP Fim
	
VerificaOK:
    PUSH R0
    PUSH R1
CicloVerOK:
    MOV R0, OK ;mete em R0 o endereço de onde ver se o utilizador "carregou" OK
    MOV R1, [R0] ;mete em R1 o valor lido do endereço R0
    CMP R1,0
    JEQ CicloVerOK ;só quando o utilizador mudar o valor para diferente de 0 é que se lê os inputs do utilizador
    MOV R1,0
    MOV [R0],R1
    POP R1
    POP R0
    RET

EscolhaCarregamento: 
    PUSH R0
    PUSH R1
    PUSH R2
	MOV R0, CustoNormal								;coloca no registo 0 o valor do custo do carregamento do tipo normal
	MOV R1, CustoSemiRapido							;coloca no registo 1 o valor do custo do carregamento do tipo semi-rápido
	MOV R2, CustoRapido								;coloca no registo 2 o valor do custo do carregamento do tipo rápido
    CALL VerificaOK
    MOV R5, InputTipoCarregamento ;coloca no registo 5 o endereço de onde ler o tipo de carregamento
	MOV R3, [R5]					                ;coloca no registo 3 o tipo de carregamento escolhido pelo utilizador
	JEQ R3,R0										;compara o registo 3 com o registo 0
	CALL EscolhaTempo								;verifica se a comparação anterior é verdadeira
	CMP R3, R1										;compara o registo 3 com o registo 1
	JEQ EscolhaTempo								;verifica se a comparação anterior é verdadeira
	CMP R3, R2										;compara o registo 3 com o registo 2
	JEQ EscolhaTempo								;verifica se a comparação anterior é verdadeira
	JMP EscolhaCarregamento							;volta para o menu inicial

EscolhaTempo: 
    CALL VerificaOK 
    MOV R6, InputTempo   ;coloca no registo 6 o endereço de onde ler quanto tempo carregar
	MOV R4, [R6]	;coloca no registo 4 o tempo escolhido pelo utilizador
	CMP R4, 0		;se o valor do registo 4 for superior a 0, verifica o saldo do utilizador
	JLE EscolhaTempo

VerificaSaldo:
	MUL R4, R3	
	JV Fim
    MOV R5, Base_Tabela_Dados
    ADD R5,R10
    MOV R6,[R5+Saldo]
	CMP R4, R6	;compara o custo do carregamento com o saldo do utilizador
	JLE Debito ;se a comparação for verdadeira, salta para o "tag" Debito
	JMP NaoForneceEnergia	;salta para o "tag" NãoForneceEnergia
	
Debito:
	MOV R0, [R5+Saldo] ;coloca no registo 0 o saldo do utilizador
	SUB R0, R3 ;é subtraido o custo da operação, atualiza o saldo do utilizador
	MOV R6, R4 ;coloca no registo 6 o valor do registo 4

ForneceEnergia:
	MOV R1, R3 ;coloca no registo 1 o valor do registo 3
	MOV R2, CustoNormal ;coloca no registo 2 o custo do carregamento normal
	MOV R3, CustoSemiRapido ;coloca no registo 3 o custo do carregamento semi-rapido
	MOV R4, CustoRapido ;coloca no registo 4 o custo do carregamento rapido
	CMP R1, R2	;verifica se o carregamento pretendido é o normal									
	JEQ	ForneceEnergiaNormal	;salta para o "tag" AtualizaPostoNormal
	CMP R1, R3	;verifica se o carregamento pretendido é o semi-rapido
	JEQ	ForneceEnergiaSemiRapido ;salta para o "tag" AtualizaPostoSemiRapido
	CMP R1,	R4		;verifica se o carregamento pretendido é o rapido
	JEQ ForneceEnergiaRapido	;salta para o "tag" AtualizaPostoRapido

ForneceEnergiaNormal:
	MOV R0, [R5+BateriaCarro] ;coloca no registo 0 o valor da bateria do vehiculo do utilizador
	MOV R1, Normal ;coloca no registo 1 o valor do carregamento normal
	ADD R0, R1 ;soma o carregamento à bateria do vehiculo
	MOV R5, 100 ;coloca no registo 5 a constante 100
	CMP R0, R5 ;compara o registo 0 com o registo 5
	JGE BateriaCarregada ;se o valor do registo 0 for superior ou igual a 100, salta para o "tag" BateriaCarregada
	MOV [R5+BateriaCarro], R0 ;atualiza o valor da bateria do vehiculo
	SUB R4,1 ;subtrai ao tempo 
	CMP R4,0 ;se o valor do registo 4 chegar a 0, atualiza os valores de energia do posto
	JEQ AtualizaPostoNormal ;salta para o "tag" AtualizaPostoNormal
    JMP ForneceEnergiaNormal ;salta para o "tag" ForneceEnergiaNormal

ForneceEnergiaSemiRapido:
	MOV R0, [R5+BateriaCarro] ;coloca no registo 0 o valor da bateria do vehiculo do utilizador
	MOV R1, Semirapido ;coloca no registo 1 o valor do carregamento sermi-rapido
	ADD R0, R1 ;soma o carregamento à bateria do vehiculo
	MOV R5, 100 ;coloca no registo 5 a constante 100
	CMP R0, R5 ;compara o registo 0 com o registo 5
	JGE BateriaCarregada ;se o valor do registo 0 for superior ou igual a 100, salta para o "tag" BateriaCarregada
	MOV [R5+BateriaCarro], R0 ;atualiza o valor da bateria do vehiculo
	SUB R4,1 ;subtrai ao tempo
	CMP R4,0 ;se o valor do registo 4 chegar a 0, atualiza os valores de energia do posto
	JEQ AtualizaPostoSemiRapido ;salta para o "tag" AtualizaPostoSemiRapido
    JMP ForneceEnergiaSemiRapido ;salta para o "tag" ForneceEnergiaSemiRapido

ForneceEnergiaRapido:
	JMP BateriaCarregada ;salta para o "tag" BateriaCarregada


BateriaCarregada:
	MOV R0, 100 ;coloca no registo 0 a constante 100
	MOV [R5+BateriaCarro], R0 ;atualiza o valor da bateria do vehiculo
	JMP AtualizaValoresEnergia ;salta para o "tag" AtualizaValoresEnergia
	
NaoForneceEnergia:
    JMP NaoForneceEnergia ;salta para o "tag" NaoForneceEnergia
	
AtualizaValoresEnergia:
	MOV R2, CustoNormal ;coloca no registo 2 o custo do carregamento normal
	MOV R3, CustoSemiRapido ;coloca no registo 3 o custo do carregamento semi-rapido
	MOV R4, CustoRapido ;coloca no registo 4 o custo do carregamento rapido
	CMP R1, R2	;verifica se o carregamento pretendido é o normal									
	JEQ	AtualizaPostoNormal	;salta para o "tag" AtualizaPostoNormal
	CMP R1, R3	;verifica se o carregamento pretendido é o semi-rapido
	JEQ	AtualizaPostoSemiRapido ;salta para o "tag" AtualizaPostoSemiRapido
	CMP R1,	R4		;verifica se o carregamento pretendido é o rapido
	JEQ AtualizaPostoRapido	;salta para o "tag" AtualizaPostoRapido

AtualizaPostoNormal:
	MOV R4, Normal ;coloca no registo 4 a energia do carregamento normal por hora
	MUL R6, R4 ;coloca no registo 6 a energia do carregamento total
	SUB R0, R6 ;subtrai o valor da energia do carregamento total à bateria do posto normal
	JMP NiveisDeEnergia ;salta para o "tag" NiveisDeEnergia
	
AtualizaPostoSemiRapido:
	MOV R4, Semirapido ;coloca no registo 4 a energia do carregamento semi-rapido por hora
	MUL R6, R4 ;coloca no registo 6 a energia do carregamento total
	SUB R1, R6  ;subtrai o valor da energia do carregamento total à bateria do posto semi-rapido
	JMP NiveisDeEnergia ;salta para o "tag" NiveisDeEnergia

AtualizaPostoRapido:
	MOV R4, Rapido ;coloca no registo 4 a energia do carregamento rapido por hora
	MUL R6, R4 ;coloca no registo 6 a energia do carregamento total
	SUB R2, R6  ;subtrai o valor da energia do carregamento total à bateria do posto rapido
	JMP NiveisDeEnergia ;salta para o "tag" NiveisDeEnergia
	
;LimpaDisplay:
 ;   PLACE 0100H
  ;  String "                "
  ;  String "                "
  ;  String "                "
  ;  String "                "
  ;  String "                "
  ;  String "                "
  ;  String "                "
  ;  PLACE 0000H

RefreshDisplay:
    PUSH R0
    PUSH R1
    PUSH R2
    MOV R0,InicioDisplay
    MOV R1,FimDisplay
Ciclo_RefreshDisplay:
    MOV R2,[R3]
    MOV [R0],R2
    ADD R0,2
    ADD R3,2
    CMP R0,R1
    JLE Ciclo_RefreshDisplay
    POP R2
    POP R1
    POP R0
    RET