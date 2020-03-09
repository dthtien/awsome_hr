module UsersOperations
  class Index
    EMPLOYEE_SEARCH = '0'.freeze
    MANAGER_SEARCH = '1'.freeze
    REATIONSHIP_CHECK = '2'.freeze
    SHOW_WITH_LIMIT = '3'.freeze

    TYPES = [
      [
        'Find employee of',
        EMPLOYEE_SEARCH
      ],
      [
        'Find manager of',
        MANAGER_SEARCH
      ],
      [
        'Relationship between of',
        REATIONSHIP_CHECK
      ],
      [
        'Show N first employee',
        SHOW_WITH_LIMIT
      ]
    ].freeze

    def initialize(params, options = {})
      @params = params
      @options = options
      @scope = User
    end

    def records
      @records ||= parse_records
    end

    def user1
      @user1 ||= scope.find(params[:user1])
    end

    def user2
      @user2 ||= scope.find(params[:user2])
    end

    def user
      @user ||= scope.find_by(id: params[:user])
    end

    private

    attr_reader :params, :options, :scope

    def parse_records
      case params[:type]
      when EMPLOYEE_SEARCH
        scope.find_by(id: params[:user]).self_and_descendants.hash_tree
      when MANAGER_SEARCH
        user.ordered_ancestors
      when SHOW_WITH_LIMIT
        scope.limit(params[:q].presence).hash_tree
      when REATIONSHIP_CHECK
        with_relationship
      else
        scope.hash_tree
      end
    end

    def with_relationship
      return 'manager' if user1.ancestor_of?(user2)
      return 'subordinate' if user1.descendant_of?(user2)

      'non-relative'
    end
  end
end
