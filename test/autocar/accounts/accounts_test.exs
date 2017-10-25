defmodule Autocar.AccountsTest do
  use Autocar.DataCase

  alias Autocar.Accounts

  describe "suppliers" do
    alias Autocar.Accounts.Supplier

    @valid_attrs %{address: "some address", brands: "some brands", email: "some email", lat: 120.5, lng: 120.5, manager: "some manager", map_icon: "some map_icon", name: "some name", phone: 42, phone_manager: 42, ranking: 42, schedule: "some schedule", service: "some service", specialty: "some specialty", website: "some website"}
    @update_attrs %{address: "some updated address", brands: "some updated brands", email: "some updated email", lat: 456.7, lng: 456.7, manager: "some updated manager", map_icon: "some updated map_icon", name: "some updated name", phone: 43, phone_manager: 43, ranking: 43, schedule: "some updated schedule", service: "some updated service", specialty: "some updated specialty", website: "some updated website"}
    @invalid_attrs %{address: nil, brands: nil, email: nil, lat: nil, lng: nil, manager: nil, map_icon: nil, name: nil, phone: nil, phone_manager: nil, ranking: nil, schedule: nil, service: nil, specialty: nil, website: nil}

    def supplier_fixture(attrs \\ %{}) do
      {:ok, supplier} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_supplier()

      supplier
    end

    test "list_suppliers/0 returns all suppliers" do
      supplier = supplier_fixture()
      assert Accounts.list_suppliers() == [supplier]
    end

    test "get_supplier!/1 returns the supplier with given id" do
      supplier = supplier_fixture()
      assert Accounts.get_supplier!(supplier.id) == supplier
    end

    test "create_supplier/1 with valid data creates a supplier" do
      assert {:ok, %Supplier{} = supplier} = Accounts.create_supplier(@valid_attrs)
      assert supplier.address == "some address"
      assert supplier.brands == "some brands"
      assert supplier.email == "some email"
      assert supplier.lat == 120.5
      assert supplier.lng == 120.5
      assert supplier.manager == "some manager"
      assert supplier.map_icon == "some map_icon"
      assert supplier.name == "some name"
      assert supplier.phone == 42
      assert supplier.phone_manager == 42
      assert supplier.ranking == 42
      assert supplier.schedule == "some schedule"
      assert supplier.service == "some service"
      assert supplier.specialty == "some specialty"
      assert supplier.website == "some website"
    end

    test "create_supplier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_supplier(@invalid_attrs)
    end

    test "update_supplier/2 with valid data updates the supplier" do
      supplier = supplier_fixture()
      assert {:ok, supplier} = Accounts.update_supplier(supplier, @update_attrs)
      assert %Supplier{} = supplier
      assert supplier.address == "some updated address"
      assert supplier.brands == "some updated brands"
      assert supplier.email == "some updated email"
      assert supplier.lat == 456.7
      assert supplier.lng == 456.7
      assert supplier.manager == "some updated manager"
      assert supplier.map_icon == "some updated map_icon"
      assert supplier.name == "some updated name"
      assert supplier.phone == 43
      assert supplier.phone_manager == 43
      assert supplier.ranking == 43
      assert supplier.schedule == "some updated schedule"
      assert supplier.service == "some updated service"
      assert supplier.specialty == "some updated specialty"
      assert supplier.website == "some updated website"
    end

    test "update_supplier/2 with invalid data returns error changeset" do
      supplier = supplier_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_supplier(supplier, @invalid_attrs)
      assert supplier == Accounts.get_supplier!(supplier.id)
    end

    test "delete_supplier/1 deletes the supplier" do
      supplier = supplier_fixture()
      assert {:ok, %Supplier{}} = Accounts.delete_supplier(supplier)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_supplier!(supplier.id) end
    end

    test "change_supplier/1 returns a supplier changeset" do
      supplier = supplier_fixture()
      assert %Ecto.Changeset{} = Accounts.change_supplier(supplier)
    end
  end
end
