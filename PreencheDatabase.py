from random import seed
from random import randint
seed()
base ="0123456789ABCDEF"
tamanho = (int)(input("Quantos alunos?\n"))
ficheiro = open("DadosAlunos.dat","w")
inicio = "11"
j=0
i=0
while i<tamanho:    
    ficheiro.write("%s %c%c\n" %(inicio + base[j//16] + base[j%16],"0" if (j+4)%8==0 or (j+2)%8==0 or (j+1)%8==0 else base[randint(0,len(base)-1)],"0" if (j+2)%8==0 or (j+1)%8==0 else base[randint(0,len(base)-1)]))
    j+=1
    if(j%8==0):
        i+=1
j=0
while j<6:
    ficheiro.write("%s %c%c\n" %("12"+ base[j//16] + base[j%16], "0" if j%2==0 else base[randint(0,len(base)-1)],base[randint(0,len(base)-1)]))
    j+=1