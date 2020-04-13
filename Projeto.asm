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


Inicio:
    ;CALL Display_EstadoServico
     CALL LimpaDisplay
     CALL Display_Verificacao
    JMP Fim
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

LimpaDisplay:
    PLACE 0100H
    String "                "
    String "                "
    String "                "
    String "                "
    String "                "
    String "                "
    String "                "
    PLACE 0000H

Display_Verificacao:
    PLACE 0100H
    String "  VERIFICACAO   "
    String "  INTRODUZA ID  "
    String " E CODIGO SEG.  "
    PLACE 0000H