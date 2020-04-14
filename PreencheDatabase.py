from random import seed
from random import randint
seed(1)
baseNumerica ="0123456789ABCDEF"
tamanho = (int)(input("Quantos alunos?\n"))
base = open("DadosAlunos.dat","w")
inicio = 3000
i=0
while i<tamanho:
    base.write("%d %c%c\n" %(inicio,"0" if inicio+2%6==0 else baseNumerica[randint(0,len(baseNumerica)-1)],baseNumerica[randint(0,len(baseNumerica)-1)]))
    inicio+=1
    if(inicio%6==0):
        i+=1