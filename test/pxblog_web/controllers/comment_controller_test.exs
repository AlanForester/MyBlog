defmodule PxblogWeb.CommentControllerTest do
  use PxblogWeb.ConnCase

  alias Pxblog.Comment

  @valid_attrs %{author: "Some Person", body: "This is a sample comment"}
  @invalid_attrs %{}

  defp login_user(conn, user) do
    post conn, session_path(conn, :create), user: %{username: user.username, password: user.password}
  end

  setup do
    role    = insert(:role, admin: true)
    user    = insert(:user, role: role)
    post    = insert(:post, user: user)
    comment = insert(:comment)

    {:ok, conn: build_conn(), user: user, post: post, comment: comment}
  end

  test "deletes the comment when logged in as an authorized user", %{conn: conn, user: user, post: post, comment: comment} do
    conn = login_user(conn, user) |> delete(post_comment_path(conn, :delete, post, comment))
    assert redirected_to(conn) == user_post_path(conn, :show, post.user, post)
    refute Repo.get(Comment, comment.id)
  end

  # TODO: test "does not delete the comment when not logged in as an authorized user"
  # test "does not delete the comment when not logged in as an authorized user", %{conn: conn, post: post, comment: comment} do
  #   conn = delete(conn, post_comment_path(conn, :delete, post, comment))
  #   assert redirected_to(conn) == page_path(conn, :index)
  #   assert Repo.get(Comment, comment.id)
  # end

  test "updates chosen resource and redirects when data is valid and logged in as the author", %{conn: conn, user: user, post: post, comment: comment} do
    conn = login_user(conn, user) |> put(post_comment_path(conn, :update, post, comment), comment: %{"approved" => true})
    assert redirected_to(conn) == user_post_path(conn, :show, user, post)
    assert Repo.get_by(Comment, %{id: comment.id, approved: true})
  end

  # TODO: test "does not update the comment when not logged in as an authorized user"
  # test "does not update the comment when not logged in as an authorized user", %{conn: conn, post: post, comment: comment} do
  #   conn = put(conn, post_comment_path(conn, :update, post, comment), comment: %{"approved" => true})
  #   assert redirected_to(conn) == page_path(conn, :index)
  #   refute Repo.get_by(Comment, %{id: comment.id, approved: true})
  # end

end
