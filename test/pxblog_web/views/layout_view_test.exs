defmodule PxblogWeb.LayoutViewTest do
  use PxblogWeb.ConnCase, async: true
  alias PxblogWeb.LayoutView
  alias Pxblog.{Users.User, Repo}
  alias Pxblog.TestHelper

  setup do
    User.changeset(%User{}, %{username: "test", password: "test", password_confirmation: "test", email: "[email protected]"})
    |> Repo.insert
    {:ok, conn: build_conn()}
  end

  setup do
    {:ok, role} = TestHelper.create_role(%{name: "User Role", admin: false})
    {:ok, user} = TestHelper.create_user(role, %{email: "test@test.com", username: "testuser", password: "test", password_confirmation: "test"})
    {:ok, conn: build_conn(), user: user}
  end

  test "current user returns the user in the session", %{conn: conn, user: user} do
    conn = post conn, Routes.session_path(conn, :create), user: %{username: user.username, password: user.password}
    assert LayoutView.current_user(conn)
  end

  test "current user returns nothing if there is no user in the session", %{conn: conn, user: user} do
    conn = delete conn, Routes.session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end
end
