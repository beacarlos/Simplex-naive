# Beatriz Carlos Da Silva - Ciencia da Computação - 20182045050503

#Matriz A - todos os coenficientes das variaveis das restrições.
A = [1 3 1 0 0; -1 2 0 1 0; 1 1 0 0 1];
#Matriz b - todas as respostas das restrições.
b = [9; 4; 6];
#Matriz c - Coeficientes da função custo.
c = [-2; 3; 0; 0; 0];

#Linhas e colunas da matriz A.
m = size(A, 1); #3
n = size(A, 2); #5

#Iniciando X
X = zeros(n,1);

#Iniciando base e matriz B.
base = (1:m);
B = A(:,base);

#Iniciando o meu Xb.
X(base) = inv(B)*b;

#{
display(base);
display(B);
printf("Xb = \n");
disp(X(base));
printf("\n");
display(X);
#}

#Verificação para que Xb seja sempre positivo.
while(isempty(find(X<0)) == 0),
  #Randomiza permutando os numeros de 1 a n.
  colunas_randomizadas = randperm(n);
  #display(colunas_randomizadas);
  #criando um nova base.
  base = colunas_randomizadas(1:m);
  #criando uma nova matriz B.
  B = A(:,base);
  #Xb
  X(base) = inv(B)*b;
endwhile

#{
display(base);
display(B);
printf("Xb = \n");
disp(X(base));
printf("\n");
display(X);
#}

while(true)
  #custo reduzido
  custo_reduzido = (c') - ((c(base)') * inv(B)) * A;
  
  #caso não tiver nenhum negativo no custo_reduzido.
  if(isempty(find(custo_reduzido<0)) == 1)
    #Mostra a solução otima.
    disp('A soluçao é otima:');  
    display(X);
    
    #Mostra o custo otimo.
    disp('Valor do custo ótimo:'); 
    custo_otimo = (c')*X; 
    display(custo_otimo);
    
    #Mostra a base.
    disp('Base:');
    display(base);
    
    disp("Fim do programa. bye.");
    break; 
  endif
  
  #Busca valores candidatos ao j.
  j_candidatos = find(custo_reduzido < 0);
  #Pegar como j_candidatos está em ordem crescente, eu pego o ultimo j no vetor por ele ser o maior.
  j = j_candidatos(end);
  
  %Calculo do NOVO X%
  % x = x + teta * d%
  #display(X);
  
  #Direção factivel.
  #Definimos o d como nulo.
  d = zeros(n,1); 
  #Define o d(j) como 1.
  d(j) = 1; 
  #Define d da base atual.
  d(base) = (-1) * inv(B)*A(:,j); 
  
  #pega os indices de d negativos.
  indices_negativos_d = find(d<0);
  #{
  display(d);
  display(indices_negativos_d);
  #}
  
  #Calculo do teta.
  teta = (-1) * X(indices_negativos_d) ./ d(indices_negativos_d); 
  #Tirando todos os valores nulos do teta.
  teta(find(teta == 0)) = [];
  #Pegando o valor mínimo;
  teta_min = min(teta); %menor valor de teta
  
  #{
  display(teta);
  display(teta_min);
  #}
  
  #Nova possivel solução otima.
  X = X + (teta_min * d);
  #display(X);
  
  #Procurando o valores nulos de x (degenerado).
  degenerado = find(X == 0);
  
  #Se tiver mais de n-m nulos.
  if(size(degenerado,1) > (n - m)), 
    disp('solução degenerada');
    disp(X);
    break;
  endif
  
  #Valor da base que vai sair.
  r = find(base == degenerado);
  #Posiçao da base referente ao valor que vai sair.
  s = find(base == r); 
  
  #Troca valores da base um sai e o j entra.
  base(s) = j;
  #Ordena  vetor base em ordem crescente.
  base = sort(base);
  
  #Calcula nova matriz base.
  B = A(:,base);  
endwhile