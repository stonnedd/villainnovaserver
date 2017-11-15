defmodule AutocarWeb.GuardianSerializer do

    @behaviour Guardian.Serializer
    
    #import Ecto.Query
    alias Autocar.Repo
    alias Autocar.Accounts.Customer

    def for_token(customer = %Customer{}), do: { :ok, "Customer:#{Customer.id}" }
    def for_token(_), do: { :error, "Unknown resource type" }
    def from_token("Customer:" <> id), do: { :ok, Repo.get(Customer, id) }
    def from_token(_), do: { :error, "Unknown resource type" }

  end