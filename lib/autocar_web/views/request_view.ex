defmodule AutocarWeb.RequestView do
  use AutocarWeb, :view
  alias AutocarWeb.RequestView

  def render("index.json", %{requests: requests}) do
    %{requests: render_many(requests, RequestView, "request.json")}
  end

  def render("show.json", %{request: request}) do
    %{requests: render_one(request, RequestView, "request.json")}
  end

  def render("request.json", %{request: request}) do
    %{id: request.id,
      service: request.service,
      comment: request.comment,
      pic1: request.pic1,
      pic2: request.pic2,
      pic3: request.pic3,
      pic_type: request.pic_type,
      vehicle: request.vehicle,
      lng: request.lng,
      lat: request.lat,
      provider: request.provider,
      status: request.status,
      user_id: request.user_id
    }
  end
end
