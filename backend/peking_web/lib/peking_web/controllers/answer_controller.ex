defmodule PekingWeb.AnswerController do
  use PekingWeb, :controller

  alias Peking.Quizs
  alias Peking.Quizs.Answer

  def index(conn, _params) do
    answers = Quizs.list_answers()
    render(conn, "index.html", answers: answers)
  end

  def new(conn, _params) do
    changeset = Quizs.change_answer(%Answer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"quiz_id" => quiz_id, "answer" => answer_params}) do
    with {%Quizs.Quiz{} = quiz} <- Quizs.get_quiz!(quiz_id),
         {:ok, %Answer{} = answer} <- Quizs.create_answer(conn.assigns.current_user, quiz, answer_params)
    do
        conn
        |> put_flash(:info, "Answer created successfully.")
        |> redirect(to: Routes.answer_path(conn, :show, answer))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    answer = Quizs.get_answer!(id)
    render(conn, "show.html", answer: answer)
  end

  def edit(conn, %{"id" => id}) do
    answer = Quizs.get_answer!(id)
    changeset = Quizs.change_answer(answer)
    render(conn, "edit.html", answer: answer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "answer" => answer_params}) do
    answer = Quizs.get_answer!(id)

    case Quizs.update_answer(answer, answer_params) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer updated successfully.")
        |> redirect(to: Routes.answer_path(conn, :show, answer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", answer: answer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    answer = Quizs.get_answer!(id)
    {:ok, _answer} = Quizs.delete_answer(answer)

    conn
    |> put_flash(:info, "Answer deleted successfully.")
    |> redirect(to: Routes.answer_path(conn, :index))
  end
end
