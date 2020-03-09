module UsersOperations
  class Index
    EMPLOYEE_SEARCH = 0
    MANAGER_SEARCH = 1
    REATIONSHIP_CHECK = 2
    SHOW_WITH_LIMIT = 3
    TYPES = [
      [
        'Find employee of',
        EMPLOYEE_SEARCH
      ],
      [
        'Find manager of',
        EMPLOYEE_SEARCH
      ],
      [
        'Relationship between of',
        EMPLOYEE_SEARCH
      ],
      [
        'Show N first employee',
        EMPLOYEE_SEARCH
      ]
    ].freeze

    def initialize(params, options = {})
      @params = params
      @options = options
      @scope = User
    end

    def records
      @records ||= begin
        records = case params[:type]
                  when EMPLOYEE_SEARCH
                    scope.search(params[:q]).first.self_and_descendants
                  when MANAGER_SEARCH
                    user = scope.search(params[:q]).first
                    scope.where(id: user.self_and_ancestors_ids)
                  when SHOW_WITH_LIMIT
                    scope.limit(params[:q])
                  else
                    scope
                  end

        records.hash_tree
      end
    end

    private

    attr_reader :params, :options, :scope
  end
end
