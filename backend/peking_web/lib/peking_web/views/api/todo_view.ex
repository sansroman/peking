defmodule PekingWeb.Api.TODOView do
  use PekingWeb, :view
  alias PekingWeb.Api.TODOView

  def render("index.json", %{todos: todos}) do
    %{data: render_many(todos, TODOView, "todo.json")}
  end

  def render("show.json", %{todo: todo}) do
    %{data: render_one(todo, TODOView, "todo.json")}
  end

  def render("todo.json", %{todo: todo}) do
    %{id: todo.id,
      status: todo.status,
      content: todo.content}
  end
end
