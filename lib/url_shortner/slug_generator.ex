defmodule UrlShortner.SlugGenerator do
  @moduledoc """
  This module is resposible to generate a random string (slug)
  """
  @chars "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
         |> String.split("", trim: true)

  @default_length 6

  @doc """
  This fn generates a random string based on the length (or the default) and the chars defined on @chars
  """
  def generate(), do: generate(@default_length)
  def generate(0), do: generate(@default_length)

  def generate(length) do
    Enum.reduce(1..length, [], fn _i, acc ->
      [Enum.random(@chars) | acc]
    end)
    |> Enum.join("")
  end
end
