class Playlist < ApplicationRecord
  validates :name, presence: true
  validate :has_content
  validates :energy, :danceability, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

  def has_content
    if energy.blank? && danceability.blank? && genre.blank?
      errors.add :base, :invalid, message: "You must define at least one criteria to generate your playlist"
    end
  end
end
