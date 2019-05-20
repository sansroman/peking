defmodule PekingWeb.QuizControllerTest do
  use PekingWeb.ConnCase

  alias Peking.Quizs

  @create_attrs %{topic: "some topic"}
  @update_attrs %{topic: "some updated topic"}
  @invalid_attrs %{topic: nil}

  def fixture(:quiz) do
    {:ok, quiz} = Quizs.create_quiz(@create_attrs)
    quiz
  end

  describe "index" do
    test "lists all quizs", %{conn: conn} do
      conn = get(conn, Routes.quiz_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Quizs"
    end
  end

  describe "new quiz" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.quiz_path(conn, :new))
      assert html_response(conn, 200) =~ "New Quiz"
    end
  end

  describe "create quiz" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.quiz_path(conn, :create), quiz: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.quiz_path(conn, :show, id)

      conn = get(conn, Routes.quiz_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Quiz"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.quiz_path(conn, :create), quiz: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Quiz"
    end
  end

  describe "edit quiz" do
    setup [:create_quiz]

    test "renders form for editing chosen quiz", %{conn: conn, quiz: quiz} do
      conn = get(conn, Routes.quiz_path(conn, :edit, quiz))
      assert html_response(conn, 200) =~ "Edit Quiz"
    end
  end

  describe "update quiz" do
    setup [:create_quiz]

    test "redirects when data is valid", %{conn: conn, quiz: quiz} do
      conn = put(conn, Routes.quiz_path(conn, :update, quiz), quiz: @update_attrs)
      assert redirected_to(conn) == Routes.quiz_path(conn, :show, quiz)

      conn = get(conn, Routes.quiz_path(conn, :show, quiz))
      assert html_response(conn, 200) =~ "some updated topic"
    end

    test "renders errors when data is invalid", %{conn: conn, quiz: quiz} do
      conn = put(conn, Routes.quiz_path(conn, :update, quiz), quiz: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Quiz"
    end
  end

  describe "delete quiz" do
    setup [:create_quiz]

    test "deletes chosen quiz", %{conn: conn, quiz: quiz} do
      conn = delete(conn, Routes.quiz_path(conn, :delete, quiz))
      assert redirected_to(conn) == Routes.quiz_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.quiz_path(conn, :show, quiz))
      end
    end
  end

  defp create_quiz(_) do
    quiz = fixture(:quiz)
    {:ok, quiz: quiz}
  end
end
