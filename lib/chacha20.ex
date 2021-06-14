defmodule Chacha20 do
  @moduledoc """
  Contains bindings for chacha20
  """
  use Rustler, otp_app: :chacha20, crate: "chacha20_ex"

  @enforce_keys [:key, :nonce, :algo]
  defstruct [:key, :nonce, algo: :chacha20]

  @type t() :: %__MODULE__{}

  @type algo() :: :chacha20 | :chacha12 | :chacha8

  defp error, do: :erlang.nif_error(:nif_not_loaded)

  defp run_chacha20(_data, _key, _nonce), do: error()
  defp run_chacha12(_data, _key, _nonce), do: error()
  defp run_chacha8(_data, _key, _nonce), do: error()

  @spec init(algo(), list(integer()) | bitstring(), list(integer()) | bitstring()) :: t()
  def init(algo, key, nonce), do: %__MODULE__{algo: algo, key: key, nonce: nonce}

  @spec encrypt(t(), list(integer()) | bitstring()) :: {:ok, bitstring()} | {:error, atom()}
  def encrypt(%__MODULE__{algo: :chacha20, key: key, nonce: nonce}, data) do
    convert_and_run({data, key, nonce}, &run_chacha20/3)
  end

  def encrypt(%__MODULE__{algo: :chacha12, key: key, nonce: nonce}, data) do
    convert_and_run({data, key, nonce}, &run_chacha12/3)
  end

  def encrypt(%__MODULE__{algo: :chacha8, key: key, nonce: nonce}, data) do
    convert_and_run({data, key, nonce}, &run_chacha8/3)
  end

  def encrypt(_, _), do: {:error, :algo_not_valid}

  defp convert_and_run({data, key, nonce}, fun) do
    args =
      [data, key, nonce]
      |> Enum.map(&convert_to_charlist/1)

    case apply(fun, args) do
      {:ok, result} -> {:ok, convert_to_string(result)}
      {:error, _} = err -> err
    end
  end

  defp convert_to_charlist(t) when is_list(t), do: t
  defp convert_to_charlist(t) when is_bitstring(t), do: :binary.bin_to_list(t)

  defp convert_to_string(t) when is_list(t), do: to_string(t)
  defp convert_to_string(t) when is_binary(t), do: t
end
