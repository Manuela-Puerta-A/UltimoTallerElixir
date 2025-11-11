defmodule MainCocina do
  def main do
    ordenes = [
      %Orden{id: 1, item: "Café", prep_ms: 3000},
      %Orden{id: 2, item: "Sandwich", prep_ms: 5000},
      %Orden{id: 3, item: "Jugo", prep_ms: 2000},
      %Orden{id: 4, item: "Croissant", prep_ms: 4000}
    ]

    IO.puts("=== SECUENCIAL ===")
    t1 = Benchmark.determinar_tiempo_ejecucion({CocinaSecuencial, :ejecutar, [ordenes]})

    IO.puts("\n=== CONCURRENTE ===")
    t2 = Benchmark.determinar_tiempo_ejecucion({CocinaConcurrente, :ejecutar, [ordenes]})

    IO.puts("\n" <> Benchmark.generar_mensaje(t1, t2))
  end
end

MainCocina.main()
