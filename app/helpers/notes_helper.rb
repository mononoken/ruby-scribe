require "redcarpet"

module NotesHelper
  def parse_markdown(markdown_input)
    parser = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})

    parser.render(markdown_input)
  end
end
