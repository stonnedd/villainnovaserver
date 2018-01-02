defmodule Autocar.CMSTest do
  use Autocar.DataCase

  alias Autocar.CMS

  describe "requests" do
    alias Autocar.CMS.Request

    @valid_attrs %{binary: "some binary", comment: "some comment", lat: 120.5, lng: 120.5, pic1: "some pic1", pic2: "some pic2", pic3: "some pic3", pic_type: "some pic_type", service: "some service", vehicle: "some vehicle"}
    @update_attrs %{binary: "some updated binary", comment: "some updated comment", lat: 456.7, lng: 456.7, pic1: "some updated pic1", pic2: "some updated pic2", pic3: "some updated pic3", pic_type: "some updated pic_type", service: "some updated service", vehicle: "some updated vehicle"}
    @invalid_attrs %{binary: nil, comment: nil, lat: nil, lng: nil, pic1: nil, pic2: nil, pic3: nil, pic_type: nil, service: nil, vehicle: nil}

    def request_fixture(attrs \\ %{}) do
      {:ok, request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_request()

      request
    end

    test "list_requests/0 returns all requests" do
      request = request_fixture()
      assert CMS.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id" do
      request = request_fixture()
      assert CMS.get_request!(request.id) == request
    end

    test "create_request/1 with valid data creates a request" do
      assert {:ok, %Request{} = request} = CMS.create_request(@valid_attrs)
      assert request.binary == "some binary"
      assert request.comment == "some comment"
      assert request.lat == 120.5
      assert request.lng == 120.5
      assert request.pic1 == "some pic1"
      assert request.pic2 == "some pic2"
      assert request.pic3 == "some pic3"
      assert request.pic_type == "some pic_type"
      assert request.service == "some service"
      assert request.vehicle == "some vehicle"
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request" do
      request = request_fixture()
      assert {:ok, request} = CMS.update_request(request, @update_attrs)
      assert %Request{} = request
      assert request.binary == "some updated binary"
      assert request.comment == "some updated comment"
      assert request.lat == 456.7
      assert request.lng == 456.7
      assert request.pic1 == "some updated pic1"
      assert request.pic2 == "some updated pic2"
      assert request.pic3 == "some updated pic3"
      assert request.pic_type == "some updated pic_type"
      assert request.service == "some updated service"
      assert request.vehicle == "some updated vehicle"
    end

    test "update_request/2 with invalid data returns error changeset" do
      request = request_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_request(request, @invalid_attrs)
      assert request == CMS.get_request!(request.id)
    end

    test "delete_request/1 deletes the request" do
      request = request_fixture()
      assert {:ok, %Request{}} = CMS.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset" do
      request = request_fixture()
      assert %Ecto.Changeset{} = CMS.change_request(request)
    end
  end
end
