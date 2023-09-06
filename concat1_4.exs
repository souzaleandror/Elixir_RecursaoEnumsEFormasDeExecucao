defmodule MeuModulo.Concat do
  def join(s1, s2 \\ nil, separator \\ " ")

  def join(s1, s2, _separador) when is_nil(s2) do
    s1
  end

  def join(s1, s2, separator) do
    s1 <> separator <> s2
  end
end
