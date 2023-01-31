require_relative 'ui'

def le_mapa(numero) #mapa array de strings
  arquivo = ("mapa#{numero}.txt")
  texto = File.read arquivo #extração 
  mapa = texto.split "\n"
end

def encontra_jogador(mapa)
  caracter_do_heroi = "H"
  mapa.each_with_index do |linha_atual, linha| #maneira mais funcional, sendo o mais usado por programador ruby (idiomatismo) #linha (0, 1, 2, 3, 4 )             #each, para cada elemento | do (faça o seguinte), linha atual (caracteres, valor do array) | Passar por cada elemento até a linha atual
    coluna_do_heroi = linha_atual.index caracter_do_heroi #para achar posição
    
    if coluna_do_heroi #se devolver nil, contunia e sai fora
      return [linha, coluna_do_heroi]
    end
  end
  # não achei!
end

def calcula_nova_posicao(heroi, direcao)
  heroi = heroi.dup
  case direcao
    when "W"
      heroi[0] -= 1 #subindo diminuir em 1 a linha 
    when "S"
      heroi[0] += 1 #soma na linha indo para baixo 
    when "A"
      heroi[1] -= 1 #esquerda e tirar 1, coluna 
    when "D"
      heroi[1] += 1 #direira e somar 1, coluna 
  end
  heroi
end

def posicao_valida?(mapa, posicao) 
  linhas = mapa.size
  colunas = mapa[0].size
  estourou_linhas = posicao [0] < 0 || posicao [0] >= linhas #ou > esse ou esse e já devolve o true | &&, esse e esse 
  estourou_colunas = posicao [1] < 0 || posicao [1] >= colunas

  if estourou_linhas || estourou_colunas
    return false 
  end
  
  if mapa[posicao[0]][posicao[1]] == "X" #murro
    return false 
  end
  true
end

def joga(nome)
  mapa = le_mapa 1

  while true
    desenha mapa
    direcao = pede_movimento
    

    heroi = encontra_jogador mapa
    nova_posicao = calcula_nova_posicao heroi, direcao

    if !posicao_valida? mapa, nova_posicao #negando o que retorna, pega o resultado e nega (inversão)
      next
    end

    mapa[heroi[0]][heroi[1]] = " " #posição "antiga" #array, vetor de duas posições 
    mapa[nova_posicao[0]][nova_posicao[1]] = "H" #posição "nova"
  end
end

def inicia_fogefoge
  nome = da_boas_vindas
  joga nome
end
