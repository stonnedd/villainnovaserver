defmodule Autocar.CatalogsTest do
  use Autocar.DataCase

  alias Autocar.Catalogs

  describe "services" do
    alias Autocar.Catalogs.Service

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def service_fixture(attrs \\ %{}) do
      {:ok, service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalogs.create_service()

      service
    end

    test "list_services/0 returns all services" do
      service = service_fixture()
      assert Catalogs.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Catalogs.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      assert {:ok, %Service{} = service} = Catalogs.create_service(@valid_attrs)
      assert service.name == "some name"
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalogs.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      assert {:ok, service} = Catalogs.update_service(service, @update_attrs)
      assert %Service{} = service
      assert service.name == "some updated name"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalogs.update_service(service, @invalid_attrs)
      assert service == Catalogs.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Catalogs.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Catalogs.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Catalogs.change_service(service)
    end
  end

  describe "mainservices" do
    alias Autocar.Catalogs.Mainservice

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def mainservice_fixture(attrs \\ %{}) do
      {:ok, mainservice} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalogs.create_mainservice()

      mainservice
    end

    test "list_mainservices/0 returns all mainservices" do
      mainservice = mainservice_fixture()
      assert Catalogs.list_mainservices() == [mainservice]
    end

    test "get_mainservice!/1 returns the mainservice with given id" do
      mainservice = mainservice_fixture()
      assert Catalogs.get_mainservice!(mainservice.id) == mainservice
    end

    test "create_mainservice/1 with valid data creates a mainservice" do
      assert {:ok, %Mainservice{} = mainservice} = Catalogs.create_mainservice(@valid_attrs)
      assert mainservice.name == "some name"
    end

    test "create_mainservice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalogs.create_mainservice(@invalid_attrs)
    end

    test "update_mainservice/2 with valid data updates the mainservice" do
      mainservice = mainservice_fixture()
      assert {:ok, mainservice} = Catalogs.update_mainservice(mainservice, @update_attrs)
      assert %Mainservice{} = mainservice
      assert mainservice.name == "some updated name"
    end

    test "update_mainservice/2 with invalid data returns error changeset" do
      mainservice = mainservice_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalogs.update_mainservice(mainservice, @invalid_attrs)
      assert mainservice == Catalogs.get_mainservice!(mainservice.id)
    end

    test "delete_mainservice/1 deletes the mainservice" do
      mainservice = mainservice_fixture()
      assert {:ok, %Mainservice{}} = Catalogs.delete_mainservice(mainservice)
      assert_raise Ecto.NoResultsError, fn -> Catalogs.get_mainservice!(mainservice.id) end
    end

    test "change_mainservice/1 returns a mainservice changeset" do
      mainservice = mainservice_fixture()
      assert %Ecto.Changeset{} = Catalogs.change_mainservice(mainservice)
    end
  end
end
