defmodule PekingWeb.Api.QuizView do
  use PekingWeb, :view
  alias PekingWeb.Api.QuizView

  def render("index.json", %{quizs: quizs}) do
    %{data: render_many(quizs, QuizView, "quiz.json")}
  end

  def render("show.json", %{quiz: quiz}) do
    %{data: render_one(quiz, QuizView, "quiz.json")}
  end

  def render("quiz.json", %{quiz: quiz}) do
    %{id: quiz.id,
      topic: quiz.topic}
  end
end
