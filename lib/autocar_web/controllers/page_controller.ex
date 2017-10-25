defmodule AutocarWeb.PageController do
  use AutocarWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
