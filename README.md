# Chacha20

Exposes [chacha20](https://docs.rs/crate/chacha20/0.7.1) using [rustler](https://github.com/rusterlium/rustler).

## Installation

This package is not yet available on Hex. It will be available when the bindings are complete.

## Usage

This is how to use this library currently:

```
iex(1)> key = Enum.into 1..32, []
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]
iex(2)> nonce = Enum.into 1..12, []
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
iex(3)> config = Chacha20.init :chacha20, key, nonce
%Chacha20{
  algo: :chacha20,
  key: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
   21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32],
  nonce: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
}
iex(4)> Chacha20.encrypt config, [1, 2, 3]
{:ok, [3, 11, 192]}
iex(5)> Chacha20.encrypt config, [3, 11, 192]
{:ok, [1, 2, 3]}
iex(6)>
```

Currently `:chacha20`, `:chacha12`, and `:chacha8` are available. More will be coming soon.
