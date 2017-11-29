defmodule AutocarWeb.LoggedController do
    use AutocarWeb, :controller

    def show_msg(conn, _params) do
        json conn,  Poison.Parser.parse!(~s({"name": "Devin Torres", "age": 27}))
    end

end    