defmodule Ametris.Blockchain do
  alias Ametris.Block

  @doc """
  Initialize a new blockchain with a genesis block
  """
  def new do
    [Block.genesis()]
  end

  @doc """
  Insert new data into the blockchain
  """
  def insert(blockchain, data) when is_list(blockchain) do
    %Block{hash: prev_hash} = hd(blockchain)

    [Block.new(data, prev_hash) | blockchain]
  end

  @doc """
  Validate the valid blockchain
  """
  def valid?([%Block{} = block]) do
    Block.valid?(block)
  end

  def valid?([block, prev_block | blockchain]) do
    Block.valid?(block, prev_block) && valid?([prev_block | blockchain])
  end
end
