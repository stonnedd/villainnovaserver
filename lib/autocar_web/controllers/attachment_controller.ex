defmodule AutocarWeb.AttachmentController do
  use AutocarWeb, :controller

  alias Autocar.CMS
  alias Autocar.CMS.Attachment

  action_fallback AutocarWeb.FallbackController

  def index(conn, _params) do
    attachments = CMS.list_attachments()
    render(conn, "index.json", attachments: attachments)
  end

  def create(conn, %{"attachment" => attachment_params}) do
    with {:ok, %Attachment{} = attachment} <- CMS.create_attachment(attachment_params) do
      conn
      # |> put_status(:created)
      # |> put_resp_header("location", attachment_path(conn, :show, attachment))
      |> render("show.json", attachment: attachment)
    end
  end

  def show(conn, %{"id" => id}) do
    attachment = CMS.get_attachment!(id)
    render(conn, "show.json", attachment: attachment)
  end

  def update(conn, %{"id" => id, "attachment" => attachment_params}) do
    attachment = CMS.get_attachment!(id)

    with {:ok, %Attachment{} = attachment} <- CMS.update_attachment(attachment, attachment_params) do
      render(conn, "show.json", attachment: attachment)
    end
  end

  def delete(conn, %{"id" => id}) do
    attachment = CMS.get_attachment!(id)
    with {:ok, %Attachment{}} <- CMS.delete_attachment(attachment) do
      send_resp(conn, :no_content, "")
    end
  end
end
