defmodule AbsimupoWeb.Schema.ImageUrlTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  @desc "Parameters for querying image URLs"
  input_object :image_url_params do
    @desc """
    The desired width
    """
    field(:width, :integer)

    @desc """
    The desired height
    """
    field(:height, :integer)

    @desc """
    imgproxy supports the following resizing types:
    fit: resizes the image while keeping aspect ratio to fit given size;
    fill: resizes the image while keeping aspect ratio to fill given size and cropping projecting parts;
    auto: if both source and resulting dimensions have the same orientation (portrait or landscape), imgproxy will use fill. Otherwise, it will use fit.
    """
    field(:resize, :resize_option)

    @desc """
    When imgproxy needs to cut some parts of the image, it is guided by the gravity.
    """
    field(:gravity, :gravity_option)

    @desc "Tells imgproxy to enlarge the image if it is smaller than the given size. Default: true"
    field(:enlarge, :boolean)

    @desc """
    Extension specifies the format of the resulting image.
    If not provided, imgproxy attempts to preserve the original image type.
    """
    field(:extension, :string)
  end

  @desc """
  imgproxy supports the following resizing types:
  fit: resizes the image while keeping aspect ratio to fit given size;
  fill: resizes the image while keeping aspect ratio to fill given size and cropping projecting parts;
  auto: if both source and resulting dimensions have the same orientation (portrait or landscape), imgproxy will use fill. Otherwise, it will use fit.
  """
  enum :resize_option do
    value(:fit)
    value(:fill)
    value(:auto)
  end

  @desc """
  When imgproxy needs to cut some parts of the image, it is guided by the gravity. The following values are supported:

  no: north (top edge);
  so: south (bottom edge);
  ea: east (right edge);
  we: west (left edge);
  noea: north-east (top-right corner);
  nowe: north-west (top-left corner);
  soea: south-east (bottom-right corner);
  sowe: south-west (bottom-left corner);
  ce: center;
  sm: smart. libvips detects the most "interesting" section of the image and considers it as the center of the resulting image;

  Not implemented (TODO):
  fp:%x:%y - focus point. x and y are floating point numbers between 0 and 1 that describe the coordinates of the center of the resulting image. Treat 0 and 1 as right/left for x and top/bottom for y.
  """
  enum :gravity_option do
    value(:no)
    value(:so)
    value(:ea)
    value(:we)
    value(:noea)
    value(:nowe)
    value(:soea)
    value(:sowe)
    value(:ce)
    value(:sm)
  end
end
