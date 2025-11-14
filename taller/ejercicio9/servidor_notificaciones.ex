defmodule ServidorNotificaciones do
  @nombre_servidor :servidor_notificaciones

  def iniciar do
    Process.register(self(), @nombre_servidor)
    IO.puts("Servidor de notificaciones iniciado")
    escuchar()
  end

  defp escuchar do
    receive do
      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor finalizado")

      {cliente, notif} ->
        resultado = enviar(notif)
        send(cliente, resultado)
        escuchar()
    end
  end

  defp enviar(%Notif{canal: canal, usuario: usuario, plantilla: plantilla}) do
    costo = case canal do
      :push -> 50
      :email -> 100
      :sms -> 150
      _ -> 80
    end

    :timer.sleep(costo)
    msg = "Enviada a #{usuario} (#{canal})"
    IO.puts(msg)
    msg
  end
end
