module ApplicationHelper
  def nav_links
    style_button = 'text-white font-weight-bold text-decoration-none'
    if current_user
      content_tag(:div, link_to('Create Event', new_event_path, class: 'text-decoration-none'),
                  class: 'btn btn-light mr-2') +
        content_tag(:div,
                    link_to(current_user.name, current_user, class: style_button.to_s), class: 'text-white mr-2') +
        content_tag(:div,
                    link_to('Sign Out', sign_out_path, class: style_button.to_s), class: 'ml-2')
    else
      content_tag(:div, link_to('Sign In', sign_in_path, class: 'text-white'), class: '') +
        content_tag(:div, link_to('Sign Up', sign_up_path), class: 'btn btn-light ml-2')
    end
  end
end
