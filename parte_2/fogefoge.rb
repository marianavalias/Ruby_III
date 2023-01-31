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
  movimentos = { #array associativo ({}) 
      "W" => [-1, 0], #associa o elemento da esquerda com o da direita (=>) | String => array 
      "S" => [+1, 0],
      "A" => [0, -1],
      "D" => [0, +1]
      }
  movimento = movimentos[direcao]
  heroi[0] += movimento[0]
  heroi[1] += movimento[1]
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
  
  valor_atual = mapa[posicao[0]][posicao[1]]
  if valor_atual == "X" || valor_atual == "F" 
    return false 
  end
  true
end

def move_fantasma(mapa, linha, coluna)
  posicao = [linha, coluna + 1]
  if posicao_valida? mapa, posicao
    mapa[linha][coluna] = " "
    mapa[posicao[0]][posicao[1]] = "F"
  end
end

def move_fantasmas(mapa)
  caracter_do_fantasma = "F"
  mapa.each_with_index do |linha_atual, linha|
    linha_atual.chars.each_with_index do |caracter_atual, coluna| #chars, array de caracteres
      eh_fantasma = caracter_atual == caracter_do_fantasma
      if eh_fantasma
        move_fantasma mapa, linha, coluna
      end
    end
    end
end

def joga(nome)
  mapa = le_mapa 2 #alteração de mapa

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

    move_fantasmas mapa
  end
end

def inicia_fogefoge
  nome = da_boas_vindas
  joga nome
end
