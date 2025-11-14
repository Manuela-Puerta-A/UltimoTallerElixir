# Cargar los módulos necesarios
Code.require_file("paquete.ex", __DIR__)
Code.require_file("benchmark.ex", __DIR__)
Code.require_file("servidor_paquete.ex", __DIR__)
Code.require_file("cliente_paquetes.ex", __DIR__)

# Iniciar el servidor

spawn(ServidorPaquetes, :iniciar, [])
:timer.sleep(100)

paquetes = ClientePaquetes.generar_paquetes(25)

IO.puts("\nsecuencial")
{resultado_sec, tiempo_sec} = Benchmark.medir(fn -> ClientePaquetes.procesar_secuencial(paquetes) end)
IO.puts("Paquetes procesados: #{length(resultado_sec)}")
IO.puts("Tiempo: #{tiempo_sec} ms")
IO.puts("Primeros 3: #{inspect(Enum.take(resultado_sec, 3))}")

IO.puts("\nconcurrente")
{resultado_conc, tiempo_conc} = Benchmark.medir(fn -> ClientePaquetes.procesar_concurrente(paquetes) end)
IO.puts("Paquetes procesados: #{length(resultado_conc)}")
IO.puts("Tiempo: #{tiempo_conc} ms")
IO.puts("Primeros 3: #{inspect(Enum.take(resultado_conc, 3))}")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\nspeedup: #{Float.round(speedup, 2)}\n")

ClientePaquetes.finalizar_servidor()
