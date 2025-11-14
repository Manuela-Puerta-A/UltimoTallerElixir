defmodule GeneradorReportes do

  def reporte(%Sucursal{id: id, ventas_diarias: ventas}) do
    delay = Enum.random(50..120)
    :timer.sleep(delay)

    total = Enum.sum(ventas)
    promedio = total / length(ventas)
    top3 = Enum.sort(ventas, :desc) |> Enum.take(3)

    IO.puts("Reporte listo Sucursal #{id}")
    {id, %{total: total, promedio: promedio, top3: top3}}
  end

  def generar_secuencial(sucursales) do
    Enum.map(sucursales, &reporte/1)
  end

  def generar_concurrente(sucursales) do
    Enum.map(sucursales, fn sucursal ->
      Task.async(fn -> reporte(sucursal) end)
    end)
    |> Task.await_many()
  end

  def lista_sucursales do
    Enum.map(1..10, fn i ->
      ventas = Enum.map(1..30, fn _ -> :rand.uniform(1000) * 100 end)
      %Sucursal{id: i, ventas_diarias: ventas}
    end)
  end
end
