defmodule ClienteRender do
  @nombre_servidor :servidor_render

  def renderizar(plantilla) do
    send(@nombre_servidor, {self(), plantilla})
    receive do
      resultado -> resultado
    end
  end

  def renderizar_secuencial(plantillas) do
    Enum.map(plantillas, &renderizar/1)
  end

  def renderizar_concurrente(plantillas) do
    Enum.map(plantillas, fn plantilla ->
      Task.async(fn -> renderizar(plantilla) end)
    end)
    |> Task.await_many()
  end

  def finalizar_servidor do
    send(@nombre_servidor, {self(), :fin})
    receive do
      :fin -> :ok
    end
  end

  def generar_plantillas(cantidad) do
    templates = [
      "<h1>Hola {{nombre}}</h1><p>Bienvenido {{apellido}}</p>",
      "<div>Usuario: {{usuario}}, Email: {{email}}</div>",
      "<span>Total: {{total}} - Fecha: {{fecha}}</span>"
    ]

    Enum.map(1..cantidad, fn i ->
      %Tpl{
        id: i,
        nombre: Enum.random(templates),
        vars: %{nombre: "Juan", apellido: "Perez", usuario: "user#{i}",
                email: "user#{i}@mail.com", total: "100", fecha: "2025"}
      }
    end)
  end
end
