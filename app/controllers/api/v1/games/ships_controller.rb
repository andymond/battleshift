class Api::V1::Games::ShipsController < ApiController

  def create
    binding.pry
    parsed = JSON.parse(params[:ship], symbolize_names: true)
    ship = Ship.new(parsed)
  end

end
