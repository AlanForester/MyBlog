defmodule PxblogWeb.PostView do
  @moduledoc false
  use PxblogWeb, :view

  def markdown(body) do
    body
    |> Earmark.as_html!
    |> raw
  end

end
