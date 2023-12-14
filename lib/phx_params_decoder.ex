defmodule PhxParamsDecoder do
  @moduledoc """
  Documentation for `PhxParamsDecoder`.
  """

  @doc """
  Decode params from stringified integer to integer.

  ## Examples

      iex> PhxParamsDecoder.decode(%{"page" => "1"})
      %{page: 1}

  """
  @spec decode(map) :: map
  def decode(params) do
    params
    |> Enum.map(fn {key, value} ->
      {String.to_existing_atom(key), decode_value(value)}
    end)
    |> Map.new()
  end

  #TODO add float support
  #TODO add boolean support
  #TODO add date support
  #TODO add datetime support
  #TODO add time support
  #TODO add list support
  #TODO add map support
  #TODO add struct support
  #TODO add tuple support
  #TODO add nested map support
  #
  def decode_value(values) when is_list(values) do
    Enum.map(values, &decode_value/1)
  end

  def decode_value(value) when is_integer(value), do: value
  def decode_value(value) when is_float(value), do: value

  def decode_value(value) when is_binary(value) do
    case Integer.parse(value) do
      {int, ""} -> int
      _ -> value
    end
  end
end
