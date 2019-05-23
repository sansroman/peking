defmodule PekingWeb.Api.TODOController do
  use PekingWeb, :controller
  plug :authenticate_user

  alias Peking.Accounts
  alias Peking.Accounts.TODO

  action_fallback PekingWeb.FallbackController

  def index(conn, _params) do
    todos = Accounts.list_todos()
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    user = conn.assigns.current_user
    with {:ok, %TODO{} = todo} <- Accounts.create_todo(user, todo_params) do
      conn
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Accounts.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Accounts.get_todo!(id)

    with {:ok, %TODO{} = todo} <- Accounts.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Accounts.get_todo!(id)

    with {:ok, %TODO{}} <- Accounts.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end
