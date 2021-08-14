defmodule AbsimupoWeb.SubscriptionCase do
  @moduledoc """
  This module defines the test case to be used by
  subscription tests
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      use AbsimupoWeb.ChannelCase
      use Absinthe.Phoenix.SubscriptionTest, schema: AbsimupoWeb.Schema
      alias Absinthe.Phoenix.SubscriptionTest

      defp create_socket do
        {:ok, socket} = Phoenix.ChannelTest.connect(AbsimupoWeb.UserSocket, %{})
        {:ok, socket} = SubscriptionTest.join_absinthe(socket)
        socket
      end

      setup do
        {:ok, socket: create_socket()}
      end
    end
  end
end
