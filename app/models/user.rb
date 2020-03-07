class User < ApplicationRecord
  belongs_to :manager, class_name: 'User'.freeze, optional: true
  has_many :employees, foreign_key: :manager_id, class_name: 'User'.freeze

  after_create  :increment_counter_cache
  after_destroy :decrement_counter_cache

  private

  def decrement_counter_cache
    self.class.decrement_counter("employees_count", manager_id)
  end

  def increment_counter_cache
    self.class.increment_counter("employees_count", manager_id)
  end
end
