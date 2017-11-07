defmodule AutocarWeb.MainserviceControllerTest do
  use AutocarWeb.ConnCase

  alias Autocar.Catalogs

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:mainservice) do
    {:ok, mainservice} = Catalogs.create_mainservice(@create_attrs)
    mainservice
  end

  describe "index" do
    test "lists all mainservices", %{conn: conn} do
      conn = get conn, mainservice_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Mainservices"
    end
  end

  describe "new mainservice" do
    test "renders form", %{conn: conn} do
      conn = get conn, mainservice_path(conn, :new)
      assert html_response(conn, 200) =~ "New Mainservice"
    end
  end

  describe "create mainservice" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, mainservice_path(conn, :create), mainservice: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == mainservice_path(conn, :show, id)

      conn = get conn, mainservice_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Mainservice"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, mainservice_path(conn, :create), mainservice: @invalid_attrs
      assert html_response(conn, 200) =~ "New Mainservice"
    end
  end

  describe "edit mainservice" do
    setup [:create_mainservice]

    test "renders form for editing chosen mainservice", %{conn: conn, mainservice: mainservice} do
      conn = get conn, mainservice_path(conn, :edit, mainservice)
      assert html_response(conn, 200) =~ "Edit Mainservice"
    end
  end

  describe "update mainservice" do
    setup [:create_mainservice]

    test "redirects when data is valid", %{conn: conn, mainservice: mainservice} do
      conn = put conn, mainservice_path(conn, :update, mainservice), mainservice: @update_attrs
      assert redirected_to(conn) == mainservice_path(conn, :show, mainservice)

      conn = get conn, mainservice_path(conn, :show, mainservice)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, mainservice: mainservice} do
      conn = put conn, mainservice_path(conn, :update, mainservice), mainservice: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Mainservice"
    end
  end

  describe "delete mainservice" do
    setup [:create_mainservice]

    test "deletes chosen mainservice", %{conn: conn, mainservice: mainservice} do
      conn = delete conn, mainservice_path(conn, :delete, mainservice)
      assert redirected_to(conn) == mainservice_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, mainservice_path(conn, :show, mainservice)
      end
    end
  end

  defp create_mainservice(_) do
    mainservice = fixture(:mainservice)
    {:ok, mainservice: mainservice}
  end
end
