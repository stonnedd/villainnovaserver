defmodule AutocarWeb.Router do
  use AutocarWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AutocarWeb do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    resources "/suppliers", SupplierController
    resources "/services", ServiceController
    resources "/mainservices", MainserviceController
    resources "/customers", CustomerController
  end

  #Other scopes may use custom stacks.
   scope "/api", AutocarWeb do
     pipe_through :api
     get "/suppliers", SupplierController, :allsuppliers
     get "/suppliers/:service", SupplierController, :selectedservice
     get "/services", ServiceController, :services
     get "/mainservices", MainserviceController, :mainservices
     get "/email/customers/:email", CustomerController, :showemail
     get "/email/suppliers/:email", SupplierController, :showemail
     post "/suppliers/create", SupplierController, :createsupplier
     post "/customers/create", CustomerController, :createcustomer
     resources "/sessions", SessionController, only: [:new, :create, :delete]
   end
end
