module ApplicationHelper
  def parse_tree_elements(data)
    elements = '<ul>'

    data.each do |record|
      elements += <<-HTML.strip
        <li>
          <a> #{record.name} </a>
          #{parse_tree_elements(record.childs) if record.childs.present?}
        </li>
      HTML
    end

    elements += '</ul>'
  end
end
