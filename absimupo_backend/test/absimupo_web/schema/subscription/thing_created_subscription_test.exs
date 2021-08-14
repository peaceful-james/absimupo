defmodule AbsimupoWeb.Schema.Subscription.ThingCreatedTest do
  use AbsimupoWeb.SubscriptionCase, async: true
  import AbsimupoWeb.Schema.CreateThingFixture

  @subscription """
  subscription {
    thingCreated {
      edges {
        cursor
        node {
          id
          name
          imageUrlLogo
        }
      }
    }
  }
  """

  test "new things can be subscribed to", %{socket: socket} do
    ref = push_doc(socket, @subscription)
    assert_reply ref, :ok, %{subscriptionId: subscription_id}

    assert create_thing()
           |> Map.get(:resp_body)
           |> Jason.decode!()
           |> get_in(["data", "createdThing", "errors"])
           |> is_nil()

    assert_push "subscription:data", push
    assert push.subscriptionId == subscription_id

    assert %{
             result: %{
               data: %{
                 "thingCreated" => %{
                   "edges" => [
                     %{
                       "cursor" => _cursor,
                       "node" => %{
                         "name" => "Thing Name",
                         "id" => id,
                         "imageUrlLogo" => image_url_logo
                       }
                     }
                   ]
                 }
               }
             }
           } = push

    assert id
    assert String.starts_with?(image_url_logo, "http")
  end
end
