Code.require_file("benchmark.ex", __DIR__)
Code.require_file("carrito.ex", __DIR__)
Code.require_file("cliente_descuentos.ex", __DIR__)
Code.require_file("servidor_descuentos.ex", __DIR__)
spawn(ServidorDescuentos, :iniciar, [])
:timer.sleep(100)

carritos = ClienteDescuentos.generar_carritos(80)

IO.puts("\nsecuencial")
{resultado_sec, tiempo_sec} = Benchmark.medir(fn -> ClienteDescuentos.procesar_secuencial(carritos) end)
IO.puts("Carritos procesados: #{length(resultado_sec)}")
IO.puts("Tiempo: #{tiempo_sec} ms")
IO.puts("Primeros 3: #{inspect(Enum.take(resultado_sec, 3))}")

IO.puts("\nconcurrente")
{resultado_conc, tiempo_conc} = Benchmark.medir(fn -> ClienteDescuentos.procesar_concurrente(carritos) end)
IO.puts("Carritos procesados: #{length(resultado_conc)}")
IO.puts("Tiempo: #{tiempo_conc} ms")
IO.puts("Primeros 3: #{inspect(Enum.take(resultado_conc, 3))}")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\n speedup: #{Float.round(speedup, 2)}x \n")

ClienteDescuentos.finalizar_servidor()
