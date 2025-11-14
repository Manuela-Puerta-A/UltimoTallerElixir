defmodule Precios do

  def precio_final(%Producto{nombre: nombre, precio_sin_iva: precio, iva: iva}) do
    precio_calculado = precio * (1 + iva)
    {nombre, precio_calculado}
  end

  def calcular_secuencial(productos) do
    Enum.map(productos, &precio_final/1)
  end

  def calcular_concurrente(productos) do
    Enum.map(productos, fn producto ->
      Task.async(fn -> precio_final(producto) end)
    end)
    |> Task.await_many()
  end

  def generar_productos(cantidad) do
    Enum.map(1..cantidad, fn i ->
      %Producto{
        nombre: "Producto_#{i}",
        stock: :rand.uniform(100),
        precio_sin_iva: :rand.uniform(100) * 1000,
        iva: 0.19
      }
    end)
  end
end
