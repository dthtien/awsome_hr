module ApplicationHelper
  def parse_tree_elements(data)
    elements = '<ul>'

    data.each do |record, children|
      elements += <<-HTML.strip
        <li>
          <a href=#{user_path(record)}> #{record.name || record.username} </a>
          #{parse_tree_elements(children) if children.present?}
        </li>
      HTML
    end

    elements += '</ul>'
    elements.html_safe
  end
end
