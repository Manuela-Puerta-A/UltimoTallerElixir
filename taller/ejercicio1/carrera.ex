defmodule CarreraSecuencial do
  def ejecutar(cars) do
    Enum.map(cars, &Car.simular_carrera/1)
    |> Enum.sort_by(fn {_, tiempo} -> tiempo end)
  end

  def mostrar_ranking(resultados) do
    IO.puts("\n=== RANKING SECUENCIAL ===")
    Enum.with_index(resultados, 1)
    |> Enum.each(fn {{piloto, tiempo}, pos} ->
      IO.puts("#{pos}. #{piloto} - #{tiempo}ms")
    end)
  end
end

defmodule CarreraConcurrente do
  def ejecutar(cars) do
    cars
    |> Enum.map(&Task.async(fn -> Car.simular_carrera(&1) end))
    |> Enum.map(&Task.await(&1, :infinity))
    |> Enum.sort_by(fn {_, tiempo} -> tiempo end)
  end

  def mostrar_ranking(resultados) do
    IO.puts("\n=== RANKING CONCURRENTE ===")
    Enum.with_index(resultados, 1)
    |> Enum.each(fn {{piloto, tiempo}, pos} ->
      IO.puts("#{pos}. #{piloto} - #{tiempo}ms")
    end)
  end
end
