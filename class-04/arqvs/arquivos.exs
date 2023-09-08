defmodule MeuModulo.Arquivos do
    def ler(arquivo) do
      {:error, erro} = File.read(arquivo)
      erro
    end

    def ler2(arquivo) do
      File.read!(arquivo)
    end

    def ler3(arquivo) do
      case File.read(arquivo) do
        {:ok, conteudo} -> IO.puts(conteudo)
        {:error, erro} -> case erro do
          :enoent -> "arquivo inexsistente"
          :eacces -> "Arquivo sem permissao de leitura"
          _ -> "Erro Desconhecido"
        end
      end
    end

    ## Or

    def ler4(arquivo) do
      case File.read(arquivo) do
        {:ok, conteudo} -> IO.puts(conteudo)
        {:error, :enoent} -> "arquivo inexsistente"
        {:error, :eacces} -> "arquivo sem permissao de leitura"
        _ -> "erro Desconhecido"
      end
    end

end
