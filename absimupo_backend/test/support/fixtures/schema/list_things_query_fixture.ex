defmodule AbsimupoWeb.Schema.ListThingsQueryFixture do
  def list_things_query() do
    """
    query listThingsQuery($first: Int!, $after: String) {
      listThings(first: $first, after: $after) {
        pageInfo {
          hasNextPage
          hasPreviousPage
        }
        edges {
          cursor
          node {
            id
            name
          }
        }
      }
    }
    """
  end

  def list_things_query_variables(attrs \\ %{}) do
    attrs
    |> Enum.into(%{"first" => 2, "after" => nil})
  end
end
