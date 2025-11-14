defmodule ServidorBackoffice do
  @nombre_servidor :servidor_backoffice

  def iniciar do
    Process.register(self(), @nombre_servidor)
    IO.puts("Servidor de backoffice iniciado")
    escuchar()
  end

  defp escuchar do
    receive do
      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor finalizado")

      {cliente, tarea} ->
        resultado = ejecutar(tarea)
        send(cliente, resultado)
        escuchar()
    end
  end

  defp ejecutar(tarea) do
    case tarea do
      :reindex ->
        :timer.sleep(200)
        "OK tarea reindex"

      :purge_cache ->
        :timer.sleep(100)
        "OK tarea purge_cache"

      :build_sitemap ->
        :timer.sleep(150)
        "OK tarea build_sitemap"

      :backup ->
        :timer.sleep(300)
        "OK tarea backup"

      _ ->
        "Tarea desconocida"
    end
  end
end
