defmodule ServidorPaquetes do
  @nombre_servidor :servidor_paquetes

  def iniciar do
    Process.register(self(), @nombre_servidor)
    IO.puts("Servidor de paquetes iniciado")
    escuchar()
  end

  defp escuchar do
    receive do
      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor finalizado")

      {cliente, paquete} ->
        resultado = preparar(paquete)
        send(cliente, resultado)
        escuchar()
    end
  end

  defp preparar(%Paquete{id: id, peso: peso, fragil: fragil}) do
    inicio = :erlang.monotonic_time(:millisecond)

    :timer.sleep(50)
    :timer.sleep(30)

    if fragil do
      :timer.sleep(80)
    end

    fin = :erlang.monotonic_time(:millisecond)
    tiempo_total = fin - inicio

    {id, tiempo_total}
  end
end
