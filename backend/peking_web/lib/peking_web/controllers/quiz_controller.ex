defmodule PekingWeb.QuizController do
  use PekingWeb, :controller

  alias Peking.Quizs
  alias Peking.Quizs.Quiz

  def index(conn, _params) do
    quizs = Quizs.list_quizs()
    render(conn, "index.html", quizs: quizs)
  end

  def new(conn, _params) do
    changeset = Quizs.change_quiz(%Quiz{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"quiz" => quiz_params}) do
    case Quizs.create_quiz(quiz_params) do
      {:ok, quiz} ->
        conn
        |> put_flash(:info, "Quiz created successfully.")
        |> redirect(to: Routes.quiz_path(conn, :show, quiz))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    quiz = Quizs.get_quiz!(id)
    render(conn, "show.html", quiz: quiz)
  end

  def edit(conn, %{"id" => id}) do
    quiz = Quizs.get_quiz!(id)
    changeset = Quizs.change_quiz(quiz)
    render(conn, "edit.html", quiz: quiz, changeset: changeset)
  end

  def update(conn, %{"id" => id, "quiz" => quiz_params}) do
    quiz = Quizs.get_quiz!(id)

    case Quizs.update_quiz(quiz, quiz_params) do
      {:ok, quiz} ->
        conn
        |> put_flash(:info, "Quiz updated successfully.")
        |> redirect(to: Routes.quiz_path(conn, :show, quiz))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", quiz: quiz, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quiz = Quizs.get_quiz!(id)
    {:ok, _quiz} = Quizs.delete_quiz(quiz)

    conn
    |> put_flash(:info, "Quiz deleted successfully.")
    |> redirect(to: Routes.quiz_path(conn, :index))
  end
end
