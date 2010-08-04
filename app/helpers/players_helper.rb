module PlayersHelper
  def song_info(song)
    return "" if song.nil?
    if song.try(:title).blank? || song.try(:artist).blank?
      song.file
    else
      song.artist + ' - ' + song.title
    end 
  end

  def display_childrens(node)
    content_tag(:ul) do
      "".html_safe.tap do |result|
        result << display_nodes(node)
      end
    end
  end

  def display_nodes(node)
    "".html_safe.tap do |result|
      result << content_tag(:li) do
        "".html_safe.tap do |leaf|
          leaf << content_tag(:a,node.name)
          childrens = node.children
          leaf << content_tag(:ul) do
            "".html_safe.tap do |element|
              childrens.each do |child|
                element << display_nodes(child)
              end
            end
          end
        end
      end
    end
  end

end