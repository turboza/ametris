defmodule Ametris.Block do
  alias Ametris.{Block, Crypto}

  defstruct data: "", timestamp: nil, prev_hash: nil, hash: nil

  @type t :: %__MODULE__{
          data: String.t(),
          timestamp: DateTime.t(),
          prev_hash: String.t(),
          hash: String.t()
        }

  @hash_fields [:data, :timestamp, :prev_hash]

  @doc """
  Building a new block based on the previous hash data
  """
  @spec new(String.t(), String.t()) :: Block.t()
  def new(data, prev_hash) do
    block = %Block{
      data: data,
      prev_hash: prev_hash,
      timestamp: DateTime.utc_now()
    }

    %Block{block | hash: Crypto.hash(block, @hash_fields)}
  end

  @doc """
  Building an initial block of chain
  """
  @spec genesis() :: Block.t()
  def genesis do
    new("Hello Ametris", "GENESIS")
  end

  @doc """
  Check if a block is valid
  """
  @spec valid?(Block.t()) :: boolean()
  def valid?(%Block{} = block) do
    Crypto.hash(block, @hash_fields) == block.hash
  end

  @spec valid?(Block.t(), Block.t()) :: boolean()
  def valid?(%Block{} = block, %Block{} = prev_block) do
    prev_block.hash == block.prev_hash && valid?(block)
  end
end
