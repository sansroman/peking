defmodule PekingWeb.Api.SessionController do
  use PekingWeb, :controller

  def create(conn, %{"email" => email, "password" => pass}) do
    case PekingWeb.Auth.login_by_email_and_pass(conn, email, pass) do
      {:ok, conn} ->
        conn
        |> json(%{status: true, data: %{uid: get_session(conn, :user_id)}})
      {:error, _reason, conn} ->
        conn
        |> json(%{status: false, error: "Invalid email/password combination"})
    end
  end

  def delete(conn, _) do
    conn
    |> PekingWeb.Auth.logout()
    |> json(%{status: true, error: ""})
  end
end
