defmodule PxblogWeb.CommentController do
  use PxblogWeb, :controller

  import Ecto

  alias Pxblog.Comment
  alias Pxblog.Posts.Post
  alias Pxblog.Repo

  plug :scrub_params, "comment" when action in [:create, :update]

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post      = Repo.get!(Post, post_id) |> Repo.preload([:user, :comments])
    changeset = post
      |> build_assoc(:comments)
      |> Comment.changeset(comment_params)
    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully!")
        |> redirect(to: Routes.user_post_path(conn, :show, post.user, post))
      {:error, changeset} ->
        render(conn, PxblogWeb.PostView, "show.html", post: post, user: post.user, comment_changeset: changeset)
    end
  end
  def update(conn, _), do: conn
  def delete(conn, %{"id" => id, "post_id" => post_id}) do
    post = Repo.get!(Post, post_id) |> Repo.preload(:user)
    Repo.get!(Comment, id) |> Repo.delete!
    conn
    |> put_flash(:info, "Deleted comment!")
    |> redirect(to: Routes.user_post_path(conn, :show, post.user, post))
  end

end
