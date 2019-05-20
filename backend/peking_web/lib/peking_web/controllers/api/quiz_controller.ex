defmodule PekingWeb.Api.QuizController do
  use PekingWeb, :controller
  plug :authenticate_user

  alias Peking.Quizs
  alias Peking.Quizs.Quiz

  action_fallback PekingWeb.FallbackController

  def index(conn, _params) do
    quizs = Quizs.list_quizs()
    render(conn, "index.json", quizs: quizs)
  end

  def create(conn, %{"quiz" => quiz_params}) do
    case conn.assigns.current_user do
      %{:room => %{status: true, id: id}} ->
        with {:ok, %Quiz{} = quiz } <- Quizs.create_quiz(conn.assigns.current_user, quiz_params) do
          PekingWeb.Endpoint.broadcast!("room:" <> Integer.to_string(id), "quiz", quiz)
          json(conn, %{status: true, data: %{quiz_id: quiz.id}})
        end
      _ ->
        json(conn, %{status: false, error: "doesn't have room or not living"})
    end
  end

  def show(conn, %{"id" => id}) do
    quiz = Quizs.get_quiz!(id)
    render(conn, "show.json", quiz: quiz)
  end

  def update(conn, %{"id" => id, "quiz" => quiz_params}) do
    quiz = Quizs.get_quiz!(id)

    with {:ok, %Quiz{} = quiz} <- Quizs.update_quiz(quiz, quiz_params) do
      render(conn, "show.json", quiz: quiz)
    end
  end

  def delete(conn, %{"id" => id}) do
    quiz = Quizs.get_quiz!(id)

    with {:ok, %Quiz{}} <- Quizs.delete_quiz(quiz) do
      send_resp(conn, :no_content, "")
    end
  end
end
