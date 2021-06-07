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

  @spec init(algo(), list(integer()), list(integer())) :: t()
  def init(algo, key, nonce), do: %__MODULE__{algo: algo, key: key, nonce: nonce}

  @spec encrypt(t(), list(integer())) :: {:ok, list(integer())} | {:error, atom()}
  def encrypt(%__MODULE__{algo: :chacha20, key: key, nonce: nonce}, data) do
    run_chacha20(data, key, nonce)
  end

  def encrypt(%__MODULE__{algo: :chacha12, key: key, nonce: nonce}, data) do
    run_chacha12(data, key, nonce)
  end

  def encrypt(%__MODULE__{algo: :chacha8, key: key, nonce: nonce}, data) do
    run_chacha8(data, key, nonce)
  end

  def encrypt(_, _), do: {:error, :algo_not_valid}
end
