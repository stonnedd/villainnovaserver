defmodule AutocarWeb.RequestView do
  use AutocarWeb, :view
  alias AutocarWeb.RequestView

  def render("index.json", %{requests: requests}) do
    %{requests: render_many(requests, RequestView, "request.json")}
  end
  def render("index_partial.json", %{requests: requests}) do
    %{requests: render_many(requests, RequestView, "request_partial.json")}
  end

  def render("show.json", %{request: request}) do
    %{requests: render_one(request, RequestView, "request.json")}
  end
  
  def render("show_partial.json", %{request: request}) do
    %{requests: render_one(request, RequestView, "request_partial.json")}
  end

  def render("request.json", %{request: request}) do
    %{id: request.id,
      service: request.service,
      comment: request.comment,
      vehicle: request.vehicle,
      lng: request.lng,
      lat: request.lat,
      provider_id: request.provider_id,
      status: request.status,
      p_status: request.p_status,
      user_id: request.user_id,
      created_at: request.inserted_at,
      url_pic1: request.attachment.url_pic1,
      url_pic2: request.attachment.url_pic2,
      url_pic3: request.attachment.url_pic3,
      proposal: render_one(request.proposal, RequestView, "proposal.json", as: :proposal)
     
    }
  end

  def render("request_partial.json", %{request: request}) do
    %{id: request.id
      # comment: request.comment,
      # provider: request.provider,
      # status: request.status,
      # user_id: request.user_id,
    }
  end

  def render("proposal.json", %{proposal: proposal}) do
    %{
      c_status: proposal.c_status,
      p_status: proposal.p_status,
      price: proposal.price,
      time: proposal.time,
      comment: proposal.comment
    }
  end


  def formatDate (date) do
    "#{date.hour}:#{date.minute} - #{date.day}/#{date.month}/#{date.year} "
  end
end
