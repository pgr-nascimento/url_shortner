defmodule UrlShortner.Urls.Handler do
  alias UrlShortner.Urls.Create, as: UrlCreator

  @retriable_errors [:slug]
  @default_retries 3

  def create(params, retries \\ @default_retries) do
    result = UrlCreator.call(params)

    case handle_result(result, retries) do
      {:ok, url} ->
        {:ok, url}

      {:error, changeset} ->
        {:error, changeset}

      {:retry, _changeset} ->
        create(params, retries - 1)
    end
  end

  defp handle_result({:ok, url}, _retries), do: {:ok, url}
  defp handle_result({:error, changeset}, 0), do: {:error, changeset}

  defp handle_result({:error, %{errors: errors} = changeset}, _retries) do
    if Enum.any?(errors, &retriable_error?/1) do
      {:retry, changeset}
    else
      {:error, changeset}
    end
  end

  defp retriable_error?({key, _description}) do
    Enum.member?(@retriable_errors, key)
  end
end
