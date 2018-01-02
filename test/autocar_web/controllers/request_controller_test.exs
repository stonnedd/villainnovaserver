defmodule AutocarWeb.RequestControllerTest do
  use AutocarWeb.ConnCase

  alias Autocar.CMS
  alias Autocar.CMS.Request

  @create_attrs %{binary: "some binary", comment: "some comment", lat: 120.5, lng: 120.5, pic1: "some pic1", pic2: "some pic2", pic3: "some pic3", pic_type: "some pic_type", service: "some service", vehicle: "some vehicle"}
  @update_attrs %{binary: "some updated binary", comment: "some updated comment", lat: 456.7, lng: 456.7, pic1: "some updated pic1", pic2: "some updated pic2", pic3: "some updated pic3", pic_type: "some updated pic_type", service: "some updated service", vehicle: "some updated vehicle"}
  @invalid_attrs %{binary: nil, comment: nil, lat: nil, lng: nil, pic1: nil, pic2: nil, pic3: nil, pic_type: nil, service: nil, vehicle: nil}

  def fixture(:request) do
    {:ok, request} = CMS.create_request(@create_attrs)
    request
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all requests", %{conn: conn} do
      conn = get conn, request_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create request" do
    test "renders request when data is valid", %{conn: conn} do
      conn = post conn, request_path(conn, :create), request: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, request_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "binary" => "some binary",
        "comment" => "some comment",
        "lat" => 120.5,
        "lng" => 120.5,
        "pic1" => "some pic1",
        "pic2" => "some pic2",
        "pic3" => "some pic3",
        "pic_type" => "some pic_type",
        "service" => "some service",
        "vehicle" => "some vehicle"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, request_path(conn, :create), request: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update request" do
    setup [:create_request]

    test "renders request when data is valid", %{conn: conn, request: %Request{id: id} = request} do
      conn = put conn, request_path(conn, :update, request), request: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, request_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "binary" => "some updated binary",
        "comment" => "some updated comment",
        "lat" => 456.7,
        "lng" => 456.7,
        "pic1" => "some updated pic1",
        "pic2" => "some updated pic2",
        "pic3" => "some updated pic3",
        "pic_type" => "some updated pic_type",
        "service" => "some updated service",
        "vehicle" => "some updated vehicle"}
    end

    test "renders errors when data is invalid", %{conn: conn, request: request} do
      conn = put conn, request_path(conn, :update, request), request: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete request" do
    setup [:create_request]

    test "deletes chosen request", %{conn: conn, request: request} do
      conn = delete conn, request_path(conn, :delete, request)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, request_path(conn, :show, request)
      end
    end
  end

  defp create_request(_) do
    request = fixture(:request)
    {:ok, request: request}
  end
end
