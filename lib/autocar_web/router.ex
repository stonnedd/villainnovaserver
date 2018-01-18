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

  pipeline :api_auth do
    plug :accepts, ["json"]
    #plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    #plug Guardian.Plug.LoadResource
    plug Autocar.Auth.Pipeline
    #plug JaSerializer.Deserializer
  end

  scope "/", AutocarWeb do
    pipe_through :browser 
    get "/", PageController, :index
    resources "/suppliers", SupplierController
    resources "/services", ServiceController
    resources "/mainservices", MainserviceController
    resources "/users", UserController
  end

  scope "/api", AutocarWeb do
     pipe_through :api
         
     get "/services", ServiceController, :services
     get "/mainservices", MainserviceController, :mainservices
     
     post "/auth", AuthController, :sing_in
     post "/auth/signin", AuthController, :sing_in
     
     post "/users/create", UserController, :create_user
     get "/email/users/:email", UserController, :show_email
     get "/logged/user/:token", UserController, :get_user_by_token
     get "/user/:id", UserController, :get_user_by_id
     get "/user/full/:id", UserController, :show_full_data
     
     resources "/users", UserController do
      post "/provider", ProviderController, :add_provider
      post "/CMS/request", RequestController, :create 
      get "/CMS/request", RequestController, :get_by_user_id
     end
     get "/CMS/requests", RequestController, :index
     post "/CMS/:request_id/attachments", AttachmentController, :create
     put "/CMS/request/update/:id", RequestController, :update_request
     get "/CMS/request/show/:id", RequestController, :show
     get "/provider/:id/CMS/request/", RequestController, :get_request_by_provider;

     put "/provider/update/:id", ProviderController, :update_provider
     get "/providers/service/:service", ProviderController, :get_by_service
     get "/providers/user/:user_id", ProviderController, :get_by_user_id
     get "/providers", ProviderController, :index

     post "/uploader/image/:attachment_id/:url_pic", UploaderController, :upload_image
     resources "/attachments/create", AttachmentController
     
   end

  scope "/api_auth", AutocarWeb do
    pipe_through :api_auth
    get "/logged", LoggedController, :show_msg
  end 

end
