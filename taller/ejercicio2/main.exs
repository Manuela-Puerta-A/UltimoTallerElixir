defmodule MainPrecios do
  def main do
    productos = for i <- 1..50_000 do
      %Producto{
        nombre: "Producto#{i}",
        precio_sin_iva: :rand.uniform(1000) * 1.0,
        iva: 0.19
      }
    end

    t1 = Benchmark.determinar_tiempo_ejecucion({PreciosSecuencial, :ejecutar, [productos]})
    t2 = Benchmark.determinar_tiempo_ejecucion({PreciosConcurrente, :ejecutar, [productos]})

    IO.puts(Benchmark.generar_mensaje(t1, t2))
  end
end

MainPrecios.main()
