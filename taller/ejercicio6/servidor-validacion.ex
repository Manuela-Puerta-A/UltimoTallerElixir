defmodule ServidorValidacion do
  @nombre_servidor :servidor_validacion

  def iniciar do
    Process.register(self(), @nombre_servidor)
    IO.puts("Servidor de validación iniciado")
    escuchar()
  end

  defp escuchar do
    receive do
      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor finalizado")

      {cliente, user} ->
        resultado = validar_usuario(user)
        send(cliente, resultado)
        escuchar()
    end
  end

  defp validar_usuario(%User{email: email, edad: edad, nombre: nombre}) do
    delay = Enum.random(3..10)
    :timer.sleep(delay)

    errores = []
    errores = if not String.contains?(email, "@"), do: ["Email sin @" | errores], else: errores
    errores = if edad < 0, do: ["Edad negativa" | errores], else: errores
    errores = if nombre == "", do: ["Nombre vacío" | errores], else: errores

    case errores do
      [] -> {email, :ok}
      _ -> {email, {:error, errores}}
    end
  end
end
