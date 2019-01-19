defmodule Ametris.Blockchain do
  alias Ametris.Block

  @doc """
  Initialize a new blockchain with a genesis block
  """
  @spec new() :: [Block.t()]
  def new do
    [Block.genesis()]
  end

  @doc """
  Insert new data into the blockchain
  """
  @spec insert(list(Block.t()), String.t()) :: list(Block.t())
  def insert(blockchain, data) when is_list(blockchain) do
    [Block.new(data, hd(blockchain)) | blockchain]
  end

  @doc """
  Validate the valid blockchain
  """
  @spec valid?(list(Block.t())) :: boolean()
  def valid?([%Block{} = block]) do
    Block.valid?(block)
  end

  def valid?([block, prev_block | blockchain]) do
    Block.valid?(block, prev_block) && valid?([prev_block | blockchain])
  end
end
