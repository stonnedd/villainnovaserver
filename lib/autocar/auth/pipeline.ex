defmodule Autocar.Auth.Pipeline do
    use Guardian.Plug.Pipeline,
      otp_app: :autocar,
      error_handler: Autocar.Auth.AuthErrorHandler,
      module: Autocar.Auth.Guardian
  
    plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    plug Guardian.Plug.LoadResource, allow_blank: true
end