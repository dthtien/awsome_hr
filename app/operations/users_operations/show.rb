module UsersOperations
  class Show
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def self_and_descendants
      @self_and_descendants ||= user.self_and_descendants.hash_tree
    end

    def self_and_ancestors
      @self_and_ancestors ||= User.where(id: user.self_and_ancestors_ids)
                                  .hash_tree
    end
  end
end
