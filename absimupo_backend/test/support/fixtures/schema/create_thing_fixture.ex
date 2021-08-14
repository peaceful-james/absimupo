defmodule AbsimupoWeb.Schema.CreateThingFixture do
  @moduledoc false
  import Phoenix.ConnTest

  @endpoint AbsimupoWeb.Endpoint

  @logo_file %Plug.Upload{
    path: "./test/support/images/img1.png",
    content_type: "multipart/form-data",
    filename: "img1.png"
  }

  def create_thing_mutation() do
    """
    mutation createThingMutation($input: CreateThingInput!) {
      thing: createThing(input: $input) {
        errors {
          key
          message
          statusCode
        }
        thing {
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
    }
    """
  end

  def create_thing_input(attrs \\ %{}) do
    %{"input" => attrs |> Enum.into(%{"name" => "Thing Name", "logo" => "logo-file"})}
  end

  def create_thing(attrs \\ %{}) do
    post build_conn(), "/api", %{
      query: create_thing_mutation(),
      variables: create_thing_input(attrs),
      "logo-file": @logo_file
    }
  end
end
