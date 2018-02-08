defmodule AutocarWeb.ProposalController do
  use AutocarWeb, :controller

  alias Autocar.CMS
  alias Autocar.CMS.Proposal

  #action_fallback AutocarWeb.FallbackController

  def index(conn, _params) do
    proposals = CMS.list_proposals()
    render(conn, "index.json", proposals: proposals)
  end

  def create(conn, %{"proposal" => proposal_params}) do
    with {:ok, %Proposal{} = proposal} <- CMS.create_proposal(proposal_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", proposal_path(conn, :show, proposal))
      render(conn, "show.json", proposal: proposal)
    end
  end

  def show(conn, %{"id" => id}) do
    proposal = CMS.get_proposal!(id)
    render(conn, "show.json", proposal: proposal)
  end

  def update(conn, %{"id" => id, "proposal" => proposal_params}) do
    proposal = CMS.get_proposal!(id)

    with {:ok, %Proposal{} = proposal} <- CMS.update_proposal(proposal, proposal_params) do
      render(conn, "show.json", proposal: proposal)
    end
  end

  def delete(conn, %{"id" => id}) do
    proposal = CMS.get_proposal!(id)
    with {:ok, %Proposal{}} <- CMS.delete_proposal(proposal) do
      send_resp(conn, :no_content, "")
    end
  end
end
