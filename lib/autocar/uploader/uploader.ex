defmodule Autocar.Uploader do

    @root_dir   File.cwd!
    @tmp_dir    Path.join([@root_dir,"/lib/tmp/"])

    def upload_image(image_b64, attachment_id, url_pic)do
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

    def upload_img (image_b64)do
        {:ok, image} = Base.decode64(image_b64)
        |> IO.inspect
        name = UUID.uuid4(:hex)
        File.write(Path.join([@tmp_dir,"#{name}.jpg"]), image, [:binary])
        |> IO.inspect
        case Cloudex.upload(Path.join([@tmp_dir,"#{name}.jpg"])) do
            {:ok, info} ->
                File.rm(Path.join([@tmp_dir,"#{name}.jpg"]))
                info.url    
            {:error, error} ->
                error
        end
    end

    defp image_extension(<<0xff, 0xD8, _::binary>>), do: ".jpg"
    defp image_extension(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>), do: ".png"

   
end