class Authentication
  include ActiveModel::Model
  attr_accessor :username, :password
  attr_reader :user

  validates :username, :password, presence: true

  def save
    return false unless valid?

    begin
      persist!
      true
    rescue StandardError => e
      errors.add(:base, e.message)
      false
    end
  end

  private

  def persist!
    @user = User.find_or_initialize_by(username: username)

    if @user.persisted?
      raise 'Invalid username or password' unless user.authenticate(password)

      true
    else
      @user.password = password
      @user.password_confirmation = password
      @user.save!
    end
  end
end
