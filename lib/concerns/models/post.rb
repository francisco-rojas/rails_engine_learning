module Blorgh::Concerns::Models::Post
  extend ActiveSupport::Concern

  # 'included do' causes the included code to be evaluated in the
  # context where it is included (post.rb), rather than being
  # executed in the module's context (blorgh/concerns/models/post).
  included do
    attr_accessor :author_name
    belongs_to :author, class_name: Blorgh.author_class

    before_save :set_author

    private
      def set_author
        self.author = Blorgh.author_class.find_or_create_by(name: author_name)
      end
  end

  def summary
    "#{title}"
  end

  module ClassMethods
    def some_class_method
      'some class method string'
    end
  end
end