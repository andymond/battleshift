class User < ApplicationRecord
  has_secure_password
  validates_presence_of :password, :email, :name
  validates_confirmation_of :password, message: "Passwords must match like butter and astroturf"
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/
  enum status: [:inactive, :active]
  has_many :colosseums
  has_many :games, through: :colosseums

  def player_number(game_id)
    colosseum = colosseums.find_by(game_id: game_id)
    colosseum.gladiator_number unless colosseum.nil?
  end
end
