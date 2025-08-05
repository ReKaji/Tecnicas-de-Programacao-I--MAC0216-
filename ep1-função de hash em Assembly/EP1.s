global _start
section .text
LeTeclado:
    mov rax, 0
    mov rdi, STDIN
    syscall
    ret

_start:    
;PASSO 0: le a string do teclado
    mov rsi, entrada
    mov rdx, 100100
    call LeTeclado

;PASSO 1: ajustar o tamanho da entrada, (primeira funcao no codigo python)

    dec rax
    mov [tamanho], eax ; [tamanho]= len(string)
    mov edx, 0
    mov ebx,16
    div ebx  ;edx eh o resto da divisão, eax eh o quociente
    mov r8,16 
    sub r8, rdx ;r8= resto (como no codigo em python)
    mov r9, r8
    add r9d, [tamanho]
    mov [tamanho2], r9d ;[tamanho2] = len(saidaPassoUm)
    cmp r8b, 0
    je fimpasso1 ; se o resto for igual a zero, ou seja, o numero de caracteres da string for multiplo de 16, a entrada ja esta no tamanho correto

    mov rcx, 0 ;zera o rcx
    mov ecx, [tamanho] ; rcx sera o j (contador) do nosso laco a seguir

comeco: ;laco que adicionara os caracteres (que seram iguais ao resto) para que a entrada possua um numero de caracteres divisivel por 16
    mov [entrada+ecx], r8b
    inc rcx
    cmp rcx, [tamanho2]
    jne comeco

fimpasso1:

; PASSO 2: Calculo e concatenacao do XOR (segunda funcao do codigo em Python)
;calculo do n do codigo em Python
    mov eax, [tamanho2]
    mov edx,0
    mov ebx, 16
    div ebx ; edx eh o resto, eax eh o quociente 
    xor r10, r10
    mov r10d, eax; r10=n do programa em python
    
    xor rcx, rcx ; rcx = i do programa python
    xor r9,r9 ; r9 = j do programa python
    mov ecx, 0
    xor r15,r15
    xor r14, r14
    xor r8, r8
    xor rax, rax

;lacos do codigo em Python:
inlaco1:
    mov r9,0 ;zera o j
inlaco2:

    ;calculo de i*16+j
    xor rdx,rdx
    mov eax, ecx
    mov ebx,16
    mul ebx

    shl rdx,32
    mov edx, eax ; 
    add rdx, r9 ;rdx eh o resultado

;resto do laço (linha 26 e 27 do codigo em Python)
    ;passo1[i*16+j]^novoValor (do codigo em Python)
    mov r12b, [entrada+rdx]
    xor r12b,[novovalor] ;r12= indice do vetormagico

    ;(vetorMagico[passo1[i*16+j]^novoValor])^novoBloco[j] (do codigo em Python)
    mov r15b, [vetormagico+r12]
    mov [novovalor], r15b

    mov r14b, [novoBloco+r9]
    xor [novovalor], r14b

    ; novoBloco[j]=novoValor (do codigo em Python)
    mov r8b, [novovalor]
    mov [novoBloco+r9],r8b

    add r9, 1
    cmp r9, 16
    jne inlaco2

    add rcx,1
    cmp rcx, r10
    jne inlaco1

linha28:
    ;linha 28 do codigo em Python: concatenacao da SaidaPassoUm com novoBloco
    xor rcx, rcx
    mov r13, 0


    mov edi, [tamanho2]
    mov [tamanho3], edi
    add byte [tamanho3],16
    mov ecx, [tamanho2]

inic:

    mov al,[novoBloco+r13]
    mov [entrada+ecx],al
    inc ecx
    inc r13
    cmp r13, 16
    jne inic


    
;PASSO 3: Transformacao dos n+1 blocos em apenas 3 blocos (terceira funcao do codigo Python)


    ; calculo de len(passo2)/16
    mov eax, [tamanho3]
    mov edx,0
    mov ebx, 16
    div ebx
    xor r10, r10
    mov r10d, eax; r10=len(passo2)/16 do programa em python

    xor rcx, rcx; i da funcao em python


inicioI:
    xor r15, r15 ; r15= j da funcao e python
    xor r14, r14; r14= a da funcao em python
inicioJ:
    mov r8, 16
    add r8, r15; r8=16+j

;linha 36 do codigo python
    xor rax, rax
    xor rbx, rbx
    ;calculo de i*16+j
    mov eax, ecx
    mov ebx,16
    mul ebx
    shl rdx,32
    mov edx, eax ; 
    add rdx, r15 ; rdx=i*16+j

    ;saidaPassoTres[16+j]=passo2[i*16+j]
    mov r9b, [entrada+rdx]
    mov [saidaPassoTres+r8], r9b

