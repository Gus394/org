.data
  Matriz_C: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  Matriz_B: .word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  Matriz_A: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99

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
  addi t0, zero, 0   # Inicializa o contador de colunas
  la t1, Matriz_A
  la t2, Matriz_B
  la t3, Matriz_C
  
  addi t5, zero, 44 # Faz um calculo para descobrir os enderecos relevantes em cada linha
  addi t4, zero, 4
  mul t6, t4, s7
  sub t5, t5, t6
  
  addi t4, zero, 0 # Inicializa o contador de linhas

loop_lc:
  lw a0, 0(t1)         # Carrega o elemento de A
  lw a1, 0(t2)         # Carrega o elemento de B
  add a2, a0, a1     # Soma os elementos de A e B
  sw a2, 0(t3)        # Armazena o resultado em C
  
  addi t0, t0, 1       # Incrementa o contador
  
  beq t0, s7, mudar_linha # Se atingir o limite do contador, pula para a prox linha. Limite informado pelo input

  addi t1, t1, 4       # Avanca para o proximo elemento A (4 bytes)
  addi t2, t2, 4       # Avanca para o proximo elemento B (4 bytes)
  addi t3, t3, 4       # Avanca para o proximo elemento C (4 bytes)

  j loop_lc
  
mudar_linha: 
  add t1, t1, t5
  add t2, t2, t5
  add t3, t3, t5
  
  # Incrementa o contador de linhas e reseta o contador de colunas
  addi t4, t4, 1
  addi t0, zero, 0
  
  blt t4, s7, loop_lc

  j fim
  
###########################################################

coluna_linha:
  addi t0, zero, 0   # Inicializa o contador de linhas
  la t1, Matriz_A
  la t2, Matriz_B
  la t3, Matriz_C
  
  addi t5, zero, 40 # Faz um calculo para descobrir os enderecos relevantes em cada linha
  mul t5, t5, s7
  addi t4, zero, -1
  mul t5, t5, t4
  
  addi t4, zero, 0 # Inicializa o contador de colunas

loop_cl:
  lw a0, 0(t1)         # Carrega o elemento de A
  lw a1, 0(t2)         # Carrega o elemento de B
  add a2, a0, a1     # Soma os elementos de A e B
  sw a2, 0(t3)        # Armazena o resultado em C
 
  addi t0, t0, 1       # Incrementa o contador

  addi t1, t1, 40     # Avanca para o proximo elemento A (40 bytes)
  addi t2, t2, 40     # Avanca para o proximo elemento B (40 bytes)
  addi t3, t3, 40     # Avanca para o proximo elemento C (40 bytes)

  beq t0, s7, mudar_coluna # Se atingir o limite do contador, pula para a prox coluna. Limite informado pelo input
  j loop_cl
 
mudar_coluna: 
  addi t1, t1, 4
  addi t2, t2, 4
  addi t3, t3, 4
  
  add t1, t1, t5
  add t2, t2, t5
  add t3, t3, t5
  
  # Incrementa o contador de colunas e reseta o contador de linhas
  addi t4, t4, 1
  addi t0, zero, 0
  
  blt t4, s7, loop_cl

  j fim
 
###########################################################

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
  add s0, zero, a0

  addi s11, zero, 0
  addi s10, zero, 2
  blt s0, s11, invalid2
  bge s0, s10, invalid2

  bnez  s0, coluna_linha  # 1
  beqz  s0, linha_coluna  # 0
 
fim:
