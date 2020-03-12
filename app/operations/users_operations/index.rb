module UsersOperations
  class Index
    EMPLOYEE_SEARCH = '0'.freeze
    MANAGER_SEARCH = '1'.freeze
    REATIONSHIP_CHECK = '2'.freeze
    SHOW_WITH_LIMIT = '3'.freeze
    MANAGER = 'manager'.freeze
    SUBORDINATE = 'subordinate'.freeze
    NON_RELATIVE = 'non-relative'.freeze
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
        scope.find_by(id: params[:user]).self_and_descendants
      when MANAGER_SEARCH
        user.ordered_ancestors
      when SHOW_WITH_LIMIT
        scope.page(params[:page]).per(params[:per_page])
      when REATIONSHIP_CHECK
        with_relationship
      else
        scope.per
      end
    end

    def with_relationship
      return MANAGER if user1.ancestor_of?(user2)
      return SUBORDINATE if user1.descendant_of?(user2)

      NON_RELATIVE
    end
  end
end
