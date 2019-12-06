global substring ; em c -> char * substring (char * ondebuscar,char * o que buscar);

section .text
extern strlen
extern push_all
extern pop_all
substring:

  push	ebp
  mov	ebp,esp
  push	esi;
  push	edi;
  mov	esi,[ebp+12];esi tem o indereço do primeiro byte da string a ser buscada
  mov	edi,[ebp+8];edi	 tem o indereço do primeiro byte da string onde vamos procurar pela string indereçada por esi
  ;pegando o tamanho do que deve ser procurado 
  ;{
  push	esi
  call strlen
  mov 	ebx,eax
  add	esp,byte 8
  ;}
  ;pegando o tamanho de onde deve ser procurado 
  ;{
  push eax
  push edi
  call strlen
  mov	ecx,eax
  pop	eax
  add	esp,byte 8
  ;}

  ;acha um byte que esta em al  na string indereçada por edi
 cld;preparando para a comparação
.loop:
  mov	eax,[esi]
  repne	scasb; enquanto o byte endereçado por esi for diferente do byte indereçado por edi  eu incremento edi e esi de 1
  jz	.comp;achou a primeira letra da string  caso contrario acaba
  or	ecx,ecx;se ecx não é xero então vamos para loop
  jnz	.loop
  .fim: 
  mov	eax,edi;
  pop 	edi
  pop 	esi
  pop 	ebp
  ret
.comp:
  or	ebx,ebx
  jnz	.move
  jmp 	.fim
  .move:
  inc esi
  dec ebx
  mov eax,[esi]
  cmp eax,[edi]
  inc edi
  jz .move
  mov esi,[ebp+12]
  jmp .loop