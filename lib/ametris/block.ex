defmodule Ametris.Block do
  alias Ametris.Block

  defstruct data: "", timestamp: nil, prev_hash: nil, hash: nil

  @doc """
  Building a new block based on the previous hash data
  """
  def new(data, prev_hash) do
    %Block{
      data: data,
      prev_hash: prev_hash,
      timestamp: DateTime.utc_now()
    }
  end

  @doc """
  Building an initial block of chain
  """
  def genesis do
    %Block{
      data: "Hello Ametris",
      prev_hash: "GENESIS",
      timestamp: DateTime.utc_now()
    }
  end
end
