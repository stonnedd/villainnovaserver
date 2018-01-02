defmodule AutocarWeb.ProviderView do
    use AutocarWeb, :view
    alias AutocarWeb.ProviderView
  
    def render("index.json", %{providers: providers}) do
      %{providers: render_many(providers, ProviderView, "provider.json")}
    end
  
    def render("show.json", %{provider: provider}) do
      %{data: render_one(provider, ProviderView, "provider.json")}
    end
  
    def render("provider.json", %{provider: provider}) do
        %{  id: provider.id,
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
  end