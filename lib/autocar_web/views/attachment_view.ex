defmodule AutocarWeb.AttachmentView do
  use AutocarWeb, :view
  alias AutocarWeb.AttachmentView

  def render("index.json", %{attachments: attachments}) do
    %{data: render_many(attachments, AttachmentView, "attachment.json")}
  end

  def render("show.json", %{attachment: attachment}) do
    %{data: render_one(attachment, AttachmentView, "attachment.json")}
  end

  def render("attachment.json", %{attachment: attachment}) do
    %{id: attachment.id,
      url_pic1: attachment.url_pic1,
      url_pic2: attachment.url_pic2,
      url_pic3: attachment.url_pic3,
      request_id: attachment.request_id,
    }
  end
end
