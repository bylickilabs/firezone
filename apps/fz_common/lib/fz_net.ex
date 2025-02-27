defmodule FzCommon.FzNet do
  @moduledoc """
  Network utility functions.
  """
  # credo:disable-for-next-line Credo.Check.Readability.MaxLineLength
  @ip_regex ~r/((^\s*((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))\s*$)|(^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$))/

  @cidr4_regex ~r/^([0-9]{1,3}\.){3}[0-9]{1,3}(\/([0-9]|[1-2][0-9]|3[0-2]))$/

  # credo:disable-for-next-line Credo.Check.Readability.MaxLineLength
  @cidr6_regex ~r/^s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:)))(%.+)?s*(\/([0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-8]))$/

  # credo:disable-for-next-line Credo.Check.Readability.MaxLineLength
  @host_regex ~r/\A(([a-zA-Z0-9](?:[a-zA-Z0-9\-]*[a-zA-Z0-9])?)\.)*([a-zA-Z0-9](?:[a-zA-Z0-9\-]*[a-zA-Z0-9])?)$\Z/
  @fqdn_regex ~r/\A(?=^.{4,253}$)(^((?!-)[a-zA-Z0-9-]{0,62}[a-zA-Z0-9]\.)+[a-zA-Z]{2,63}$)\z/

  # XXX: Consider using InetCidr for this
  def ip_type(str) when is_binary(str) do
    charlist =
      str
      # remove CIDR range if exists
      |> String.split("/")
      |> List.first()
      |> String.to_charlist()

    case :inet.parse_ipv4_address(charlist) do
      {:ok, _} ->
        "IPv4"

      {:error, _} ->
        case :inet.parse_ipv6_address(charlist) do
          {:ok, _} -> "IPv6"
          {:error, _} -> "unknown"
        end
    end
  end

  def valid_cidr?(cidr) when is_binary(cidr) do
    String.match?(cidr, @cidr4_regex) or String.match?(cidr, @cidr6_regex)
  end

  def valid_ip?(ip) when is_binary(ip) do
    String.match?(ip, @ip_regex)
  end

  @doc """
  Standardize IP addresses and CIDR ranges so that they can be condensed / shortened.
  """
  def standardized_inet(inet) when is_binary(inet) do
    if String.contains?(inet, "/") do
      inet
      # normalize CIDR
      |> InetCidr.parse(true)
      |> InetCidr.to_string()
    else
      {:ok, addr} = inet |> String.to_charlist() |> :inet.parse_address()
      :inet.ntoa(addr) |> List.to_string()
    end
  end

  def valid_fqdn?(fqdn) when is_binary(fqdn) do
    String.match?(fqdn, @fqdn_regex)
  end

  def valid_hostname?(hostname) when is_binary(hostname) do
    String.match?(hostname, @host_regex)
  end

  def to_complete_url(str) when is_binary(str) do
    case URI.new(str) do
      {:ok, %{host: nil, scheme: nil}} ->
        {:ok, "https://" <> str}

      {:ok, _} ->
        {:ok, str}

      err ->
        err
    end
  end

  def endpoint_to_ip(endpoint) do
    endpoint
    |> String.replace(~r{:\d+$}, "")
    |> String.trim_leading("[")
    |> String.trim_trailing("]")
  end
end
