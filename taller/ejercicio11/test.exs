# Cargar los módulos necesarios
Code.require_file("comentario.ex", __DIR__)
Code.require_file("benchmark.ex", __DIR__)
Code.require_file("servidor_moderacion.ex", __DIR__)
Code.require_file("cliente_moderacion.ex", __DIR__)

# Iniciar el servidor

spawn(ServidorModeracion, :iniciar, [])
:timer.sleep(100)

comentarios = ClienteModeracion.generar_comentarios(60)

IO.puts("\nsecuencial")
{resultado_sec, tiempo_sec} = Benchmark.medir(fn -> ClienteModeracion.moderar_secuencial(comentarios) end)
IO.puts("Comentarios moderados: #{length(resultado_sec)}")
IO.puts("Tiempo: #{tiempo_sec} ms")
aprobados = Enum.count(resultado_sec, fn {_, status} -> status == :aprobado end)
IO.puts("Aprobados: #{aprobados}, Rechazados: #{length(resultado_sec) - aprobados}")

IO.puts("\nconcurrente")
{resultado_conc, tiempo_conc} = Benchmark.medir(fn -> ClienteModeracion.moderar_concurrente(comentarios) end)
IO.puts("Comentarios moderados: #{length(resultado_conc)}")
IO.puts("Tiempo: #{tiempo_conc} ms")
aprobados2 = Enum.count(resultado_conc, fn {_, status} -> status == :aprobado end)
IO.puts("Aprobados: #{aprobados2}, Rechazados: #{length(resultado_conc) - aprobados2}")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\nspeedup: #{Float.round(speedup, 2)}x \n")

ClienteModeracion.finalizar_servidor()
