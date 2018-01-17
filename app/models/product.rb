class Product < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validate :title_is_shorter_than_description
  before_save :strip_html_from_description
  before_save :lower_case

  def strip_html_from_description
    self.description = ActionView::Base.full_sanitizer.sanitize(self.description)
  end

  def lower_case
    self.title = title.downcase
  end

  def title_is_shorter_than_description
    return if title.blank? or description.blank?
    if description.length < title.length
      errors.add(:title, 'Title must be shorter than description')
    end
  end
end