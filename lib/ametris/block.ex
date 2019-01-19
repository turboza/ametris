defmodule Ametris.Block do
  alias Ametris.{Block, Crypto}

  defstruct index: nil, data: "", timestamp: nil, prev_hash: nil, hash: nil

  @type t :: %__MODULE__{
          index: integer(),
          data: String.t(),
          timestamp: DateTime.t(),
          prev_hash: String.t(),
          hash: String.t()
        }

  @hash_fields [:index, :data, :timestamp, :prev_hash]

  @doc """
  Building a new block based on the previous hash data
  """
  @spec new(String.t(), Block.t()) :: Block.t()
  def new(data, prev_block) do
    block = %Block{
      index: prev_block.index + 1,
      data: data,
      prev_hash: prev_block.hash,
      timestamp: DateTime.utc_now()
    }

    %Block{block | hash: Crypto.hash(block, @hash_fields)}
  end

  @doc """
  Building an initial block of chain
  """
  @spec genesis() :: Block.t()
  def genesis do
    block = %Block{
      index: 0,
      data: "Hello Ametris",
      prev_hash: "GENESIS",
      timestamp: DateTime.utc_now()
    }

    %Block{block | hash: Crypto.hash(block, @hash_fields)}
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
    block.index == prev_block.index + 1 && prev_block.hash == block.prev_hash && valid?(block)
  end
end
