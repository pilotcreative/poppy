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
    content_tag(:ul, :class=>"treeview", :id=>'library') do
      "".html_safe.tap do |result|
        result << display_nodes(node)
      end
    end
  end

  def display_nodes(node)
    "".html_safe.tap do |result|
      node.hasChildren? ? type = "expandable" : type = ""
      result << content_tag(:li, :class => type) do
        "".html_safe.tap do |leaf|
          leaf << content_tag(:div, "", :class=>"hitarea expandable-hitarea") if type == "expandable"
          leaf << node.name
          leaf << link_to("+", add_player_path(:uri => node.content), {:class => "add_to_playlist", :method => :put})
          childrens = node.children
          if node.hasChildren?
            leaf << content_tag(:ul, :style => "display:none;") do
              "".html_safe.tap do |element|
                childrens.each do |child|
                  element << display_nodes(child) unless child.nil?
                end
              end
            end
          end
        end
      end
    end
  end
end