defmodule cafeteria do

  def preparar(%Orden{id: id, item: item, prep_ms: tiempo}) do
    :timer.sleep(tiempo)
    ticket = "Ticket ##{id}: #{item} - Listo"
    IO.puts(ticket)
    ticket
  end

  def procesar_secuencial(ordenes) do
    Enum.map(ordenes, &preparar/1)
  end

  def procesar_concurrente(ordenes) do
    Enum.map(ordenes, fn orden ->
      Task.async(fn -> preparar(orden) end)
    end)
    |> Task.await_many()
  end

  def lista_ordenes do
    [
      %Orden{id: 1, item: "Café Expreso", prep_ms: 200},
      %Orden{id: 2, item: "Capuchino", prep_ms: 300},
      %Orden{id: 3, item: "Sandwich", prep_ms: 500},
      %Orden{id: 4, item: "Jugo Natural", prep_ms: 250},
      %Orden{id: 5, item: "Croissant", prep_ms: 150}
    ]
  end
end
