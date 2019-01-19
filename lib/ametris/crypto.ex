defmodule Ametris.Crypto do
  alias Ametris.Block

  @hash_fields [:data, :timestamp, :prev_hash]

  @doc """
  Calculate hash of block
  """
  def hash(%Block{} = block) do
    block
    |> Map.take(@hash_fields)
    |> Jason.encode!()
    |> sha256
  end

  defp sha256(string) do
    :crypto.hash(:sha256, string) |> Base.encode16()
  end
end
