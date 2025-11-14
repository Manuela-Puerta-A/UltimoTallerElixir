Code.require_file("benchmark.ex", __DIR__)
Code.require_file("cliente_backoffice.ex", __DIR__)
Code.require_file("servidor_backoffice.ex", __DIR__)
spawn(ServidorBackoffice, :iniciar, [])
:timer.sleep(100)

tareas = ClienteBackoffice.lista_tareas()

IO.puts("\nsecuencial")
{resultado_sec, tiempo_sec} = Benchmark.medir(fn -> ClienteBackoffice.ejecutar_secuencial(tareas) end)
IO.puts("Tiempo total: #{tiempo_sec} ms\n")

IO.puts("\nconcurrente")
{resultado_conc, tiempo_conc} = Benchmark.medir(fn -> ClienteBackoffice.ejecutar_concurrente(tareas) end)
IO.puts("Tiempo total: #{tiempo_conc} ms\n")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\nspeedup: #{Float.round(speedup, 2)}x \n")

ClienteBackoffice.finalizar_servidor()
