defmodule Pxblog.UsersTest do
  use Pxblog.DataCase

  alias Pxblog.Users

  describe "users" do
    alias Pxblog.Users.User

    @valid_attrs %{
      email: "some email",
      password: "test1234",
      password_confirmation: "test1234",
      username: "some username"
    }
    @update_attrs %{
      email: "some updated email",
      password: "test321",
      password_confirmation: "test321",
      username: "some updated username"
    }
    @invalid_attrs %{email: nil, password: nil, password_confirmation: nil, username: nil}

    test "changeset with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      refute changeset.valid?
    end

    test "password_digest value gets set to a hash" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert Comeonin.Bcrypt.checkpw(@valid_attrs.password, Ecto.Changeset.get_change(changeset, :password_digest))
    end

    test "password_digest value does not get set if password is nil" do
      changeset = User.changeset(%User{}, %{email: "[email protected]", password: nil, password_confirmation: nil, username: "test"})
      refute Ecto.Changeset.get_change(changeset, :password_digest)
    end

  end
end