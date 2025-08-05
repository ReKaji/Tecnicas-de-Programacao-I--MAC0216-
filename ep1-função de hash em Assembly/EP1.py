
def saidaPassoUm(string):
    saidaPassoUm = []
    for i in range (len(string)):
        asc=ord(string[i])
        saidaPassoUm.append(asc)
    
    resto = 16-len(string)%16
    if resto == 0:
        
        return saidaPassoUm
    else:
        for j in range (resto):
            saidaPassoUm.append(resto)
        
        return saidaPassoUm

def saidaPassoDois(passo1):
    n= len(passo1)/16
    novoBloco= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]    
    novoValor=0
    vetorMagico = [122, 77, 153, 59, 173, 107, 19, 104, 123, 183, 75, 10,114, 236, 106, 83, 117, 16, 189, 211, 51, 231, 143, 118, 248, 148, 218,245, 24, 61, 66, 73, 205, 185, 134, 215, 35, 213, 41, 0, 174, 240, 177,195, 193, 39, 50, 138, 161, 151, 89, 38, 176, 45, 42, 27, 159, 225, 36,64, 133, 168, 22, 247, 52, 216, 142, 100, 207, 234, 125, 229, 175, 79,220, 156, 91, 110, 30, 147, 95, 191, 96, 78, 34, 251, 255, 181, 33, 221,139, 119, 197, 63, 40, 121, 204, 4, 246, 109, 88, 146, 102, 235, 223,214, 92, 224, 242, 170, 243, 154, 101, 239, 190, 15, 249, 203, 162, 164,199, 113, 179, 8, 90, 141, 62, 171, 232, 163, 26, 67, 167, 222, 86, 87,71, 11, 226, 165, 209, 144, 94, 20, 219, 53, 49, 21, 160, 115, 145, 17,187, 244, 13, 29, 25, 57, 217, 194, 74, 200, 23, 182, 238, 128, 103,140, 56, 252, 12, 135, 178, 152, 84, 111, 126, 47, 132, 99, 105, 237,186, 37, 130, 72, 210, 157, 184, 3, 1, 44, 69, 172, 65, 7, 198, 206,212, 166, 98, 192, 28, 5, 155, 136, 241, 208, 131, 124, 80, 116, 127,202, 201, 58, 149, 108, 97, 60, 48, 14, 93, 81, 158, 137, 2, 227, 253,68, 43, 120, 228, 169, 112, 54, 250, 129, 46, 188, 196, 85, 150, 6, 254,180, 233, 230, 31, 76, 55, 18, 9, 32, 82, 70]
    for i in range (int(n)):
        for j in range (16):
            novoValor= (vetorMagico[passo1[i*16+j]^novoValor])^novoBloco[j]
            novoBloco[j]=novoValor
    saidaPassoDois= passo1 + novoBloco
    return saidaPassoDois

def saidaPassoTres(passo2):
    saidaPassoTres=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    vetorMagico = [122, 77, 153, 59, 173, 107, 19, 104, 123, 183, 75, 10,114, 236, 106, 83, 117, 16, 189, 211, 51, 231, 143, 118, 248, 148, 218,245, 24, 61, 66, 73, 205, 185, 134, 215, 35, 213, 41, 0, 174, 240, 177,195, 193, 39, 50, 138, 161, 151, 89, 38, 176, 45, 42, 27, 159, 225, 36,64, 133, 168, 22, 247, 52, 216, 142, 100, 207, 234, 125, 229, 175, 79,220, 156, 91, 110, 30, 147, 95, 191, 96, 78, 34, 251, 255, 181, 33, 221,139, 119, 197, 63, 40, 121, 204, 4, 246, 109, 88, 146, 102, 235, 223,214, 92, 224, 242, 170, 243, 154, 101, 239, 190, 15, 249, 203, 162, 164,199, 113, 179, 8, 90, 141, 62, 171, 232, 163, 26, 67, 167, 222, 86, 87,71, 11, 226, 165, 209, 144, 94, 20, 219, 53, 49, 21, 160, 115, 145, 17,187, 244, 13, 29, 25, 57, 217, 194, 74, 200, 23, 182, 238, 128, 103,140, 56, 252, 12, 135, 178, 152, 84, 111, 126, 47, 132, 99, 105, 237,186, 37, 130, 72, 210, 157, 184, 3, 1, 44, 69, 172, 65, 7, 198, 206,212, 166, 98, 192, 28, 5, 155, 136, 241, 208, 131, 124, 80, 116, 127,202, 201, 58, 149, 108, 97, 60, 48, 14, 93, 81, 158, 137, 2, 227, 253,68, 43, 120, 228, 169, 112, 54, 250, 129, 46, 188, 196, 85, 150, 6, 254,180, 233, 230, 31, 76, 55, 18, 9, 32, 82, 70]
    for i in range (int(len(passo2)/16)):
        for j in range(16):
            saidaPassoTres[16+j]=passo2[i*16+j]
            saidaPassoTres[2*16+j]= (saidaPassoTres[16+j]^saidaPassoTres[j])
        temp=0
        for a in range (18):
            for k in range (48):
                temp=saidaPassoTres[k]^vetorMagico[temp]
                saidaPassoTres[k]=temp
            temp=(temp+a)%256 
     
    return saidaPassoTres

def saidaPassoQuatro(passo3):
    vetor_saida=[]
    saidaPassoQuatro=''
    for i in range (16):
        hexadecimal= hex(passo3[i])
        if passo3[i]<16:
            vetor_saida.append('0'+hexadecimal[2:])
        else:
            vetor_saida.append(hexadecimal[2:])
    
    for j in range (len(vetor_saida)):
        saidaPassoQuatro= saidaPassoQuatro+str(vetor_saida[j])
    return saidaPassoQuatro

def main():
    string = input()
    passo1=saidaPassoUm(string)
    passo2= saidaPassoDois(passo1)
    passo3=saidaPassoTres(passo2)
    print(saidaPassoQuatro(passo3))


main()