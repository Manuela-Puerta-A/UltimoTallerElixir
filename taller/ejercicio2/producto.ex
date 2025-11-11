defmodule Producto do
  defstruct [:nombre, :precio_sin_iva, :iva]

  def precio_final(p) do
    {p.nombre, p.precio_sin_iva * (1 + p.iva)}
  end
end
