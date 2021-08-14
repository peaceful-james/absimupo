defmodule AbsimupoWeb.Schema.Mutation.CreateThingTest do
  use AbsimupoWeb.ConnCase, async: true
  import AbsimupoWeb.Schema.CreateThingFixture

  describe "createThing mutation" do
    test "creates a thing" do
      response = create_thing()

      assert %{
               "data" => %{
                 "thing" => %{
                   "thing" => %{"edges" => [%{"cursor" => _cursor, "node" => thing_data}]}
                 }
               }
             } = json_response(response, 200)

      assert %{"name" => "Thing Name", "imageUrlLogo" => _image_url_logo} = thing_data
    end

    test "creating a thing with bad data" do
      response = create_thing(%{"name" => ""})

      assert %{"data" => %{"thing" => %{"errors" => errors}}} = json_response(response, 200)

      assert [%{"key" => "name", "message" => "can't be blank"}] = errors
    end
  end
end
