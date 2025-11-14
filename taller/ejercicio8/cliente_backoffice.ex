defmodule ClienteBackoffice do
  @nombre_servidor :servidor_backoffice

  def ejecutar_tarea(tarea) do
    send(@nombre_servidor, {self(), tarea})
    receive do
      resultado ->
        IO.puts(resultado)
        resultado
    end
  end

  def ejecutar_secuencial(tareas) do
    Enum.map(tareas, &ejecutar_tarea/1)
  end

  def ejecutar_concurrente(tareas) do
    Enum.map(tareas, fn tarea ->
      Task.async(fn -> ejecutar_tarea(tarea) end)
    end)
    |> Task.await_many()
  end

  def finalizar_servidor do
    send(@nombre_servidor, {self(), :fin})
    receive do
      :fin -> :ok
    end
  end

  def lista_tareas do
    [
      :reindex, :purge_cache, :build_sitemap, :backup,
      :reindex, :purge_cache, :build_sitemap,
      :backup, :reindex, :purge_cache
    ]
  end
end
