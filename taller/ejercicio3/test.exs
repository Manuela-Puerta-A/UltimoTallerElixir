ordenes = Cafeteria.lista_ordenes()

IO.puts("\nsecuencial")
{tickets_sec, tiempo_sec} = Benchmark.medir(fn -> Cafeteria.procesar_secuencial(ordenes) end)
IO.puts("Tiempo total: #{tiempo_sec} ms\n")

IO.puts("\n concurrente")
{tickets_conc, tiempo_conc} = Benchmark.medir(fn -> Cafeteria.procesar_concurrente(ordenes) end)
IO.puts("Tiempo total: #{tiempo_conc} ms\n")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\nspeedup: #{Float.round(speedup, 2)}x \n")
