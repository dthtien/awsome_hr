class UserPresenter < ApplicationPresenter
  def childs
    employees.includes(:employees).map do |employee|
      UserPresenter.new employee
    end
  end
end