defmodule Benchmark do
  def medir(funcion) do
    inicio = :erlang.monotonic_time(:millisecond)
    resultado = funcion.()
    fin = :erlang.monotonic_time(:millisecond)
    tiempo = fin - inicio
    {resultado, tiempo}
  end

  def calcular_speedup(tiempo_sec, tiempo_conc) do
    tiempo_sec / tiempo_conc
  end
end
