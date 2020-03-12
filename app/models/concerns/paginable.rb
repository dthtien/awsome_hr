module Paginable
  extend ActiveSupport::Concern
  DEFAULT_PAGE = 0
  DEFAULT_PER_PAGE = 25
  included do
    cattr_accessor :per_page
    self.per_page = DEFAULT_PER_PAGE

    class << self
      def page(pap = DEFAULT_PAGE)
        offset((pap || DEFAULT_PAGE).to_i * per_page + 1).limit(per_page)
      end

      def per(num = DEFAULT_PER_PAGE)
        limit(num)
      end
    end
  end
end
