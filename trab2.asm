.data
	Matriz_C: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	Matriz_B: .word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	Matriz_A: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99
	tam: .word 100
	
	msg: .asciz "Entre com a ordem das matrizes quadradas (max. =  10, min. = 1).\n"
	msg2: .asciz "Valor invalido, tente novamente.\n"
	msg3: .asciz "Digite 0 = linha-coluna OU 1 = coluna-linha:\n"
	e2: .asciz "]: "
	e3: .asciz "\nV["

.text
	j main

invalid: # Funcao para dizer que o input do usuario eh invalido
	addi a7, zero, 4
	la   a0, msg2
	ecall
        
        j main
        
invalid2: # Funcao para dizer que o input do usuario eh invalido
	addi a7, zero, 4
	la   a0, msg2
	ecall
        
        j main_parte2
        
# Função para somar duas matrizes e armazenar o resultado em uma terceira matriz
linha_coluna:
  addi t0, zero, 0   # Inicializa o contador
  la t1, Matriz_A
  la t2, Matriz_B
  la t3, Matriz_C
  mul t4, s7, s7
  

loop_lc:
  lw a0, 0(t1)         # Carrega o elemento do vetor A
  lw a1, 0(t2)         # Carrega o elemento do vetor B
  add a2, a0, a1       # Soma os elementos dos vetores A e B
  sw a2, 0(t3)         # Armazena o resultado no vetor C

  addi t0, t0, 1       # Incrementa o contador

  addi t1, t1, 4       # Avanca para o proximo elemento do vetor A (4 bytes)
  addi t2, t2, 4       # Avanca para o proximo elemento do vetor B (4 bytes)
  addi t3, t3, 4       # Avanca para o proximo elemento do vetor C (4 bytes)

  #li t4, 100           # Valor de comparacao
  blt t0, t4, loop_lc  # Verifica se ainda ha elementos para percorrer

  #ret
  j fim
  
coluna_linha:
 addi t0, zero, 0   # Inicializa o contador
 add t4, zero, s7
 #addi t4, zero, 10  # valor maximo do contador
 addi t5, zero, 0

 addi t6, zero, -400
 addi s9, zero, 0
 mul s8, s7, s7 #depois remover essa linha de baixo
 #addi s8, zero, 100

 la t1, Matriz_A
 la t2, Matriz_B
 la t3, Matriz_C

loop_cl:
  lw a0, 0(t1)      # Carrega o elemento do vetor A
  lw a1, 0(t2)      # Carrega o elemento do vetor B
  add a2, a0, a1    # Soma os elementos dos vetores A e B
  sw a2, 0(t3)      # Armazena o resultado no vetor C

  addi t0, t0, 1    # Incrementa o contador
  addi s9, s9, 1

  addi t1, t1, 40
  addi t2, t2, 40
  addi t3, t3, 40
  
  blt t0, t4, loop_cl
  addi t6, t6, 4

  add t1, t1, t6
  add t2, t2, t6
  add t3, t3, t6
  
  add t1, t1, t5
  add t2, t2, t5
  add t3, t3, t5
  
  #addi t0, t0, -10
  sub t0, t0, s7
  addi t5, t5, -4 
  
  blt s9, s8, loop_cl

  #ret
  j fim
  
# Função para imprimir a matriz
imprimir_matriz:

	add  s0, zero, a0 # Vetor
	add  t1, zero, a1 # Tamanho do vetor
	addi t0, zero, 0 # i = 0 novamente
for2:
	#TESTE DO FOR
	beq t0, t1, fimfor2

	#ESCREVER TEXTO
	addi a7, zero, 4	# Carregar o serviço de imprimir string
	la   a0, e3
	ecall
	
	#ESCREVER INTEIRO
	addi a7, zero, 1	# Carregar o serviço de imprimir inteiro
	add  a0, zero, t0       # Passa para a0 o valor que deve ser escrito
	ecall
	
	#ESCREVER TEXTO
	addi a7, zero, 4	# Carregar o serviço de imprimir string
	la   a0, e2
	ecall
	
	#LER O VETOR
	slli t2, t0, 2	
	add t3, s0, t2
	lw  a0, 0(t3)
	
	#ESCREVER INTEIRO
	addi a7, zero, 1	# Carregar o serviço de imprimir inteiro
	ecall
	
	addi t0, t0, 1 # i++ 
jal zero, for2

fimfor2:
	jr ra

main:

 # Pede ao usuario a ordem das matrizes
 addi a7, zero, 4	# Carregar o servico de imprimir string
 la   a0, msg
 ecall

 # Ler um inteiro representando a ordem das matrizes
 addi a7, zero, 5	# Carregar o servico de ler um inteiro
 ecall
 add s0, zero, a0  # Passa para o s0 o valor que estava em a0

 # Nao pode ser menor que 1 ou maior/igual a 1
 addi s11, zero, 1
 addi s10, zero, 11
 blt s0, s11, invalid
 bge s0, s10, invalid
 add s7, zero, s0 # salvar aqui o tamanho

main_parte2:

 # Pede ao usuario como as  matrizes serao percorridas: 0 = linha-coluna, 1 = coluna-linha
 addi a7, zero, 4	# Carregar o servico de imprimir string
 la   a0, msg3
 ecall

 # Ler um inteiro representando como as matrizes sao percorridas
 addi a7, zero, 5	# Carregar o servico de ler um inteiro
 ecall
 add s0, zero, a0  # Passa para o s0 o valor que estava em a0

 addi s11, zero, 0
 addi s10, zero, 2
 blt s0, s11, invalid2
 bge s0, s10, invalid2

 bnez  s0, coluna_linha  # 1
 beqz  s0, linha_coluna  # 0
 #jal linha_coluna
 #jal coluna_linha
 
 fim:

 #la  a0, Matriz_C
 #addi a1, zero, 100
 #jal imprimir_matriz
