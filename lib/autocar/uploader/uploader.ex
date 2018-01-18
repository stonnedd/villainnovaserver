defmodule Autocar.Uploader do

    

    @root_dir   File.cwd!
    @tmp_dir    Path.join([@root_dir,"/lib/tmp/"])

    def upload_img(image_b64, attachment_id, url_pic)do
        {:ok, image} = Base.decode64(image_b64)
        |> IO.inspect
        File.write(Path.join([@tmp_dir,"#{attachment_id}.#{url_pic}.jpg"]), image, [:binary])
        |> IO.inspect
        case Cloudex.upload(Path.join([@tmp_dir,"#{attachment_id}.#{url_pic}.jpg"])) do
            {:ok, info} ->
                File.rm(Path.join([@tmp_dir,"#{attachment_id}.#{url_pic}.jpg"]))
                info.url    
            {:error, error} ->
                error
                |>IO.inspect 
        end
    end

    defp unique_filename(extension) do
        UUID.uuid4(:hex) <> extension
    end


    defp image_extension(<<0xff, 0xD8, _::binary>>), do: ".jpg"
    defp image_extension(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>), do: ".png"


    # file |> IO.inspect
    #     {:ok,file} = File.open("/tmp/file.jpg", [:read])
        

    # filename =
        #     image
        #     |> image_extension()
        #     |> unique_filename()
end