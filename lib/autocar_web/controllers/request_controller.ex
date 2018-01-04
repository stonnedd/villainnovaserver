defmodule AutocarWeb.RequestController do
  use AutocarWeb, :controller

  alias Autocar.CMS
  alias Autocar.CMS.Request

  action_fallback AutocarWeb.FallbackController

  def index(conn, _params) do
    requests = CMS.list_requests()
    render(conn, "index.json", requests: requests)
  end

  def get_by_user_id(conn, %{"user_id" => user_id}) do
    requests = CMS.get_by_user(user_id)
    render(conn, "index.json", requests: requests)
  end

  def create(conn, %{"request" => request_params, "user_id"=> user_id}) do
    attr = Map.put(request_params, "user_id" ,user_id)
    case CMS.create_request(attr)do
      {:ok, request} ->
        #json conn, :ok
        render(conn, "show.json", request: request)
      {:error, request} ->
        json conn, nil
    end
  end

  def show(conn, %{"id" => id}) do
    request = CMS.get_request!(id)
    render(conn, "show.json", request: request)
  end

  def update(conn, %{"id" => id, "request" => request_params}) do
    request = CMS.get_request!(id)

    with {:ok, %Request{} = request} <- CMS.update_request(request, request_params) do
      render(conn, "show.json", request: request)
    end
  end

  def delete(conn, %{"id" => id}) do
    request = CMS.get_request!(id)
    with {:ok, %Request{}} <- CMS.delete_request(request) do
      send_resp(conn, :no_content, "")
    end
  end
end
