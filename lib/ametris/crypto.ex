defmodule Ametris.Crypto do
  @doc """
  Calculate hash of block
  """
  @spec hash(map(), list(atom())) :: String.t()
  def hash(block, hash_fields) do
    block
    |> Map.take(hash_fields)
    |> Jason.encode!()
    |> sha256
  end

  defp sha256(string) do
    :crypto.hash(:sha256, string) |> Base.encode16()
  end
end
