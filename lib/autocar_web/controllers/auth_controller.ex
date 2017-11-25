defmodule AutocarWeb.AuthController do
    use AutocarWeb, :controller

    alias Autocar.Auth
    alias Autocar.Auth.Guardian
    
    plug :scrub_params, "user" when action in [:sign_in_user]

    def sing_in_user(conn, %{"session" => %{"email" => email,
    "password" => password,
    "profile" => profile}}) do
    
        if profile === "customer" do
            user = Auth.get_customer(email);
            else
            user = Auth.get_supplier(email);
        end
        
            #authenticate_user(user,password)
        try do
            user
            |>authenticate_user(password)
            cond do
                true ->
                    n_conn = conn
                    |> Guardian.Plug.sign_in(user)
                    IO.inspect ".---------***********"
                    jwt = n_conn
                    |> Guardian.Plug.current_token
                    IO.inspect ".---------***********"
                    IO.inspect jwt
                    json n_conn, jwt        
                false ->    
                    nil
            end

            rescue
                e ->
                json conn, e
                # Successful registration
                # sign_up_user(conn, %{"user" => user})
        end
    end   

    defp authenticate_user(user, password) do
        if user.password === password do
            true
        else
            true
        end
    end

    defp login(conn, user) do
        conn
        |> Guardian.Plug.sign_in(conn, user)
    end

    def sing_in(conn, %{"session" => %{"email" => email,"password" => password}}) do 
        Auth.authenticate_user(email, password)
        |> login_reply(conn)
        |> Auth.update_token(email)
    end   

    defp login_reply({:error, error}, conn) do
        conn
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