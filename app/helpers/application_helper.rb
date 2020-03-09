module ApplicationHelper
  def parse_tree_elements(data)
    elements = '<ul>'

    data.each do |record, childs|
      elements += <<-HTML.strip
        <li>
          <a> #{record.name} </a>
          #{parse_tree_elements(childs) if childs.present?}
        </li>
      HTML
    end

    elements += '</ul>'
    elements.html_safe
  end
end
