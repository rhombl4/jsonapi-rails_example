class Stock < ApplicationRecord
  acts_as_paranoid

  belongs_to :bearer

  validates :name, presence: true
  validate :unscoped_uniqueness_of_name

  # Hotfix: This resolves collision of database index and soft-deleted items
  # It should be better solution for this
  def unscoped_uniqueness_of_name
    return unless self.class.unscoped.find_by(name: self.name)

    errors.add :name, details: 'Already exists'
  end
end
