defmodule PekingWeb.Api.AnswerController do
  use PekingWeb, :controller
  plug :authenticate_user

  alias Peking.Quizs
  alias Peking.Quizs.Answer

  action_fallback PekingWeb.FallbackController

  def index(conn, _params) do
    answers = Quizs.list_answers()
    render(conn, "index.json", answers: answers)
  end

  def create(conn, %{"quiz_id" => quiz_id, "answer" => answer_params}) do
    with quiz <- Quizs.get_quiz!( Integer.to_string(quiz_id)),
         {:ok, %Answer{} = answer} <- Quizs.create_answer(conn.assigns.current_user, quiz, answer_params)
    do
      conn
      |> put_status(:created)
      |> render("show.json", answer: answer)
    else
      _ ->
        json(conn, %{status: false, error: "Creation failed"})
    end
  end

  def show(conn, %{"id" => id}) do
    answer = Quizs.get_answer!(id)
    render(conn, "show.json", answer: answer)
  end

  def update(conn, %{"id" => id, "answer" => answer_params}) do
    answer = Quizs.get_answer!(id)

    with {:ok, %Answer{} = answer} <- Quizs.update_answer(answer, answer_params) do
      json(conn, %{status: true, answer_id: answer.id})
    end
  end

  def delete(conn, %{"id" => id}) do
    answer = Quizs.get_answer!(id)

    with {:ok, %Answer{}} <- Quizs.delete_answer(answer) do
      send_resp(conn, :no_content, "")
    end
  end

  def me(conn, _params) do
    answers = Quizs.get_my_answer(get_session(conn, :user_id))
    render(conn, "index.json", answers: answers)
  end

  def own(conn, _params) do
    answers = Quizs.get_own_answer(get_session(conn, :user_id))
    render(conn, "index.json", answers: answers)
  end
end
