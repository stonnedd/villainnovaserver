defmodule AutocarWeb.UploaderController do
    use AutocarWeb, :controller
    
    alias Autocar.Uploader
    alias Autocar.CMS
    alias Autocar.CMS.Attachment

    def upload_image(conn, %{"image"=> image_b64, "attachment_id"=> attachment_id, "url_pic"=> url_pic}) do
        resp = Uploader.upload_img(image_b64, attachment_id, url_pic)
        attachment_params = %{"url_pic#{url_pic}": resp}
        attachment = CMS.get_attachment!(attachment_id)
        with {:ok, %Attachment{} = attachment} <- CMS.update_attachment(attachment, attachment_params) do
          json conn, attachment_params
        end
    end

end