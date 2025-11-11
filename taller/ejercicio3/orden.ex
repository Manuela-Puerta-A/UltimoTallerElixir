defmodule Orden do
  defstruct [:id, :item, :prep_ms]

  def preparar(orden) do
    :timer.sleep(orden.prep_ms)
    "Ticket ##{orden.id}: #{orden.item} listo"
  end
end
