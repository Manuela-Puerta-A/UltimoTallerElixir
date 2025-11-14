ordenes = Cafeteria.lista_ordenes()

IO.puts("\nSecuencial")
{tickets_sec, tiempo_sec} = Benchmark.medir(fn -> cafeteria.procesar_secuencial(ordenes) end)
IO.puts("Tiempo total: #{tiempo_sec} ms\n")

IO.puts("\nConcurrente")
{tickets_conc, tiempo_conc} = Benchmark.medir(fn -> cafeteria.procesar_concurrente(ordenes) end)
IO.puts("Tiempo total: #{tiempo_conc} ms\n")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\nSpeedupP: #{Float.round(speedup, 2)}x \n")
