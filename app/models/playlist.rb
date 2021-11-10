class Playlist < ApplicationRecord
  validates :name, presence: true
  validate :at_least_one_critera_is_filled
  validates :energy, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100, only_integer: true, allow_nil: true }
  validates :danceability, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100, only_integer: true, allow_nil: true }

  def at_least_one_critera_is_filled
    if energy.blank? && danceability.blank? && genre.blank?
      errors.add :base, :invalid, message: "You must define at least one of those criteria to generate your playlist: genre, energy or danceability"
    end
  end
end
