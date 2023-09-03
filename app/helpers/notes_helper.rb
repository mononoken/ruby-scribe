require "redcarpet"

module NotesHelper
  def markdown(input)
    # Redcarpet docs recommend instantiating this object first before use.
    options = [:hard_wrap, :autolink, :no_intra_emphasis, :fenced_code_blocks]
    renderer = Redcarpet::Render::HTML.new(
      filter_html: true, hard_wrap: true
    )
    parser = Redcarpet::Markdown.new(renderer,
      autolink: true, no_intra_emphasis: true)

    parser.render(input).html_safe
  end
end
