defmodule AutocarWeb.SupplierControllerTest do
  use AutocarWeb.ConnCase

  alias Autocar.Accounts

  @create_attrs %{address: "some address", brands: "some brands", email: "some email", lat: 120.5, lng: 120.5, manager: "some manager", map_icon: "some map_icon", name: "some name", phone: 42, phone_manager: 42, ranking: 42, schedule: "some schedule", service: "some service", specialty: "some specialty", website: "some website"}
  @update_attrs %{address: "some updated address", brands: "some updated brands", email: "some updated email", lat: 456.7, lng: 456.7, manager: "some updated manager", map_icon: "some updated map_icon", name: "some updated name", phone: 43, phone_manager: 43, ranking: 43, schedule: "some updated schedule", service: "some updated service", specialty: "some updated specialty", website: "some updated website"}
  @invalid_attrs %{address: nil, brands: nil, email: nil, lat: nil, lng: nil, manager: nil, map_icon: nil, name: nil, phone: nil, phone_manager: nil, ranking: nil, schedule: nil, service: nil, specialty: nil, website: nil}

  def fixture(:supplier) do
    {:ok, supplier} = Accounts.create_supplier(@create_attrs)
    supplier
  end

  describe "index" do
    test "lists all suppliers", %{conn: conn} do
      conn = get conn, supplier_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Suppliers"
    end
  end

  describe "new supplier" do
    test "renders form", %{conn: conn} do
      conn = get conn, supplier_path(conn, :new)
      assert html_response(conn, 200) =~ "New Supplier"
    end
  end

  describe "create supplier" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, supplier_path(conn, :create), supplier: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == supplier_path(conn, :show, id)

      conn = get conn, supplier_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Supplier"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, supplier_path(conn, :create), supplier: @invalid_attrs
      assert html_response(conn, 200) =~ "New Supplier"
    end
  end

  describe "edit supplier" do
    setup [:create_supplier]

    test "renders form for editing chosen supplier", %{conn: conn, supplier: supplier} do
      conn = get conn, supplier_path(conn, :edit, supplier)
      assert html_response(conn, 200) =~ "Edit Supplier"
    end
  end

  describe "update supplier" do
    setup [:create_supplier]

    test "redirects when data is valid", %{conn: conn, supplier: supplier} do
      conn = put conn, supplier_path(conn, :update, supplier), supplier: @update_attrs
      assert redirected_to(conn) == supplier_path(conn, :show, supplier)

      conn = get conn, supplier_path(conn, :show, supplier)
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, supplier: supplier} do
      conn = put conn, supplier_path(conn, :update, supplier), supplier: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Supplier"
    end
  end

  describe "delete supplier" do
    setup [:create_supplier]

    test "deletes chosen supplier", %{conn: conn, supplier: supplier} do
      conn = delete conn, supplier_path(conn, :delete, supplier)
      assert redirected_to(conn) == supplier_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, supplier_path(conn, :show, supplier)
      end
    end
  end

  defp create_supplier(_) do
    supplier = fixture(:supplier)
    {:ok, supplier: supplier}
  end
end
