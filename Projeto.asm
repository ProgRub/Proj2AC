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

StackPointer EQU 6600H ;endereço da pilha


    ;CALL Display_EstadoServico
    ;CALL LimpaDisplay
    ;CALL Display_Verificacao

Main:
    MOV SP, StackPointer
    CALL VerificaOK
    JMP Fim

InsereEnergia:
    MOV R0, InputIncrementoBateria ;R0 contém o endereço de onde se lê o input de quanto carregar a bateria
    MOV R1, InputTipoCarregamento ;R1 contém o endereço de onde se lê o input de qual bateria carregar
    CALL VerificaOK
    MOV R4,0 ;reset do valor lido do endereço de OK
    MOV R2, [R1] ;R2 contém a seleção de qual bateria carregar, por parte do utilizador
    MOV R3, [R0] ;R3 contém o valor a adicionar à bateria selecionada, se possivel
    MOV R5,CustoNormal
    CMP R2, R5
    JNE IncrementaSemiRapido ;se verificar-se que a bateria escolhida não é a normal, procede-se para a verificação das outras baterias
    MOV R4, EnderecoBateriaNormal ;R4 contém o endereço onde se guarda o valor armazenado na bateria normal
    MOV R5, [R4] ;R5 contém o valor de bateria armazenada
    ADD R5, R3 ;adicionamos a R5 (bateria) o valor que o utilizador inseriu
    JV OverflowBateria ;se ocorrer overflow informar
    MOV [R4],R5 ;se não ocorrer overflow, atualizar a variável na memória que guarda o valor da bateria
    JMP NiveisDeEnergia ;se não ocorrer overflow, avançar para o display dos niveis de energia
IncrementaSemiRapido:
    MOV R5,CustoSemiRapido
    CMP R2,R5
    JNE IncrementaRapido ;verificar se escolheu carregar a bateria semirapida, se não avançar
    MOV R4, EnderecoBateriaSemiRapido ;R4 contém o endereço onde se guarda o valor da bateria semirapida
    MOV R5,[R4] ;R5 contém o valor da bateria armazenada
    ADD R5,R3 ;adicionamos a R5 (bateria) o valor que o utilizador inseriu
    JV OverflowBateria; se ocorrer overflow informar
    MOV [R4],R5 ;se não ocorrer overflow, atualizar a variável na memória que guarda o valor da bateria
    JMP NiveisDeEnergia ;avançar para o display dos niveis de energia
IncrementaRapido:
    MOV R5, CustoRapido
    CMP R2, R5
    JNE NiveisDeEnergia ;verificar se escolheu carregar a bateria rapida, se não avançar
    MOV R4, EnderecoBateriaRapido ;R4 contém o endereço onde se guarda o valor da bateria rapida
    MOV R5,[R4] ;R5 contém o valor da bateria armazenada
    ADD R5,R3 ;adicionamos a R5 (bateria) o valor que o utilizador inseriu
    JV OverflowBateria ;se ocorrer overflow informar
    MOV [R4],R5 ;se não ocorrer overflow, atualizar a variável na memória que guarda o valor da bateria
    JMP NiveisDeEnergia ;avançar para o display dos niveis de energia
OverflowBateria:
    MOV R9,0
    MOV [R4],R9
    JMP Fim
    ; PLACE 0900H
    ; String "OVERFLOW"
    ; PLACE 0056H


NiveisDeEnergia:
    MOV R0,EnderecoBateriaNormal ;R0 guarda o endereço onde está o valor da bateria normal
    MOV R1,EnderecoBateriaSemiRapido ;R1 guarda o endereço onde está o valor da bateria semirápida
    MOV R2,EnderecoBateriaRapido ;R2 guarda o endereço onde está o valor da bateria rápida
	MOV R3,[R0] ;R3 tem o valor da bateria do carregamento normal
    MOV R4,[R1] ;R4 tem o valor da bateria do carregamento semirapido
    MOV R5,[R2] ;R5 tem o valor da bateria do carregamento rápido 
    MOV R6,0 ;R6 contará quantas bateria estiverem abaixo do nivel minimo
    MOV R7,Normal ;R7 contém o nivel minimo que a bateria normal deve ter para ser considerada funcional
    MOV R8,Semirapido ;R8 contém o nivel minimo que a bateria semirapida deve ter para ser considerada funcional
    MOV R9,Rapido ;R9 contém o nivel minimo que a bateria rapida deve ter para ser considerada funcional
    CMP R3,R7
    JGE VerificaSemiRapido ;se verificarmos que a bateria normal tem o nivel minimo, verificamos as restantes
    ADD R6,1 ;caso contrario, adicionamos 1 ao contador
