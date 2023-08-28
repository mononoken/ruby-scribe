require "redcarpet"

module NotesHelper
  def parse_markdown(markdown_input)
    # Redcarpet docs recommend instantiating this object first before use.
    parser = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})

    parser.render(markdown_input)
  end
end
