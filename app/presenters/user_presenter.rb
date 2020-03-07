class UserPresenter < ApplicationPresenter
  def childs
    employees.map do |employee|
      UserPresenter.new employee
    end
  end
end