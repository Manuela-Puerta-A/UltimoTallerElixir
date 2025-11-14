defmodule ServidorModeracion do
  @nombre_servidor :servidor_moderacion
  @palabras_prohibidas ["spam", "prohibido", "ilegal"]

  def iniciar do
    Process.register(self(), @nombre_servidor)
    IO.puts("Servidor de moderación iniciado")
    escuchar()
  end

  defp escuchar do
    receive do
      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor finalizado")

      {cliente, comentario} ->
        resultado = moderar(comentario)
        send(cliente, resultado)
        escuchar()
    end
  end

  defp moderar(%Comentario{id: id, texto: texto}) do
    delay = Enum.random(5..12)
    :timer.sleep(delay)

    texto_lower = String.downcase(texto)

    tiene_prohibidas = Enum.any?(@palabras_prohibidas, fn palabra ->
      String.contains?(texto_lower, palabra)
    end)

    muy_largo = String.length(texto) > 500
    tiene_links = String.contains?(texto, "http")

    status = if tiene_prohibidas or muy_largo or tiene_links do
      :rechazado
    else
      :aprobado
    end

    {id, status}
  end
end
