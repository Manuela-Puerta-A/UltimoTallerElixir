defmodule ClienteNotificaciones do
  @nombre_servidor :servidor_notificaciones

  def enviar_notif(notif) do
    send(@nombre_servidor, {self(), notif})
    receive do
      resultado -> resultado
    end
  end

  def enviar_secuencial(notificaciones) do
    Enum.map(notificaciones, &enviar_notif/1)
  end

  def enviar_concurrente(notificaciones) do
    Enum.map(notificaciones, fn notif ->
      Task.async(fn -> enviar_notif(notif) end)
    end)
    |> Task.await_many()
  end

  def finalizar_servidor do
    send(@nombre_servidor, {self(), :fin})
    receive do
      :fin -> :ok
    end
  end

  def generar_notificaciones(cantidad) do
    canales = [:push, :email, :sms]
    Enum.map(1..cantidad, fn i ->
      %Notif{
        canal: Enum.random(canales),
        usuario: "user#{i}",
        plantilla: "bienvenida"
      }
    end)
  end
end
