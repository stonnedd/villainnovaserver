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

  describe "customers" do
    alias Autocar.Accounts.Customer

    @valid_attrs %{email: "some email", name: "some name", password: "some password", phone: 42}
    @update_attrs %{email: "some updated email", name: "some updated name", password: "some updated password", phone: 43}
    @invalid_attrs %{email: nil, name: nil, password: nil, phone: nil}

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Accounts.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Accounts.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Accounts.create_customer(@valid_attrs)
      assert customer.email == "some email"
      assert customer.name == "some name"
      assert customer.password == "some password"
      assert customer.phone == 42
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, customer} = Accounts.update_customer(customer, @update_attrs)
      assert %Customer{} = customer
      assert customer.email == "some updated email"
      assert customer.name == "some updated name"
      assert customer.password == "some updated password"
      assert customer.phone == 43
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_customer(customer, @invalid_attrs)
      assert customer == Accounts.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Accounts.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Accounts.change_customer(customer)
    end
  end

  describe "users" do
    alias Autocar.Accounts.User

    @valid_attrs %{email: "some email", hash_password: "some hash_password", profile: "some profile", token: "some token"}
    @update_attrs %{email: "some updated email", hash_password: "some updated hash_password", profile: "some updated profile", token: "some updated token"}
    @invalid_attrs %{email: nil, hash_password: nil, profile: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.hash_password == "some hash_password"
      assert user.profile == "some profile"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.hash_password == "some updated hash_password"
      assert user.profile == "some updated profile"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "providers" do
    alias Autocar.Accounts.Provider

    @valid_attrs %{address: "some address", aditional_phone: "some aditional_phone", brands: "some brands", company_name: "some company_name", is_active: true, lat: 120.5, lng: 120.5, map_icon: "some map_icon", ranking: 120.5, schedule: "some schedule", service: "some service", specialty: "some specialty", website: "some website"}
    @update_attrs %{address: "some updated address", aditional_phone: "some updated aditional_phone", brands: "some updated brands", company_name: "some updated company_name", is_active: false, lat: 456.7, lng: 456.7, map_icon: "some updated map_icon", ranking: 456.7, schedule: "some updated schedule", service: "some updated service", specialty: "some updated specialty", website: "some updated website"}
    @invalid_attrs %{address: nil, aditional_phone: nil, brands: nil, company_name: nil, is_active: nil, lat: nil, lng: nil, map_icon: nil, ranking: nil, schedule: nil, service: nil, specialty: nil, website: nil}

    def provider_fixture(attrs \\ %{}) do
      {:ok, provider} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_provider()

      provider
    end

    test "list_providers/0 returns all providers" do
      provider = provider_fixture()
      assert Accounts.list_providers() == [provider]
    end

    test "get_provider!/1 returns the provider with given id" do
      provider = provider_fixture()
      assert Accounts.get_provider!(provider.id) == provider
    end

    test "create_provider/1 with valid data creates a provider" do
      assert {:ok, %Provider{} = provider} = Accounts.create_provider(@valid_attrs)
      assert provider.address == "some address"
      assert provider.aditional_phone == "some aditional_phone"
      assert provider.brands == "some brands"
      assert provider.company_name == "some company_name"
      assert provider.is_active == true
      assert provider.lat == 120.5
      assert provider.lng == 120.5
      assert provider.map_icon == "some map_icon"
      assert provider.ranking == 120.5
      assert provider.schedule == "some schedule"
      assert provider.service == "some service"
      assert provider.specialty == "some specialty"
      assert provider.website == "some website"
    end

    test "create_provider/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_provider(@invalid_attrs)
    end

    test "update_provider/2 with valid data updates the provider" do
      provider = provider_fixture()
      assert {:ok, provider} = Accounts.update_provider(provider, @update_attrs)
      assert %Provider{} = provider
      assert provider.address == "some updated address"
      assert provider.aditional_phone == "some updated aditional_phone"
      assert provider.brands == "some updated brands"
      assert provider.company_name == "some updated company_name"
      assert provider.is_active == false
      assert provider.lat == 456.7
      assert provider.lng == 456.7
      assert provider.map_icon == "some updated map_icon"
      assert provider.ranking == 456.7
      assert provider.schedule == "some updated schedule"
      assert provider.service == "some updated service"
      assert provider.specialty == "some updated specialty"
      assert provider.website == "some updated website"
    end

    test "update_provider/2 with invalid data returns error changeset" do
      provider = provider_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_provider(provider, @invalid_attrs)
      assert provider == Accounts.get_provider!(provider.id)
    end

    test "delete_provider/1 deletes the provider" do
      provider = provider_fixture()
      assert {:ok, %Provider{}} = Accounts.delete_provider(provider)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_provider!(provider.id) end
    end

    test "change_provider/1 returns a provider changeset" do
      provider = provider_fixture()
      assert %Ecto.Changeset{} = Accounts.change_provider(provider)
    end
  end
end
