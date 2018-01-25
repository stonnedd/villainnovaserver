defmodule AutocarWeb.UserView do
  use AutocarWeb, :view
  alias AutocarWeb.UserView

  def render("index.json", %{users: users}) do
    %{users: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("show_full.json", %{user: user}) do
    %{user: render_many(user, UserView, "user_full.json")}
  end

  def render("show_providers.json", %{user: user}) do
    %{user: render_many(user, UserView, "user_providers.json")}
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

  def render("user_full.json", %{user: user}) do
    %{  id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        profile: user.profile,
        token: user.token,
        providers: render_many(user.providers, UserView, "provider.json", as: :provider),
        requests: render_many(user.requests, UserView, "request.json", as: :request)
    }
  end

  def render("user_providers.json", %{user: user}) do
    %{  id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        profile: user.profile,
        #token: user.token,
        providers: render_many(user.providers, UserView, "provider.json", as: :provider),
    }
  end

  def render("provider.json", %{provider: provider}) do
    %{ id: provider.id,
      user_id: provider.user_id,
      aditional_phone: provider.aditional_phone,
      company_name: provider.company_name,
      address: provider.address,
      brands: provider.brands,
      is_active: provider.is_active,
      lat: provider.lat,
      lng: provider.lng,
      map_icon: provider.map_icon,
      ranking: provider.ranking,
      schedule: provider.schedule,
      service: provider.service,
      specialty: provider.specialty,
      website: provider.website,
      status: provider.status
    }
  end

  def render("request.json", %{request: request}) do
    %{id: request.id,
      service: request.service,
      comment: request.comment,
      vehicle: request.vehicle,
      lng: request.lng,
      lat: request.lat,
      provider: request.provider,
      status: request.status,
      user_id: request.user_id,
      url_pic1: request.attachment.url_pic1,
      url_pic2: request.attachment.url_pic2,
      url_pic3: request.attachment.url_pic3,
      created_at: request.inserted_at
    }
  end

end



