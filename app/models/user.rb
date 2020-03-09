class User < ApplicationRecord
  has_secure_password
  # TODO: implement my all design
  acts_as_tree parent_column_name: :manager_id

  belongs_to :manager, class_name: User.name, optional: true
  has_many :employees, foreign_key: :manager_id, class_name: User.name

  validates :username, presence: true, uniqueness: true

  scope :needed_fields, -> { select(:id, :name, :username, :manager_id) }

  after_create  :increment_counter_cache
  after_destroy :decrement_counter_cache

  def self.search(keyword)
    where('username iLIKE ? OR name iLIKE ?', "%#{keyword}%", "%#{keyword}%")
  end

  def ordered_ancestors
    self.class.where(id: self_and_ancestors_ids)
  end

  private

  def decrement_counter_cache
    self.class.decrement_counter('employees_count', manager_id)
  end

  def increment_counter_cache
    self.class.increment_counter('employees_count', manager_id)
  end
end
