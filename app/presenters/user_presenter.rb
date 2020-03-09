class UserPresenter < ApplicationPresenter
  def descendants
    @descendants ||= self_and_descendants.hash_tree
  end

  def ancestors
    @ancestors ||= User.where(id: self_and_ancestors_ids).hash_tree
  end

  def children
    employees.includes(:employees).map do |employee|
      UserPresenter.new employee
    end
  end
end
