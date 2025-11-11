defmodule PreciosSecuencial do
  def ejecutar(productos) do
    Enum.map(productos, &Producto.precio_final/1)
  end
end

defmodule PreciosConcurrente do
  def ejecutar(productos) do
    productos
    |> Enum.map(&Task.async(fn -> Producto.precio_final(&1) end))
    |> Enum.map(&Task.await/1)
  end
end
