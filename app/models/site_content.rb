class SiteContent < ActiveRecord::Base
  
  acts_as_tree :order => "name" 

  validates :name, :presence => true, :uniqueness => true

  def self.get_content(name,child = "")
    c = find_by_name(name)
    if c && child != ""
      c = c.children.find_by_name(child)
    end
    return c.blank? ? "" : c.content
  end
  
end
