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

  describe "attachments" do
    alias Autocar.CMS.Attachment

    @valid_attrs %{url_pic1: "some url_pic1", url_pic2: "some url_pic2", url_pic3: "some url_pic3"}
    @update_attrs %{url_pic1: "some updated url_pic1", url_pic2: "some updated url_pic2", url_pic3: "some updated url_pic3"}
    @invalid_attrs %{url_pic1: nil, url_pic2: nil, url_pic3: nil}

    def attachment_fixture(attrs \\ %{}) do
      {:ok, attachment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_attachment()

      attachment
    end

    test "list_attachments/0 returns all attachments" do
      attachment = attachment_fixture()
      assert CMS.list_attachments() == [attachment]
    end

    test "get_attachment!/1 returns the attachment with given id" do
      attachment = attachment_fixture()
      assert CMS.get_attachment!(attachment.id) == attachment
    end

    test "create_attachment/1 with valid data creates a attachment" do
      assert {:ok, %Attachment{} = attachment} = CMS.create_attachment(@valid_attrs)
      assert attachment.url_pic1 == "some url_pic1"
      assert attachment.url_pic2 == "some url_pic2"
      assert attachment.url_pic3 == "some url_pic3"
    end

    test "create_attachment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_attachment(@invalid_attrs)
    end

    test "update_attachment/2 with valid data updates the attachment" do
      attachment = attachment_fixture()
      assert {:ok, attachment} = CMS.update_attachment(attachment, @update_attrs)
      assert %Attachment{} = attachment
      assert attachment.url_pic1 == "some updated url_pic1"
      assert attachment.url_pic2 == "some updated url_pic2"
      assert attachment.url_pic3 == "some updated url_pic3"
    end

    test "update_attachment/2 with invalid data returns error changeset" do
      attachment = attachment_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_attachment(attachment, @invalid_attrs)
      assert attachment == CMS.get_attachment!(attachment.id)
    end

    test "delete_attachment/1 deletes the attachment" do
      attachment = attachment_fixture()
      assert {:ok, %Attachment{}} = CMS.delete_attachment(attachment)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_attachment!(attachment.id) end
    end

    test "change_attachment/1 returns a attachment changeset" do
      attachment = attachment_fixture()
      assert %Ecto.Changeset{} = CMS.change_attachment(attachment)
    end
  end
end
