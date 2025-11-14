defmodule ClienteModeracion do
  @nombre_servidor :servidor_moderacion

  def moderar_comentario(comentario) do
    send(@nombre_servidor, {self(), comentario})
    receive do
      resultado -> resultado
    end
  end

  def moderar_secuencial(comentarios) do
    Enum.map(comentarios, &moderar_comentario/1)
  end

  def moderar_concurrente(comentarios) do
    Enum.map(comentarios, fn comentario ->
      Task.async(fn -> moderar_comentario(comentario) end)
    end)
    |> Task.await_many()
  end

  def finalizar_servidor do
    send(@nombre_servidor, {self(), :fin})
    receive do
      :fin -> :ok
    end
  end

  def generar_comentarios(cantidad) do
    textos = [
      "Excelente articulo, muy informativo",
      "Este es spam y contenido prohibido",
      "Me gustó mucho, gracias por compartir",
      "Visita mi sitio http://ejemplo.com"
    ]

    Enum.map(1..cantidad, fn i ->
      %Comentario{id: i, texto: Enum.random(textos)}
    end)
  end
end
