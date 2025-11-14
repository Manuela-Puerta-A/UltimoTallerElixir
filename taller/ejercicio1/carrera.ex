defmodule Carrera do
  @vueltas 3

  def simular_carrera(%Car{piloto: piloto, vuelta_ms: vms, pit_ms: pms}) do
    total = Enum.reduce(1..@vueltas, 0, fn _, acc ->
      :timer.sleep(vms)
      acc + vms
    end)

    tiempo_total = total + pms
    IO.puts("#{piloto} terminó con #{tiempo_total} ms.")
    {piloto, tiempo_total}
  end

  def carrera_secuencial(autos) do
    Enum.map(autos, &simular_carrera/1)
    |> Enum.sort_by(fn {_piloto, tiempo} -> tiempo end)
  end

  def carrera_concurrente(autos) do
    Enum.map(autos, fn auto ->
      Task.async(fn -> simular_carrera(auto) end)
    end)
    |> Task.await_many()
    |> Enum.sort_by(fn {_piloto, tiempo} -> tiempo end)
  end

  def lista_autos do
    [
      %Car{id: 1, piloto: "Hamilton", vuelta_ms: 800, pit_ms: 400},
      %Car{id: 2, piloto: "Verstappen", vuelta_ms: 750, pit_ms: 300},
      %Car{id: 3, piloto: "Alonso", vuelta_ms: 820, pit_ms: 500},
      %Car{id: 4, piloto: "Leclerc", vuelta_ms: 790, pit_ms: 350}
    ]
  end
end
