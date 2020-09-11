module Statue
  class PostIndexOutput
    attr_reader :post_index, :template

    def initialize(post_index, template:)
      @post_index = post_index
      @template = template
    end

    def description
      'Post Index'
    end

    def write_to(output_path)
      output_path.write(
        template.html(post_index)
      )
    end
  end
end