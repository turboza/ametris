# Ametris

A simple Blockchain implementation in Elixir with the purpose of learning

## Usage

```iex
iex> blockchain = Blockchain.new
[
  %Ametris.Block{
    data: "Hello Ametris",
    hash: "80EA2049016390113861B8A599267B732431B42F67A09802B2ABFFDFE668F551",
    prev_hash: "GENESIS",
    timestamp: #DateTime<2019-01-19 09:47:08.805888Z>
  }
]

iex> Blockchain.insert(blockchain, "My data")
[
  %Ametris.Block{
    data: "My data",
    hash: "3A7BF7E7162B267A5F82CCF58FC7F252AE180C224147A6C1579FBED9FF79991E",
    prev_hash: "011D5C038718374A6828849C6596AF617E9235BDA7F9E2C712D6079A72622EBD",
    timestamp: #DateTime<2019-01-19 09:57:03.520172Z>
  },
  %Ametris.Block{
    data: "Hello Ametris",
    hash: "011D5C038718374A6828849C6596AF617E9235BDA7F9E2C712D6079A72622EBD",
    prev_hash: "GENESIS",
    timestamp: #DateTime<2019-01-19 09:56:59.517497Z>
  }
]
```

## Resource

Thank you to these great resources for guiding in development of this project

- https://sheharyar.me/blog/writing-blockchain-elixir/
- https://github.com/robinmonjo/coincoin
- https://medium.com/@lhartikk/a-blockchain-in-200-lines-of-code-963cc1cc0e54
