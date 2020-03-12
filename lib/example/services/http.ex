defmodule Example.Services.Http do
  @moduledoc """
  Web service
  """

  Application.ensure_all_started(:inets)
  Application.ensure_all_started(:ssl)

  @spec fetch() :: {:ok, any, any} | {:error, any}
  def fetch() do
    # Now we can make request:
    case :httpc.request(:get, {'http://www.mocky.io/v2/5e5a23e730000071001f0ade', []}, [], []) do
      {:ok, {{'HTTP/1.1', 200, 'OK'}, headers, body}} -> {:ok, headers, body}
      _ -> {:error, "Request failed"}
    end
  end
end
