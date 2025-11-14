defmodule ServidorDescuentos do
  @nombre_servidor :servidor_descuentos

  def iniciar do
    Process.register(self(), @nombre_servidor)
    IO.puts("Servidor de descuentos iniciado")
    escuchar()
  end

  defp escuchar do
    receive do
      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor finalizado")

      {cliente, carrito} ->
        resultado = calcular_total(carrito)
        send(cliente, resultado)
        escuchar()
    end
  end

  defp calcular_total(%Carrito{id: id, items: items, cupon: cupon}) do
    delay = Enum.random(5..15)
    :timer.sleep(delay)

    subtotal = Enum.sum(items)
    descuento_cupon = if cupon, do: subtotal * 0.10, else: 0
    total = subtotal - descuento_cupon

    {id, total}
  end
end
