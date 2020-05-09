defmodule PxblogWeb.LayoutViewTest do
  use PxblogWeb.ConnCase, async: true
  alias PxblogWeb.LayoutView
  alias Pxblog.{Users.User, Repo}

  setup do
    User.changeset(%User{}, %{username: "test", password: "test", password_confirmation: "test", email: "[email protected]"})
    |> Repo.insert
    {:ok, conn: build_conn()}
  end

  test "current user returns the user in the session", %{conn: conn} do
    conn = post conn, Routes.session_path(conn, :create), user: %{username: "test", password: "test"}
    assert LayoutView.current_user(conn)
  end

  test "current user returns nothing if there is no user in the session", %{conn: conn} do
    user = Repo.get_by(User, %{username: "test"})
    conn = delete conn, Routes.session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end
end
