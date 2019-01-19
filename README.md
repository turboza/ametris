# Ametris

A simple Blockchain implementation in Elixir for the purpose of learning

## Usage

```iex
iex> Ametris.Blockchain.start_link(%{})
iex> {:ok, latest} = Ametris.Blockchain.latest_block
{:ok,
 %Ametris.Block{
   data: "Hello Ametris",
   hash: "30C1C049C45D2824A9689E0051E45566C42BE7A5766F141894C89E452C3D9567",
   index: 0,
   prev_hash: "GENESIS",
   timestamp: #DateTime<2019-01-19 13:10:24.953931Z>
 }}


iex> block = Ametris.Block.new("New data", latest)
iex> Ametris.Blockchain.insert_block(block)
:ok
```

## Resource

Thank you to these great resources for guiding in development of this project

- https://sheharyar.me/blog/writing-blockchain-elixir/
- https://github.com/robinmonjo/coincoin
- https://medium.com/@lhartikk/a-blockchain-in-200-lines-of-code-963cc1cc0e54
