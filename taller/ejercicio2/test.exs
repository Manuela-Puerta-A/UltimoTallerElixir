productos = Precios.generar_productos(5000)

IO.puts("\n secuencial")
{resultado_sec, tiempo_sec} = Benchmark.medir(fn -> Precios.calcular_secuencial(productos) end)
IO.puts("Productos procesados: #{length(resultado_sec)}")
IO.puts("Tiempo: #{tiempo_sec} ms")
IO.puts("Primeros 3: #{inspect(Enum.take(resultado_sec, 3))}")

IO.puts("\n Concurrente ")
{resultado_conc, tiempo_conc} = Benchmark.medir(fn -> Precios.calcular_concurrente(productos) end)
IO.puts("Productos procesados: #{length(resultado_conc)}")
IO.puts("Tiempo: #{tiempo_conc} ms")
IO.puts("Primeros 3: #{inspect(Enum.take(resultado_conc, 3))}")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\nSpeedup: #{Float.round(speedup, 2)}x\n")
