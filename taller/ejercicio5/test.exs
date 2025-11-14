# Cargar los módulos necesarios
Code.require_file("Sucursal.ex", __DIR__)
Code.require_file("benchmark.ex", __DIR__)
Code.require_file("GeneradorReportes.ex", __DIR__)

sucursales = GeneradorReportes.lista_sucursales()

IO.puts("\nsecuencial")
{reportes_sec, tiempo_sec} = Benchmark.medir(fn -> GeneradorReportes.generar_secuencial(sucursales) end)
IO.puts("Tiempo total: #{tiempo_sec} ms\n")

IO.puts("\nConcurrente")
{reportes_conc, tiempo_conc} = Benchmark.medir(fn -> GeneradorReportes.generar_concurrente(sucursales) end)
IO.puts("Tiempo total: #{tiempo_conc} ms\n")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\nspeedup: #{Float.round(speedup, 2)}x \n")
