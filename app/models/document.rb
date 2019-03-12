class Document < ApplicationRecord
  has_one_attached :file
  validates :name, presence: true
  validate :validate_file_attached

  def validate_file_attached
    unless self.file.attached?
      self.errors.add :base, 'Please choose file'
    end
  end
end
