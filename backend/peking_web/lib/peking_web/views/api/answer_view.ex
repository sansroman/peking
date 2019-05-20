defmodule PekingWeb.Api.AnswerView do
  use PekingWeb, :view
  alias PekingWeb.Api.AnswerView

  def render("index.json", %{answers: answers}) do
    %{data: render_many(answers, AnswerView, "answer.json")}
  end

  def render("show.json", %{answer: answer}) do
    %{data: render_one(answer, AnswerView, "answer.json")}
  end

  def render("answer.json", %{answer: answer}) do
    %{id: answer.id,
      quiz_id: answer.quiz.id,
      score: answer.score,
      content: answer.content,
      created_at: answer.inserted_at,
      teacher: answer.quiz.user.nickname,
      title: answer.quiz.topic,
      author: answer.user.nickname}
  end
end
