defmodule Ametris.BlockchainTest do
  use ExUnit.Case

  alias Ametris.{Blockchain, Block}

  setup do
    Blockchain.start_link(%{})
    :ok
  end

  describe "latest_block/0" do
    test "return latest block" do
      {:ok, %Block{} = block} = Blockchain.latest_block()
      assert block.index == 0
      assert block.prev_hash == "GENESIS"
    end
  end

  describe "all_blocks/0" do
    test "return all blocks" do
      {:ok, [%Block{} = block]} = Blockchain.all_blocks()
      assert block.index == 0
    end
  end

  describe "insert_block/1" do
    test "insert a new block" do
      block = new_block("turbo")

      assert :ok == Blockchain.insert_block(block)
      assert {:ok, %Block{data: "turbo"}} = Blockchain.latest_block()
    end
  end

  defp new_block(data) do
    {:ok, %Block{} = latest_block} = Blockchain.latest_block()
    Block.new(data, latest_block)
  end
end
