module Jekyll
  class ImageFit < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
       return "<img src=\"#{@text}\" class=\"image fit\">"
    end
  end
end

Liquid::Template.register_tag('ifit', Jekyll::ImageFit)