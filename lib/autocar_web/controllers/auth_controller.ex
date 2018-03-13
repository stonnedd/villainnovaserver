defmodule AutocarWeb.AuthController do
    use AutocarWeb, :controller

    alias Autocar.Auth
    alias Autocar.Auth.Guardian
    
    plug :scrub_params, "user" when action in [:sign_in_user]
   
    def sing_in(conn, %{"session" => %{"email" => email,"password" => password}}) do 
        Auth.authenticate_user(email, password)
        |> login_reply(conn)
        |> Auth.update_token(email)
        conn
    end   

    defp login_reply({:error, error}, conn) do
        #conn
        json conn, error
    end
    
    defp login_reply({:ok, user}, conn) do
        new_conn = conn
        |> Guardian.Plug.sign_in(user)
        jwt = new_conn
        |> Guardian.Plug.current_token
        json conn, jwt
        jwt
    end

end