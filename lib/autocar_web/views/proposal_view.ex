defmodule AutocarWeb.ProposalView do
  use AutocarWeb, :view
  alias AutocarWeb.ProposalView

  def render("index.json", %{proposals: proposals}) do
    %{data: render_many(proposals, ProposalView, "proposal.json")}
  end

  def render("show.json", %{proposal: proposal}) do
    %{data: render_one(proposal, ProposalView, "proposal.json")}
  end

  def render("proposal.json", %{proposal: proposal}) do
    %{id: proposal.id,
      price: proposal.price,
      time: proposal.time,
      comment: proposal.comment,
      c_status: proposal.c_status,
      p_status: proposal.p_status}
  end
end