VerificaSemiRapido:
    CMP R4,R8
    JGE VerificaRapido ;se verificarmos que a bateria semirapida tem o nivel minimo, verificamos a bateria rapida
    ADD R6,1 ;caso contrario, adicionamos 1 ao contador
VerificaRapido:
    CMP R5, R9
    JGT Verificacao_Aluno ;se verificarmos que a bateria rapida tem o nivel minimo, o posto esta operacional
    ADD R6,1 ;caso contrario, adicionamos 1 ao contador
    MOV R10,3 ;R10 guarda o valor 3 para comparar ao contador
    CMP R6,R10
    JEQ Fim ;se o contador for igual a 3, o posto esta inoperacional
Verificacao_Aluno:
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
    MOV R9,1; R9 indica que a verificação foi bem sucedida (1-true)
    MOV R10,R1 ;mete no registo 10 o indice do aluno verificado com sucesso, para ser utilizado posteriormente para verificar o seu saldo
    JMP EscolhaCarregamento ;se não saltou anteriormente, então o utilizador foi verificado com sucesso e pode carregar o seu veículo
VerificacaoFalhada:
    ADD R1,2
    MOV R7,R1 ;R7 serve para verificar se o indice é igual ao tamanho
    MOV R8,Tamanho ;R8 é o número de alunos na base de dados
    SHR R7,1 ;dividir por 2, para a verificação do índice com o tamanho
    CMP R7,R8 
    JEQ Fim ;chegou ao fim da base
    MOV R3,Proximo
    ADD R0,R3 ;avanca a base para o proximo aluno a verificar
    JMP Ciclo_Verify_Aluno
	
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
    POP R1
    POP R0
    RET
EscolhaCarregamento: 
	MOV R0, CustoNormal								;coloca no registo 0 o valor do custo do carregamento do tipo normal
	MOV R1, CustoSemiRapido							;coloca no registo 1 o valor do custo do carregamento do tipo semi-rápido
	MOV R2, CustoRapido								;coloca no registo 2 o valor do custo do carregamento do tipo rápido
    CALL VerificaOK
    MOV R5, InputTipoCarregamento ;coloca no registo 5 o endereço de onde ler o tipo de carregamento
	MOV R3, [R5]					                ;coloca no registo 3 o tipo de carregamento escolhido pelo utilizador
	CMP R3,R0										;compara o registo 3 com o registo 0
	JEQ	EscolhaTempo								;verifica se a comparação anterior é verdadeira
	CMP R3, R1										;compara o registo 3 com o registo 1
	JEQ	EscolhaTempo								;verifica se a comparação anterior é verdadeira
	CMP R3, R2										;compara o registo 3 com o registo 2
	JEQ EscolhaTempo								;verifica se a comparação anterior é verdadeira
	JMP EscolhaCarregamento							;volta para o menu inicial
	
CarregamentoRapidoValido:
		
	
	
	
EscolhaTempo: 
    CALL VerificaOK
    MOV R0,0
    MOV [R7],R0
    MOV R6, InputTempo      ;coloca no registo 6 o endereço de onde ler quanto tempo carregar
	MOV R4, [R6]							;coloca no registo 0 o tempo escolhido pelo utilizador
	CMP R4, 0										;se o valor do registo 0 for superior a 0, verifica o saldo do utilizador 
	JGT VerificaSaldo
	JMP EscolhaTempo_VerificaOK								;volta para o menu inicial
	
VerificaSaldo:									;coloca no registo 5 o custo do tipo de carregamento
	MUL R3, R4										;multiplica o registo 5 com o tempo escolhido pelo utilizador
	JV Fim
    MOV R5, Base_Tabela_Dados
    ADD R5,R10
    MOV R6,[R5+Saldo]
	CMP R3, R6									;compara o custo do carregamento com o saldo do utilizador
	JLE Debito								;se a verificação for verdadeira, salta para o "tag" Debito
	JMP NaoForneceEnergia							;salta para o "tag" NãoForneceEnergia
	
Debito:
	MOV R0, [R5+Saldo] ;coloca no registo 0 o saldo do utilizador
	SUB R0, R3 ;é subtraido o custo da operação, atualiza o saldo do utilizador
	MOV R6, R4
	JMP ForneceEnergia ;salta para o "tag" ForneceEnergia

