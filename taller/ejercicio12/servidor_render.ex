defmodule ServidorRender do
  @nombre_servidor :servidor_render

  def iniciar do
    Process.register(self(), @nombre_servidor)
    IO.puts("Servidor de render iniciado")
    escuchar()
  end

  defp escuchar do
    receive do
      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor finalizado")

      {cliente, plantilla} ->
        resultado = render(plantilla)
        send(cliente, resultado)
        escuchar()
    end
  end

  defp render(%Tpl{id: id, nombre: template, vars: vars}) do
    costo = div(String.length(template), 10) + 5
    :timer.sleep(costo)

    html = Enum.reduce(vars, template, fn {key, value}, acc ->
      String.replace(acc, "{{#{key}}}", to_string(value))
    end)

    {id, html}
  end
end
