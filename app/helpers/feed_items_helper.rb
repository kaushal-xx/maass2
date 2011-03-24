module FeedItemsHelper

  def x_feed_link feed_item
    link_to image_tag('delete.png', :class => 'delete'),profile_feed_item_path(@profile, feed_item), :remote=>true, :method => :delete
  end

  def commentable_text comment, in_html = true
    parent = comment.commentable
    case parent.class.name
    when 'Profile'
      "<strong>#{link_to_if in_html, comment.profile.full_name, comment.profile} wrote a comment on #{link_to_if in_html, parent.full_name+'\'s', profile_path(parent)} wall </strong>"
    when 'Blog'
      "<strong>#{link_to_if in_html, comment.profile.full_name, comment.profile} commented on #{link_to_if in_html, h(parent.title), profile_blog_path(parent.profile, parent)} </strong>"
    when 'Event'
      "<strong>#{link_to_if in_html, comment.profile.full_name, comment.profile}</strong>"
    end
  end
  #safe_helper :commentable_text, :x_feed_link

end