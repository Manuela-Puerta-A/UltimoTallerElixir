spawn(ServidorNotificaciones, :iniciar, [])
:timer.sleep(100)

notificaciones = ClienteNotificaciones.generar_notificaciones(30)

IO.puts("\nsecuencial")
{resultado_sec, tiempo_sec} = Benchmark.medir(fn -> ClienteNotificaciones.enviar_secuencial(notificaciones) end)
IO.puts("Tiempo total: #{tiempo_sec} ms\n")

IO.puts("\nconcurrente")
{resultado_conc, tiempo_conc} = Benchmark.medir(fn -> ClienteNotificaciones.enviar_concurrente(notificaciones) end)
IO.puts("Tiempo total: #{tiempo_conc} ms\n")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\nspeedup: #{Float.round(speedup, 2)}x \n")

ClienteNotificaciones.finalizar_servidor()
