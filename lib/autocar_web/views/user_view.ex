defmodule AutocarWeb.UserView do
  use AutocarWeb, :view
  alias AutocarWeb.UserView

  def render("index.json", %{users: users}) do
    %{users: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      profile: user.profile,
      token: user.token,
    }
  end

end



