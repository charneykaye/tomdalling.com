module Statue
  class CategoryArchive
    value_semantics do
      category Category
      posts ArrayOf(Post)
    end

    def path
      Pathname("blog") / category.machine_name / 'index.html'
    end

    def uri
      "/#{path.dirname}/"
    end

    def feed_uri
      legacy_post_index.feed_uri
    end

    def size
      posts.size
    end

    def human_name
      category.human_name
    end

    def <=>(other)
      category.human_name <=> other.category.human_name
    end

    def legacy_post_index
      @legacy_post_index ||= post_index.with(
        path: Pathname('blog/category') / category.machine_name / 'index.html',
        feed?: true,
      )
    end

    def post_index
      @post_index ||= PostIndex.new(
        title: "Category: #{human_name}",
        posts: posts,
        path: path,
        feed?: false, # why is this false, and legacy is true?
      )
    end
  end
end
