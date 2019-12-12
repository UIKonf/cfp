module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'UIKonf CfP'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def markdown(text)
    markdown_renderer.render(text).html_safe
  end

  private

  def markdown_renderer
    @markdown_rendered ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, safe_links_only: true, escape_html: true, prettify: true)
  end
end
