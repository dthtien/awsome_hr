class UserPresenter < ApplicationPresenter
  def descendants
    @descendants ||= self_and_descendants.hash_tree
  end

  def ancestors
    @ancestors ||= ordered_ancestors.hash_tree
  end
end
