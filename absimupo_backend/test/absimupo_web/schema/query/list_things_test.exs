defmodule AbsimupoWeb.Schema.Query.ListThingsTest do
  use AbsimupoWeb.ConnCase, async: true
  import Absimupo.CoreFixtures
  import AbsimupoWeb.AbsintheHelpers
  import AbsimupoWeb.Schema.ListThingsQueryFixture

  describe "list_things query" do
    test "returns list of things", %{conn: conn} do
      things =
        1..9
        |> Enum.map(fn _ -> thing_fixture() end)

      response =
        post conn, "/api", %{
          query: list_things_query(),
          variables: list_things_query_variables()
        }

      assert %{
               "data" => %{
                 "listThings" => %{
                   "edges" => [
                     %{"cursor" => _cursor_0, "node" => node_0},
                     %{"cursor" => _cursor_1, "node" => node_1}
                   ],
                   "pageInfo" => %{"hasNextPage" => true, "hasPreviousPage" => false}
                 }
               }
             } = json_response(response, 200)

      thing_0 = Enum.at(things, 0)
      thing_1 = Enum.at(things, 1)
      assert node_0 == %{"id" => to_global_id(:thing, thing_0.id), "name" => thing_0.name}
      assert node_1 == %{"id" => to_global_id(:thing, thing_1.id), "name" => thing_1.name}
    end
  end
end
