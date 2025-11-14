defmodule ClienteValidacion do
  @nombre_servidor :servidor_validacion

  def validar_usuario(user) do
    send(@nombre_servidor, {self(), user})
    receive do
      resultado -> resultado
    end
  end

  def validar_secuencial(usuarios) do
    Enum.map(usuarios, &validar_usuario/1)
  end

  def validar_concurrente(usuarios) do
    Enum.map(usuarios, fn user ->
      Task.async(fn -> validar_usuario(user) end)
    end)
    |> Task.await_many()
  end

  def finalizar_servidor do
    send(@nombre_servidor, {self(), :fin})
    receive do
      :fin -> :ok
    end
  end

  def generar_usuarios(cantidad) do
    Enum.map(1..cantidad, fn i ->
      caso = rem(i, 4)
      case caso do
        0 -> %User{email: "user#{i}@mail.com", edad: 25, nombre: "Usuario #{i}"}
        1 -> %User{email: "invalido#{i}", edad: 30, nombre: "Usuario #{i}"}
        2 -> %User{email: "user#{i}@mail.com", edad: -5, nombre: "Usuario #{i}"}
        3 -> %User{email: "user#{i}@mail.com", edad: 20, nombre: ""}
      end
    end)
  end
end
