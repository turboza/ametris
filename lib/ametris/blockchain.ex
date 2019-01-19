defmodule Ametris.Blockchain do
  @moduledoc """
  Core blockchain state server
  """
  use GenServer
  alias Ametris.Block

  @server __MODULE__

  # Client

  def start_link(_opts) do
    GenServer.start_link(@server, nil, name: __MODULE__)
  end

  def init(_) do
    {:ok, new()}
  end

  @spec latest_block() :: {:ok, Block.t()}
  def latest_block do
    GenServer.call(@server, :latest_block)
  end

  @spec all_blocks() :: {:ok, list(Block.t())}
  def all_blocks do
    GenServer.call(@server, :all_blocks)
  end

  @spec insert_block(Block.t()) :: :ok | {:error, atom()}
  def insert_block(%Block{} = block) do
    GenServer.call(@server, {:insert_block, block})
  end

  # Server

  def handle_call(:latest_block, _from, chain) do
    {:reply, {:ok, hd(chain)}, chain}
  end

  def handle_call(:all_blocks, _from, chain) do
    {:reply, {:ok, chain}, chain}
  end

  def handle_call({:insert_block, %Block{} = block}, _from, chain) do
    [prev_block | _] = chain

    if Block.valid?(block, prev_block) do
      {:reply, :ok, [block | chain]}
    else
      {:reply, {:error, :invalid_block}, chain}
    end
  end

  # Implementation

  @doc """
  Initialize a new chain with a genesis block
  """
  @spec new() :: [Block.t()]
  def new do
    [Block.genesis()]
  end

  @doc """
  Validate the valid chain
  """
  @spec valid?(list(Block.t())) :: boolean()
  def valid?([%Block{} = block]) do
    Block.valid?(block)
  end

  def valid?([block, prev_block | chain]) do
    Block.valid?(block, prev_block) && valid?([prev_block | chain])
  end
end
