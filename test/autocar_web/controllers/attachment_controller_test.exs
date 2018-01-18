defmodule AutocarWeb.AttachmentControllerTest do
  use AutocarWeb.ConnCase

  alias Autocar.CMS
  alias Autocar.CMS.Attachment

  @create_attrs %{url_pic1: "some url_pic1", url_pic2: "some url_pic2", url_pic3: "some url_pic3"}
  @update_attrs %{url_pic1: "some updated url_pic1", url_pic2: "some updated url_pic2", url_pic3: "some updated url_pic3"}
  @invalid_attrs %{url_pic1: nil, url_pic2: nil, url_pic3: nil}

  def fixture(:attachment) do
    {:ok, attachment} = CMS.create_attachment(@create_attrs)
    attachment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all attachments", %{conn: conn} do
      conn = get conn, attachment_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create attachment" do
    test "renders attachment when data is valid", %{conn: conn} do
      conn = post conn, attachment_path(conn, :create), attachment: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, attachment_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "url_pic1" => "some url_pic1",
        "url_pic2" => "some url_pic2",
        "url_pic3" => "some url_pic3"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, attachment_path(conn, :create), attachment: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update attachment" do
    setup [:create_attachment]

    test "renders attachment when data is valid", %{conn: conn, attachment: %Attachment{id: id} = attachment} do
      conn = put conn, attachment_path(conn, :update, attachment), attachment: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, attachment_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "url_pic1" => "some updated url_pic1",
        "url_pic2" => "some updated url_pic2",
        "url_pic3" => "some updated url_pic3"}
    end

    test "renders errors when data is invalid", %{conn: conn, attachment: attachment} do
      conn = put conn, attachment_path(conn, :update, attachment), attachment: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete attachment" do
    setup [:create_attachment]

    test "deletes chosen attachment", %{conn: conn, attachment: attachment} do
      conn = delete conn, attachment_path(conn, :delete, attachment)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, attachment_path(conn, :show, attachment)
      end
    end
  end

  defp create_attachment(_) do
    attachment = fixture(:attachment)
    {:ok, attachment: attachment}
  end
end
