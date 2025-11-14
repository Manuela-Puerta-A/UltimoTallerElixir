autos = carrera.lista_autos()

IO.puts("\nSecuencial ")
{ranking_sec, tiempo_sec} = Benchmark.medir(fn -> carrera.carrera_secuencial(autos) end)
IO.puts("\nRanking:")
Enum.each(ranking_sec, fn {piloto, tiempo} ->
  IO.puts("  #{piloto} - #{tiempo} ms")
end)
IO.puts("Tiempo total: #{tiempo_sec} ms\n")

IO.puts("\nconcurrente")
{ranking_conc, tiempo_conc} = Benchmark.medir(fn -> carrera.carrera_concurrente(autos) end)
IO.puts("\nRanking:")
Enum.each(ranking_conc, fn {piloto, tiempo} ->
  IO.puts("  #{piloto} - #{tiempo} ms")
end)
IO.puts("Tiempo total: #{tiempo_conc} ms\n")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\nspeedup: #{Float.round(speedup, 2)}x ===\n")
