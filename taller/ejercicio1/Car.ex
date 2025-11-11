defmodule Car do
  defstruct [:id, :piloto, :pit_ms, :vuelta_ms]

  def nuevo(id, piloto, pit_ms, vuelta_ms) do
    %Car{id: id, piloto: piloto, pit_ms: pit_ms, vuelta_ms: vuelta_ms}
  end

  def simular_carrera(car) do
    tiempo_total = (car.vuelta_ms * 3) + car.pit_ms
    :timer.sleep(tiempo_total)
    {car.piloto, tiempo_total}
  end
end
