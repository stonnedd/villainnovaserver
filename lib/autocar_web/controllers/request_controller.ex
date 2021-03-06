defmodule AutocarWeb.RequestController do
  use AutocarWeb, :controller

  alias Autocar.CMS
  alias Autocar.CMS.Request

  action_fallback AutocarWeb.FallbackController

  def index(conn, _params) do
    requests = CMS.list_requests()
    render(conn, "index_partial.json", requests: requests)
  end

  def get_by_user_id(conn, %{"user_id" => user_id}) do
    requests = CMS.get_by_user(user_id)
    render(conn, "index.json", requests: requests)
  end
  
  def get_request_by_provider(conn, %{"provider_id" => provider_id})do
    requests = CMS.get_by_provider(provider_id)
    render(conn, "index.json", requests: requests)
  end 

  def create(conn, %{"request" => request_params, "user_id"=> user_id}) do
    attr = Map.put(request_params, "user_id" ,user_id)
    case CMS.create_request(attr)do
      {:ok, request} ->
        IO.inspect request        
        #json conn, request.id
       render(conn, "show_partial.json", request: request)
      {:error, request} ->
        json conn, nil
    end
  end


  def create_multiple_requests(conn, %{"request" => request_params}) do
    IO.inspect request_params
    providers = Map.get(request_params, "providers")
    attachment_params = Map.get(request_params, "attachments")
    Enum.each(providers, fn(p)-> 
      attr = Map.delete(request_params, "providers")
      |> Map.delete("Attachments")
      |> Map.put("provider_id", p)
      case CMS.create_request(attr)do
        {:ok, request} ->
          request.id
          attachment_attr = Map.put( attachment_params, "request_id", request.id )
          case CMS.create_attachment(attachment_attr) do
            {:ok, attachment} ->
              IO.inspect attachment
            {:error, request} ->
              json conn, nil
          end  
        {:error, request} ->
          json conn, nil
      end      
    end
    )
    json conn, :ok
  end

  def show(conn, %{"id" => id}) do
    request = CMS.get_request!(id)
    json conn, request
    #render(conn, "show.json", request: request)
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
 
  def update_request(conn, %{"request" => request_params, "id" => id, }) do
    request = CMS.get_request!(id)
    |> IO.inspect
    case CMS.update_request(request, request_params) do
      {:ok, provider} ->
        json conn, :updated
      {:error, provider} ->
        json conn, nil 
    end      
  end  

end
