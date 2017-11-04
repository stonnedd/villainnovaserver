defmodule AutocarWeb.SupplierView do
  use AutocarWeb, :view
  alias AutocarWeb.SupplierView

  # def render("index.json", %{suppliers: suppliers}) do
  #   render_many(suppliers, AutocarWeb.PageView, "suppliers.json")
  # end

  def render("show.json", %{supplier: supplier}) do
    %{data: render_one(supplier, SupplierView, "supplier.json")}
  end

  def render("supplier.json", %{supplier: supplier}) do
    %{id: supplier.id,
      name: supplier.name,
      email: supplier.email,
      password: supplier.password,
      website: supplier.website,
      specialty: supplier.specialty,
      service: supplier.service,
      schedule: supplier.schedule,
      ranking: supplier.ranking,
      phone_manager: supplier.phone_manager,
      phone: supplier.phone,
      map_icon: supplier.map_icon,
      manager: supplier.manager,
      lng: supplier.lng,
      lat: supplier.lat,
      brands: supplier.brands,
      address: supplier.address
    }
  end

end