ForneceEnergia: ;FALTA FORNECER ENERGIA AO VEICULO
	SUB R4,1 ;subtrai ao tempo
	CMP R4,0 ;se o valor do registo 4 chegar a 0, atualiza os valores de energia do posto
	JEQ AtualizaValoresEnergia ;salta para o "tag" AtualizaValoresEnergia
    JMP ForneceEnergia 
	
NaoForneceEnergia:
    JMP NaoForneceEnergia
	
AtualizaValoresEnergia:
	MOV R0, InputTipoCarregamento ;coloca no registo 0 o endereço de onde ler o tipo de carregamento
    CALL VerificaOK
	MOV R1, [R0] ;coloca no registo 1 o tipo de carregamento escolhido pelo utilizador
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
	MOV R2, Normal ;coloca no registo 2 a energia do carregamento normal por hora
	MUL R6, R2 ;coloca no registo 1 a energia do carregamento total
	MOV R3, EnderecoBateriaNormal ;coloca no registo 3 o endereço de onde ler o valor da bateria normal
	MOV R4, [R3] ;coloca no registo 4 o valor da bateria normal
	SUB R4, R6 ;subtrai o valor da energia do carregamento total à bateria do posto normal
	MOV [R3], R4 ;atualiza o valor de energia da bateria do posto normal
	JMP NiveisDeEnergia ;salta para o "tag" NiveisDeEnergia
	
AtualizaPostoSemiRapido:
	MOV R2, Semirapido ;coloca no registo 2 a energia do carregamento semi-rapido por hora
	MUL R6, R2 ;coloca no registo 1 a energia do carregamento total
	MOV R3, EnderecoBateriaSemiRapido ;coloca no registo 3 o endereço de onde ler o valor da bateria semi-rapida
	MOV R4, [R3] ;coloca no registo 4 o valor da bateria semi-rapida
	SUB R4, R6  ;subtrai o valor da energia do carregamento total à bateria do posto semi-rapido
	MOV [R3], R4 ;atualiza o valor de energia da bateria do posto semi-rapido
	JMP NiveisDeEnergia ;salta para o "tag" NiveisDeEnergia

AtualizaPostoRapido:
	MOV R2, Rapido ;coloca no registo 2 a energia do carregamento rapido por hora
	MUL R6, R2 ;coloca no registo 1 a energia do carregamento total
	MOV R3, EnderecoBateriaRapido ;coloca no registo 3 o endereço de onde ler o valor da bateria rapida
	MOV R4, [R3] ;coloca no registo 4 o valor da bateria rapida
	SUB R4, R6  ;subtrai o valor da energia do carregamento total à bateria do posto rapido
	MOV [R3], R4 ;atualiza o valor de energia da bateria do posto rapido
	JMP NiveisDeEnergia ;salta para o "tag" NiveisDeEnergia
	
	
	
; Fim:
;     JMP Fim
; Inicio:
;     ;CALL Display_EstadoServico
;     CALL LimpaDisplay
;     CALL Display_Verificacao
;     JMP Fim
; Display_EstadoServico:
;     PLACE 0100H
;     String "  ESTADO POSTO  "
;     String "NORMAL:         "
;     ; MOV R0, BateriaNormal
;     ; MOV R3, 0
;     ; CMP R0,R3
;     ; JZ 3
;     String "FUNCIONAL       "
;     ; JMP 2
;     ; CALL Display_NFuncional
;     String "SEMIRAPIDO:     "
;     ; MOV R1, BateriaSemiRapido
;     ; CMP R1,R3
;     ; JZ 3
;     String "FUNCIONAL       "
;     ; JMP 2
;     ; CALL Display_NFuncional
;     String "RAPIDO:         "
;     ; MOV R2, BateriaRapido
;     ; CMP R2,R3
;     ; JZ 3
;     String "FUNCIONAL       "
;     ; JMP 2
;     ; CALL Display_NFuncional
;     PLACE 0000H

; Display_Funcional:
;     String "FUNCIONAL       "
; Display_NFuncional:
;     String "NÃO FUNCIONAL   "



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

;Display_Verificacao:
  ;  PLACE 0100H
  ;  String "  VERIFICACAO   "
  ;  String "  INTRODUZA ID  "
  ;  String " E CODIGO SEG.  "
  ;  PLACE 0000H
; Display_Verificacao:
;     PLACE 0100H
;     String "  VERIFICACAO   "
;     String "  INTRODUZA ID  "
;     String " E CODIGO SEG.  "
;     PLACE 0000H


