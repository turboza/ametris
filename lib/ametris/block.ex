defmodule Ametris.Block do
  alias Ametris.{Block, Crypto}

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

  @doc """
  Calculate and put the hash in the block
  """
  def with_hash(%Block{} = block) do
    %Block{block | hash: Crypto.hash(block)}
  end

  @doc """
  Check if a block is valid
  """
  def valid?(%Block{} = block) do
    Crypto.hash(block) == block.hash
  end

  def valid?(%Block{} = block, %Block{} = prev_block) do
    prev_block.hash == block.prev_hash && valid?(block)
  end
end
