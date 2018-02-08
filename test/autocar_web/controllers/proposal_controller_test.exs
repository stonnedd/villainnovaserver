defmodule AutocarWeb.ProposalControllerTest do
  use AutocarWeb.ConnCase

  alias Autocar.CMS
  alias Autocar.CMS.Proposal

  @create_attrs %{c_status: 42, comment: "some comment", p_status: 42, price: 42, time: "some time"}
  @update_attrs %{c_status: 43, comment: "some updated comment", p_status: 43, price: 43, time: "some updated time"}
  @invalid_attrs %{c_status: nil, comment: nil, p_status: nil, price: nil, time: nil}

  def fixture(:proposal) do
    {:ok, proposal} = CMS.create_proposal(@create_attrs)
    proposal
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all proposals", %{conn: conn} do
      conn = get conn, proposal_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create proposal" do
    test "renders proposal when data is valid", %{conn: conn} do
      conn = post conn, proposal_path(conn, :create), proposal: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, proposal_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "c_status" => 42,
        "comment" => "some comment",
        "p_status" => 42,
        "price" => 42,
        "time" => "some time"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, proposal_path(conn, :create), proposal: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update proposal" do
    setup [:create_proposal]

    test "renders proposal when data is valid", %{conn: conn, proposal: %Proposal{id: id} = proposal} do
      conn = put conn, proposal_path(conn, :update, proposal), proposal: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, proposal_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "c_status" => 43,
        "comment" => "some updated comment",
        "p_status" => 43,
        "price" => 43,
        "time" => "some updated time"}
    end

    test "renders errors when data is invalid", %{conn: conn, proposal: proposal} do
      conn = put conn, proposal_path(conn, :update, proposal), proposal: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete proposal" do
    setup [:create_proposal]

    test "deletes chosen proposal", %{conn: conn, proposal: proposal} do
      conn = delete conn, proposal_path(conn, :delete, proposal)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, proposal_path(conn, :show, proposal)
      end
    end
  end

  defp create_proposal(_) do
    proposal = fixture(:proposal)
    {:ok, proposal: proposal}
  end
end
