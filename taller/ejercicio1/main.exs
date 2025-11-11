defmodule MainCarrera do
  def main do
    cars = [
      %Car{id: 1, piloto: "Hamilton", pit_ms: 2000, vuelta_ms: 1500},
      %Car{id: 2, piloto: "Verstappen", pit_ms: 1800, vuelta_ms: 1400},
      %Car{id: 3, piloto: "Leclerc", pit_ms: 2200, vuelta_ms: 1600},
      %Car{id: 4, piloto: "Pérez", pit_ms: 1900, vuelta_ms: 1550},
      %Car{id: 5, piloto: "Sainz", pit_ms: 2100, vuelta_ms: 1580}
    ]


    tiempo_seq = Benchmark.determinar_tiempo_ejecucion(
      {CarreraSecuencial, :ejecutar, [cars]}
    )
    resultados_seq = CarreraSecuencial.ejecutar(cars)
    CarreraSecuencial.mostrar_ranking(resultados_seq)


    tiempo_conc = Benchmark.determinar_tiempo_ejecucion(
      {CarreraConcurrente, :ejecutar, [cars]}
    )
    resultados_conc = CarreraConcurrente.ejecutar(cars)
    CarreraConcurrente.mostrar_ranking(resultados_conc)


    IO.puts("\n" <> Benchmark.generar_mensaje(tiempo_seq, tiempo_conc))
  end
end

MainCarrera.main()
