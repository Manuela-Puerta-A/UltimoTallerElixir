# Cargar los módulos necesarios
Code.require_file("User.ex", __DIR__)
Code.require_file("benchmark.ex", __DIR__)
Code.require_file("servidor-validacion.ex", __DIR__)
Code.require_file("cliente-validacion.ex", __DIR__)

# Iniciar el servidor
spawn(ServidorValidacion, :iniciar, [])
:timer.sleep(100)

usuarios = ClienteValidacion.generar_usuarios(50)

IO.puts("\n validando en secuencial")
{resultado_sec, tiempo_sec} = Benchmark.medir(fn -> ClienteValidacion.validar_secuencial(usuarios) end)
IO.puts("Usuarios validados: #{length(resultado_sec)}")
IO.puts("Tiempo: #{tiempo_sec} ms")
validos = Enum.count(resultado_sec, fn {_, status} -> status == :ok end)
IO.puts("Válidos: #{validos}, Inválidos: #{length(resultado_sec) - validos}")

IO.puts("\nvalidando en concurrente")
{resultado_conc, tiempo_conc} = Benchmark.medir(fn -> ClienteValidacion.validar_concurrente(usuarios) end)
IO.puts("Usuarios validados: #{length(resultado_conc)}")
IO.puts("Tiempo: #{tiempo_conc} ms")
validos2 = Enum.count(resultado_conc, fn {_, status} -> status == :ok end)
IO.puts("Válidos: #{validos2}, Inválidos: #{length(resultado_conc) - validos2}")

speedup = Benchmark.calcular_speedup(tiempo_sec, tiempo_conc)
IO.puts("\n speedup: #{Float.round(speedup, 2)}x \n")

ClienteValidacion.finalizar_servidor()
