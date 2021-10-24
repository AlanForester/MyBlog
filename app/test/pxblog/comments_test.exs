
defmodule Pxblog.CommentsTest do
  use Pxblog.DataCase

  describe "posts" do
    test "creates a comment associated with a post" do
      comment = insert(:comment)
      assert comment.post_id
    end
  end
end
