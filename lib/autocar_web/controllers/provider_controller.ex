defmodule AutocarWeb.ProviderController do
    use AutocarWeb, :controller
    alias Autocar.Accounts
    import Ecto.Query, warn: false
    
    #plug :scrub_params, "provider" when action in [:add_provider]


    def add_provider(conn, %{"provider"=> provider_params, "user_id"=> user_id }) do
        attr = Map.put(provider_params, "user_id" ,user_id)
        case Accounts.create_provider(attr)do
            {:ok, _provider} ->
                json conn, :ok
            {:error, _provider} ->
                json conn, nil
        end
    end

    def update_provider(conn, %{"provider"=> provider_params, "id"=>id}) do
        provider = Accounts.get_provider(id)
        case Accounts.update_provider(provider, provider_params) do
            {:ok, _provider} ->
                json conn, :updated
            {:error, _provider} ->
                json conn, nil
        end 
    end
    
    def get_by_user_id(conn, %{"user_id"=> user_id}) do
        providers = Accounts.user_provider(user_id) 
        render(conn, "index.json", providers: providers)
    end

    def index(conn, _params) do
        providers = Accounts.list_providers()
        render(conn, "index.json", providers: providers)
    end
    
    def get_by_service(conn, %{"service" => service})do
        providers = Accounts.get_pro_by_svc(service)
        render(conn, "index.json", providers: providers)
    end 

    def get_by_id(conn, %{"id" => id}) do
        providers = Accounts.get_provider(id)
        render(conn, "show.json", provider: providers)
    end

    def rate_provider(conn, %{"provider"=> score_data, "id"=>id}) do
        provider = Accounts.get_provider(id)
        provider_params = %{"ranking" => (Map.get(score_data, "score") + provider.ranking) / 2 }
        json conn, :ok
        case Accounts.update_provider(provider, provider_params) do
            {:ok, _provider} ->
                json conn, :updated
            {:error, _provider} ->
                json conn, nil
        end 
    end

end