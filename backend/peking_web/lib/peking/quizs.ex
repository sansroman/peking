defmodule Peking.Quizs do
  @moduledoc """
  The Quizs context.
  """

  import Ecto.Query, warn: false
  alias Peking.Repo
  alias Peking.Accounts.User
  alias Peking.Quizs.Quiz

  @doc """
  Returns the list of quizs.

  ## Examples

      iex> list_quizs()
      [%Quiz{}, ...]

  """
  def list_quizs do
    Repo.all(Quiz)
  end

  @doc """
  Gets a single quiz.

  Raises `Ecto.NoResultsError` if the Quiz does not exist.

  ## Examples

      iex> get_quiz!(123)
      %Quiz{}

      iex> get_quiz!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quiz!(id), do: Repo.get!(Quiz, id)

  @doc """
  Creates a quiz.

  ## Examples

      iex> create_quiz(%{field: value})
      {:ok, %Quiz{}}

      iex> create_quiz(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quiz(%User{} = user, attrs \\ %{}) do
    %Quiz{}
    |> Quiz.changeset(attrs)
    |> put_user(user)
    |> Repo.insert()
  end

  @doc """
  Updates a quiz.

  ## Examples

      iex> update_quiz(quiz, %{field: new_value})
      {:ok, %Quiz{}}

      iex> update_quiz(quiz, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quiz(%Quiz{} = quiz, attrs) do
    quiz
    |> Quiz.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Quiz.

  ## Examples

      iex> delete_quiz(quiz)
      {:ok, %Quiz{}}

      iex> delete_quiz(quiz)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quiz(%Quiz{} = quiz) do
    Repo.delete(quiz)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quiz changes.

  ## Examples

      iex> change_quiz(quiz)
      %Ecto.Changeset{source: %Quiz{}}

  """
  def change_quiz(%Quiz{} = quiz) do
    Quiz.changeset(quiz, %{})
  end

  alias Peking.Quizs.Answer

  @doc """
  Returns the list of answers.

  ## Examples

      iex> list_answers()
      [%Answer{}, ...]

  """
  def list_answers do
    Answer
    |> Repo.all()
    |> Repo.preload(preload: [:user, quiz: [:user]])
  end

  @doc """
  Gets a single answer.

  Raises `Ecto.NoResultsError` if the Answer does not exist.

  ## Examples

      iex> get_answer!(123)
      %Answer{}

      iex> get_answer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_answer!(id), do: Repo.get!(Answer, id)

  @doc """
  Creates a answer.

  ## Examples

      iex> create_answer(%{field: value})
      {:ok, %Answer{}}

      iex> create_answer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_answer(%User{} = user, %Quiz{} = quiz, attrs \\ %{}) do
    %Answer{}
    |> Answer.changeset(attrs)
    |> put_user(user)
    |> put_quiz(quiz)
    |> Repo.insert()
  end

  @doc """
  Updates a answer.

  ## Examples

      iex> update_answer(answer, %{field: new_value})
      {:ok, %Answer{}}

      iex> update_answer(answer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_answer(%Answer{} = answer, attrs) do
    answer
    |> Answer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Answer.

  ## Examples

      iex> delete_answer(answer)
      {:ok, %Answer{}}

      iex> delete_answer(answer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_answer(%Answer{} = answer) do
    Repo.delete(answer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking answer changes.

  ## Examples

      iex> change_answer(answer)
      %Ecto.Changeset{source: %Answer{}}

  """
  def change_answer(%Answer{} = answer) do
    Answer.changeset(answer, %{})
  end

  def get_my_answer(user_id) do
    from(a in Answer, where: a.user_id == ^user_id, preload: [:user, quiz: [:user]])
    |> Repo.all()
  end

  def get_own_answer(user_id) do
    from(a in Answer, join: q in assoc(a, :quiz), where: q.user_id == ^user_id, preload: [:user, quiz: [:user]])
    |> Repo.all()
  end


  defp put_user(changeset, user) do
    Ecto.Changeset.put_assoc(changeset, :user, user)
  end

  defp put_quiz(changeset, quiz) do
    Ecto.Changeset.put_assoc(changeset, :quiz, quiz)
  end
end
