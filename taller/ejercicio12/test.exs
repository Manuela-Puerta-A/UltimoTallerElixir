Code.require_file("tpl.ex", __DIR__)
Code.require_file("benchmark.ex", __DIR__)
Code.require_file("servidor_render.ex", __DIR__)
Code.require_file("cliente_render.ex", __DIR__)


spawn(ServidorRender, :iniciar, [])
:timer.sleep(100)

plantillas = ClienteRender.generar_plantillas(50)

IO.puts("\nsecuencial")
{resultado_sec, tiempo_sec} = Benchmark.medir(fn -> ClienteRender.renderizar_secuencial(plantillas) end)
IO.puts("Plantillas renderizadas: #{length(resultado_sec)}")
IO.puts("Tiempo: #{tiempo_sec} ms")
IO.puts("Primera renderizada: #{inspect(Enum.at(resultado_sec, 0))}")

IO.puts("\nrecurrente")
{resultado_conc, tiempo_conc} = Benchmark.medir(fn -> ClienteRender.renderizar_concurrente(plantillas) end)
IO.puts("Plantillas renderizadas: #{length(resultado_conc)}")
IO.puts("Tiempo: #{tiempo_conc} ms")
IO.puts("Primera renderizada: #{inspect(Enum.at(resultado_conc, 0))}")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\nspeedup: #{Float.round(speedup, 2)}x\n")

ClienteRender.finalizar_servidor()
