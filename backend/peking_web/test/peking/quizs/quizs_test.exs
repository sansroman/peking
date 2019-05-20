defmodule Peking.QuizsTest do
  use Peking.DataCase

  alias Peking.Quizs

  describe "quizs" do
    alias Peking.Quizs.Quiz

    @valid_attrs %{topic: "some topic"}
    @update_attrs %{topic: "some updated topic"}
    @invalid_attrs %{topic: nil}

    def quiz_fixture(attrs \\ %{}) do
      {:ok, quiz} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Quizs.create_quiz()

      quiz
    end

    test "list_quizs/0 returns all quizs" do
      quiz = quiz_fixture()
      assert Quizs.list_quizs() == [quiz]
    end

    test "get_quiz!/1 returns the quiz with given id" do
      quiz = quiz_fixture()
      assert Quizs.get_quiz!(quiz.id) == quiz
    end

    test "create_quiz/1 with valid data creates a quiz" do
      assert {:ok, %Quiz{} = quiz} = Quizs.create_quiz(@valid_attrs)
      assert quiz.topic == "some topic"
    end

    test "create_quiz/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quizs.create_quiz(@invalid_attrs)
    end

    test "update_quiz/2 with valid data updates the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{} = quiz} = Quizs.update_quiz(quiz, @update_attrs)
      assert quiz.topic == "some updated topic"
    end

    test "update_quiz/2 with invalid data returns error changeset" do
      quiz = quiz_fixture()
      assert {:error, %Ecto.Changeset{}} = Quizs.update_quiz(quiz, @invalid_attrs)
      assert quiz == Quizs.get_quiz!(quiz.id)
    end

    test "delete_quiz/1 deletes the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{}} = Quizs.delete_quiz(quiz)
      assert_raise Ecto.NoResultsError, fn -> Quizs.get_quiz!(quiz.id) end
    end

    test "change_quiz/1 returns a quiz changeset" do
      quiz = quiz_fixture()
      assert %Ecto.Changeset{} = Quizs.change_quiz(quiz)
    end
  end

  describe "answers" do
    alias Peking.Quizs.Answer

    @valid_attrs %{content: "some content", score: 42}
    @update_attrs %{content: "some updated content", score: 43}
    @invalid_attrs %{content: nil, score: nil}

    def answer_fixture(attrs \\ %{}) do
      {:ok, answer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Quizs.create_answer()

      answer
    end

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Quizs.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Quizs.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      assert {:ok, %Answer{} = answer} = Quizs.create_answer(@valid_attrs)
      assert answer.content == "some content"
      assert answer.score == 42
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quizs.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{} = answer} = Quizs.update_answer(answer, @update_attrs)
      assert answer.content == "some updated content"
      assert answer.score == 43
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Quizs.update_answer(answer, @invalid_attrs)
      assert answer == Quizs.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Quizs.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Quizs.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Quizs.change_answer(answer)
    end
  end
end
