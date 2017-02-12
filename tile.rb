class Tile
  attr_accessor :value, :combined
  def initialize(params = {})
    @value = params.fetch(:value, 0)
    @combined = params.fetch(:combined, false)
  end
end