;linha 37 do codigo python
    ;caluclo de 2*16+j
    xor rax, rax
    xor rbx, rbx
    mov eax, 2
    mov ebx,16
    mul ebx
    shl rdx,32
    mov edx, eax ; 
    add rdx, r15 ; rdx=2*16+j
    ;saidaPassoTres[2*16+j]= (saidaPassoTres[16+j]^saidaPassoTres[j])
    mov r9b, [saidaPassoTres+r8]
    xor r9b, [saidaPassoTres+r15]
    mov [saidaPassoTres+rdx], r9b
    ;incremento do r15 (j) do laco
    add r15, 1
    cmp r15, 16
    jne inicioJ
;linha 38 do codigo python
    mov r11, 0 ;r11=temp
;incio do laco (for a in range (18):) do codigo python

inicioA:
    xor r13,r13 ;r13=k do codigo em python
inicioK:
;linha 41 do codigo python
    ;temp=saidaPassoTres[k]^vetorMagico[temp]
    mov r12b, [saidaPassoTres+r13]
    xor r12b, [vetormagico+r11]
    mov r11b, r12b
;linha 42 do codigo python
    ;saidaPassoTres[k]=temp
    mov [saidaPassoTres+r13],r11b

    add r13, 1
    cmp r13, 48
    jne inicioK
;linha 43 do codigo python
    ;temp=(temp+a)%256 
    add r11, r14
    mov ax, r11w
    mov bx, 256
    xor rdx, rdx
    div bx ;dx é o resto

    mov r11, rdx

    add r14, 1
    cmp r14, 18
    jne inicioA

    add rcx, 1
    cmp rcx, r10
    jne inicioI




;PASSO 4: definicao do hash como um valor em hexadecimal (quarta funcao do codigo python)

; transforma um numero em hexadecimal
    mov r8, 0
    mov rcx,0
inicio:
    ;divide os bytes da SaidaPassoTres por 16
    mov ax,0
    mov al,[saidaPassoTres+r8]
    mov bl, 16
    div bl ; resto em ah e quociente em al

    ; se o quociente for maior que 9, ele sera um caractere, se for menor, sera um numero
    cmp al, 9
    jg caracteres
    ; transforma o numero hexadecimal em seu correspondente em ascii
    add al, 48
    mov [hex+rcx], al
    inc rcx
    jmp resto

caracteres:
    add al, 87
    mov [hex+rcx], al
    inc rcx
    ;transforma o resto da divisao em seu correspondente em ascii
resto:
    cmp ah, 9
    jg caractere

    add ah, 48
    mov [hex+rcx], ah
    inc rcx
    jmp final

caractere:    

    add ah, 87
    mov [hex+rcx],ah
    inc rcx
    
;incremento do laco que permite que todos os 16 primeiros bytes de SaidaPassoTres passem pela laco
final:
    add r8,1
    cmp r8, 16
    jne inicio


; print do hash
    mov rax, 1
    mov rdi, 1
    mov rsi, hex
    mov rdx, 33
    syscall

; exit
    mov rax, 60
    mov rdi,0
    syscall



section .data
STDIN: equ 0
STDOUT: equ 1
novovalor: db 0
novoBloco: db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
vetormagico:db 122, 77, 153, 59, 173, 107, 19, 104, 123, 183, 75, 10,114, 236, 106, 83, 117, 16, 189, 211, 51, 231, 143, 118, 248, 148, 218,245, 24, 61, 66, 73, 205, 185, 134, 215, 35, 213, 41, 0, 174, 240, 177,195, 193, 39, 50, 138, 161, 151, 89, 38, 176, 45, 42, 27, 159, 225, 36,64, 133, 168, 22, 247, 52, 216, 142, 100, 207, 234, 125, 229, 175, 79,220, 156, 91, 110, 30, 147, 95, 191, 96, 78, 34, 251, 255, 181, 33, 221,139, 119, 197, 63, 40, 121, 204, 4, 246, 109, 88, 146, 102, 235, 223,214, 92, 224, 242, 170, 243, 154, 101, 239, 190, 15, 249, 203, 162, 164,199, 113, 179, 8, 90, 141, 62, 171, 232, 163, 26, 67, 167, 222, 86, 87,71, 11, 226, 165, 209, 144, 94, 20, 219, 53, 49, 21, 160, 115, 145, 17,187, 244, 13, 29, 25, 57, 217, 194, 74, 200, 23, 182, 238, 128, 103,140, 56, 252, 12, 135, 178, 152, 84, 111, 126, 47, 132, 99, 105, 237,186, 37, 130, 72, 210, 157, 184, 3, 1, 44, 69, 172, 65, 7, 198, 206,212, 166, 98, 192, 28, 5, 155, 136, 241, 208, 131, 124, 80, 116, 127,202, 201, 58, 149, 108, 97, 60, 48, 14, 93, 81, 158, 137, 2, 227, 253,68, 43, 120, 228, 169, 112, 54, 250, 129, 46, 188, 196, 85, 150, 6, 254,180, 233, 230, 31, 76, 55, 18, 9, 32, 82, 70
saidaPassoTres: db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hex: db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10


section .bss

entrada: resb 100500
tamanho: resb 4
tamanho2:resb 4
tamanho3: resb 4    
tam_mensagem: resb 1
