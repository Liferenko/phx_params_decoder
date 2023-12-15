defmodule PhxParamsDecoder do
  @moduledoc """
  Documentation for `PhxParamsDecoder`.
  """

  @doc """
  Decode params from stringified integer to integer.

  ## Examples

      iex> PhxParamsDecoder.decode(%{"page" => "1"})
      %{page: 1}

      iex> PhxParamsDecoder.decode(%{"pages" => ["1", "99", "122"]})
      %{pages: [1, 99, 122]}

      iex> PhxParamsDecoder.decode(%{"string" => ["Totally", "valid", "string"]})
      %{string: ["Totally", "valid", "string"]}

      iex> PhxParamsDecoder.decode(%{"string" => ["Totally", "valid", "string"]})
      %{string: ["Totally", "valid", "string"]}

  """
  @spec decode(map) :: map
  def decode(params) do
    params
    |> Enum.map(fn {key, value} ->
      {String.to_existing_atom(key), decode_value(value)}
    end)
    |> Map.new()
  end

  #TODO
  #- [ ] add boolean support
  #- [ ] add date support
  #- [ ] add datetime support
  #- [ ] add time support
  #- [ ] add list support
  #- [ ] add map support
  #- [ ] add struct support
  #- [ ] add tuple support
  #- [ ] add nested map support
  #- [ ] add nested list support
  def decode_value(values) when is_list(values) do
    Enum.map(values, &decode_value/1)
  end

  def decode_value(value) when is_integer(value), do: value
  def decode_value(value) when is_float(value), do: value

  def decode_value(value) when is_binary(value) do
    case Integer.parse(value) do
      {int, ""} -> int
      {int, dot} -> case Float.parse(value) do # OPTIMIZE looks ugly with case within the case. 
        {float, ""} -> float
        _ -> value
      end
      _ -> value
    end
  end
end
