defmodule LimpiezaResenas do

  def limpiar(%Review{id: id, texto: texto}) do
    delay = Enum.random(5..15)
    :timer.sleep(delay)

    texto_limpio = texto
    |> String.downcase()
    |> quitar_tildes()
    |> quitar_stopwords()

    {id, texto_limpio}
  end

  defp quitar_tildes(texto) do
    texto
    |> String.replace("á", "a")
    |> String.replace("é", "e")
    |> String.replace("í", "i")
    |> String.replace("ó", "o")
    |> String.replace("ú", "u")
  end

  defp quitar_stopwords(texto) do
    stopwords = ["el", "la", "de", "y", "a", "en"]
    palabras = String.split(texto, " ")

    palabras
    |> Enum.filter(fn palabra -> palabra not in stopwords end)
    |> Enum.join(" ")
  end

  def procesar_secuencial(resenas) do
    Enum.map(resenas, &limpiar/1)
  end

  def procesar_concurrente(resenas) do
    Enum.map(resenas, fn resena ->
      Task.async(fn -> limpiar(resena) end)
    end)
    |> Task.await_many()
  end

  def generar_resenas(cantidad) do
    textos = [
      "El producto es excelente y de buena calidad",
      "La atención fue mala y el servicio lento",
      "Muy recomendado para toda la familia",
      "No cumplió con mis expectativas"
    ]

    Enum.map(1..cantidad, fn i ->
      %Review{id: i, texto: Enum.random(textos)}
    end)
  end
end
