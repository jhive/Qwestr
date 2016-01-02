defmodule Qwestr.QwestControllerTest do
  use Qwestr.ConnCase

  # alias Qwestr.Qwest
  # @valid_attrs %{title: "New Qwest"}
  # @invalid_attrs %{}

  setup config do
    if config[:logged_in] do
      user = insert_user(username: "testr")
      conn = assign(conn(), :current_user, user) 
      {:ok, conn: conn, user: user}
    else
      {:ok, conn: conn()}
    end
  end

  test "requires user authentication on all actions", %{conn: conn} do 
    Enum.each([
      get(conn, qwest_path(conn, :index)),
      get(conn, qwest_path(conn, :show, "123")), 
      get(conn, qwest_path(conn, :edit, "123")), 
      put(conn, qwest_path(conn, :update, "123", %{})), 
      post(conn, qwest_path(conn, :create, %{})), 
      delete(conn, qwest_path(conn, :delete, "123")),
    ], 
      fn conn ->
        assert html_response(conn, 302) 
        assert conn.halted
      end
    ) 
  end

  @tag :logged_in
  test "lists all user's qwests on index", %{conn: conn, user: user} do
    # setup qwests
    user_qwest = insert_qwest(user, title: "user qwest")
    other_qwest = insert_qwest(insert_user(username: "other"), title: "another qwest")
    conn = get conn, qwest_path(conn, :index)
    
    # test assertions
    assert html_response(conn, 200) =~ ~r/Listing qwests/ 
    assert String.contains?(conn.resp_body, user_qwest.title) 

    refute String.contains?(conn.resp_body, other_qwest.title)
  end
end
