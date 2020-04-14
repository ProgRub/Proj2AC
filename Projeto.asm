;constantes:
normal 					EQU 20 		;3.7 kWh
semirapido 				EQU 60 		;22 kWh
rapido 					EQU 100 	;50 kWh
CustoNormal 			EQU 1		;custo do carregamento normal
CustoSemiRapido 		EQU 2 		;custo do carregamento semirápido
CustoRapido 			EQU 3 		;custo do carregamento rápido
BateriaNormal 			EQU 1000 	;valor de bateria para o carregamento normal no posto
BateriaSemiRapido 		EQU 1000 	;valor de bateria para o carregamento semi rápido no posto
BateriaRapido 			EQU 1000 	;valor de bateria para o carregamento rápido no posto

;endereços de memória:
OK 						EQU 1020H 	;endereço do botão OK
CANCEL 					EQU 1022H 	;endereço do botão Cancel
;Display 				EQU 2000H 	;endereço do display
InputID 				EQU 1000H 	;endereço onde inserir o ID do aluno
InputCodSeguranca 		EQU 1002H 	;endereço onde inserir o código de segurança do aluno
InputTipoCarregamento	EQU 1010H 	;endereço onde inserir o tipo de carregamento
InputTempo 				EQU 1012H 	;endereço onde inserir o tempo desejado

;endereços relativos à base de dados
Base_Tabela_Dados EQU 3000H ;endereço do início da base de dados
CodSeguranca EQU 02H ;aumento relativo ao inicio dos dados do aluno para ler o código de segurança
Saldo EQU 04H ;aumento relativo ao inicio dos dados do aluno para ler o saldo
Proximo EQU 06H ;salto a executar para ler os dados do próximo aluno
Tamanho EQU 1 ;número de alunos na base de dados


    ;CALL Display_EstadoServico
    ;CALL LimpaDisplay
    ;CALL Display_Verificacao
	
Verificacao_Aluno:
    MOV R0, Base_Tabela_Dados ;mover para R0 a base da tabela de dados, será a base dos dados do aluno que estamos a verifica e contém o ID deste
    MOV R1, 0 ;R1 será o índice
    MOV R2, CodSeguranca ;R2 será a posição na tabela onde está o código de segurança do aluno
VerificaOK1:    
    MOV R3, OK ;mete em R3 o endereço de onde ver se o utilizador "carregou" OK
    MOV R4, [R3] ;mete em R4 o valor lido do endereço R3
    CMP R4,0
    JEQ VerificaOK1 ;só quando o utilizador mudar o valor para diferente de 0 é que se lê os inputs do utilizador
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
    ADD R0,Proximo ;avanca a base para o proximo aluno a verificar
    JMP Ciclo_Verify_Aluno
Fim:
    MOV R9,0; R9 indica que a verificação foi bem sucedida (0-false)
    JMP Fim
	
EscolhaCarregamento: 
	MOV R0, CustoNormal								;coloca no registo 0 o valor do custo do carregamento do tipo normal
	MOV R1, CustoSemiRapido							;coloca no registo 1 o valor do custo do carregamento do tipo semi-rápido
	MOV R2, CustoRapido								;coloca no registo 2 o valor do custo do carregamento do tipo rápido
VerificaOK2:    
    MOV R3, OK ;mete em R3 o endereço de onde ver se o utilizador "carregou" OK
    MOV R4, [R3] ;mete em R4 o valor lido do endereço R3
    CMP R4,0
    JEQ VerificaOK2 ;só quando o utilizador mudar o valor para diferente de 0 é que se lê os inputs do utilizador
    MOV R5, InputTipoCarregamento ;coloca no registo 5 o endereço de onde ler o tipo de carregamento
	MOV R3, [R5]					                ;coloca no registo 3 o tipo de carregamento escolhido pelo utilizador
	CMP R3,R0										;compara o registo 3 com o registo 0
	JEQ	EscolhaTempo_VerificaOK3								;verifica se a comparação anterior é verdadeira
	CMP R3, R1										;compara o registo 3 com o registo 1
	JEQ	EscolhaTempo_VerificaOK3								;verifica se a comparação anterior é verdadeira
	CMP R3, R2										;compara o registo 3 com o registo 2
	JEQ EscolhaTempo_VerificaOK3								;verifica se a comparação anterior é verdadeira
	JMP EscolhaCarregamento							;volta para o menu inicial
EscolhaTempo_VerificaOK:   
    MOV R7, OK ;mete em R3 o endereço de onde ver se o utilizador "carregou" OK
    MOV R8, [R7] ;mete em R4 o valor lido do endereço R3
    CMP R8,0
    JEQ EscolhaTempo_VerificaOK ;só quando o utilizador mudar o valor para diferente de 0 é que se lê os inputs do utilizador
    MOV R0,0
    MOV [R7],R0
    MOV R6, InputTempo      ;coloca no registo 6 o endereço de onde ler quanto tempo carregar
	MOV R4, [R6]							;coloca no registo 0 o tempo escolhido pelo utilizador
	CMP R4, 0										;se o valor do registo 0 for superior a 0, verifica o saldo do utilizador 
	JGT VerificaSaldo
	JMP EscolhaTempo_VerificaOK								;volta para o menu inicial
	
VerificaSaldo:									;coloca no registo 5 o custo do tipo de carregamento
	MUL R3, R4										;multiplica o registo 5 com o tempo escolhido pelo utilizador
    MOV R5, Base_Tabela_Dados
    ADD R5,R10
    MOV R6,[R5+Saldo]
	CMP R3, R6									;compara o custo do carregamento com o saldo do utilizador
	JLE ForneceEnergia								;se a verificação for verdadeira, salta para o "tag" ForneceEnergia
	JMP NaoForneceEnergia							;salta para o "tag" NãoForneceEnergia
	
ForneceEnergia:
    JMP ForneceEnergia
NaoForneceEnergia:
    JMP NaoForneceEnergia
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


