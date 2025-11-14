defmodule ClienteDescuentos do
  @nombre_servidor :servidor_descuentos

  def calcular_carrito(carrito) do
    send(@nombre_servidor, {self(), carrito})
    receive do
      resultado -> resultado
    end
  end

  def procesar_secuencial(carritos) do
    Enum.map(carritos, &calcular_carrito/1)
  end

  def procesar_concurrente(carritos) do
    Enum.map(carritos, fn carrito ->
      Task.async(fn -> calcular_carrito(carrito) end)
    end)
    |> Task.await_many()
  end

  def finalizar_servidor do
    send(@nombre_servidor, {self(), :fin})
    receive do
      :fin -> :ok
    end
  end

  def generar_carritos(cantidad) do
    Enum.map(1..cantidad, fn i ->
      items = Enum.map(1..5, fn _ -> :rand.uniform(100) * 10 end)
      cupon = rem(i, 2) == 0
      %Carrito{id: i, items: items, cupon: cupon}
    end)
  end
end
