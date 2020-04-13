;constantes
normal EQU 20 ;3.7 kWh
semirapido EQU 60 ;22 kWh
rapido EQU 100 ;50 kWh
CustoNormal EQU 1 ;custo do carregamento normal
CustoSemiRapido EQU 2 ;custo do carregamento semirápido
CustoRapido EQU 3 ;custo do carregamento rápido
BateriaNormal EQU 1000 ;valor de bateria para o carregamento normal no posto
BateriaSemiRapido EQU 1000 ;valor de bateria para o carregamento semi rápido no posto
BateriaRapido EQU 1000 ;valor de bateria para o carregamento rápido no posto

;endereços de memória
OK EQU 3300H ;endereço do botão OK
CANCEL EQU 3301H ;endereço do botão Cancel
;Display EQU 2000H ;endereço do display
InputID EQU 1500H ;endereço onde inserir o ID do aluno
InputCodSeguranca EQU 1502H ;endereço onde inserir o código de segurança do aluno
InputTipoCarregamento EQU 1600H ;endereço onde inserir o tipo de carregamento
InputTempo EQU 1602H ;endereço onde inserir o tempo desejado

;endereços relativos à base de dados
Dados EQU 1000H ;endereço do início da base de dados
CodSeguranca EQU 02H ;aumento relativo ao inicio dos dados do aluno para ler o código de segurança
Saldo EQU 04H ;aumento relativo ao inicio dos dados do aluno para ler o saldo
Proximo EQU 06H ;salto a executar para ler os dados do próximo aluno


    ;CALL Display_EstadoServico
    ;CALL LimpaDisplay
    ;CALL Display_Verificacao
	
	
EscolhaCarregamento: 
	MOV R0, CustoNormal								;coloca no registo 0 o valor do custo do carregamento do tipo normal
	MOV R1, CustoSemiRapido							;coloca no registo 1 o valor do custo do carregamento do tipo semi-rápido
	MOV R2, CustoRapido								;coloca no registo 2 o valor do custo do carregamento do tipo rápido
	MOV R3, InputTipoCarregamento					;coloca no registo 3 o tipo de carregamento escolhido pelo utilizador
	CMP R3,R0										;compara o registo 3 com o registo 0
	JEQ	EscolhaTempo								;verifica se a comparação anterior é verdadeira
	CMP R3, R1										;compara o registo 3 com o registo 1
	JEQ	EscolhaTempo								;verifica se a comparação anterior é verdadeira
	CMP R3, R2										;compara o registo 3 com o registo 2
	JEQ EscolhaTempo								;verifica se a comparação anterior é verdadeira
	JMP EscolhaCarregamento							;volta para o menu inicial
EscolhaTempo:
	MOV R4, InputTempo								;coloca no registo 0 o tempo escolhido pelo utilizador
	CMP R4, 0										;se o valor do registo 0 for superior a 0, verifica o saldo do utilizador 
	JGT Fim
	JMP EscolhaTempo								;volta para o menu inicial
	
VerificaSaldo:
	MOV R5, R3										;coloca no registo 5 o custo do tipo de carregamento
	MUL R5, R4										;multiplica o registo 5 com o tempo escolhido pelo utilizador
	CMP R5, Saldo									;compara o custo do carregamento com o saldo do utilizador
	JLE ForneceEnergia								;se a verificação for verdadeira, salta para o "tag" ForneceEnergia
	JMP NãoForneceEnergia							;salta para o "tag" NãoForneceEnergia
	
ForneceEnergia:

NãoForneceEnergia:
	
Fim:
    JMP Fim
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