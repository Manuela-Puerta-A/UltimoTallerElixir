defmodule CocinaSecuencial do
  def ejecutar(ordenes) do
    Enum.map(ordenes, fn o ->
      ticket = Orden.preparar(o)
      IO.puts(ticket)
      ticket
    end)
  end
end

defmodule CocinaConcurrente do
  def ejecutar(ordenes) do
    ordenes
    |> Enum.map(&Task.async(fn -> Orden.preparar(&1) end))
    |> Enum.map(fn task ->
      ticket = Task.await(task, :infinity)
      IO.puts(ticket)
      ticket
    end)
  end
end
