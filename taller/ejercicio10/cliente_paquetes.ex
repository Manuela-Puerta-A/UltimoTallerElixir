defmodule ClientePaquetes do
  @nombre_servidor :servidor_paquetes

  def preparar_paquete(paquete) do
    send(@nombre_servidor, {self(), paquete})
    receive do
      resultado -> resultado
    end
  end

  def procesar_secuencial(paquetes) do
    Enum.map(paquetes, &preparar_paquete/1)
  end

  def procesar_concurrente(paquetes) do
    Enum.map(paquetes, fn paquete ->
      Task.async(fn -> preparar_paquete(paquete) end)
    end)
    |> Task.await_many()
  end

  def finalizar_servidor do
    send(@nombre_servidor, {self(), :fin})
    receive do
      :fin -> :ok
    end
  end

  def generar_paquetes(cantidad) do
    Enum.map(1..cantidad, fn i ->
      %Paquete{
        id: i,
        peso: :rand.uniform(50),
        fragil: rem(i, 3) == 0
      }
    end)
  end
end
