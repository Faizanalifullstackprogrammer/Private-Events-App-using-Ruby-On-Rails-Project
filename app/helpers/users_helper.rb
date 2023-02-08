module UsersHelper
  def invitation(user)
    if invited?(user, @event.id) && attended?(user, @event.id)
      content_tag(:p, 'Invitation accepted', class: 'font-weight-bold text-success py-1 px-4')
    elsif invited?(user, @event.id) && attended?(user, @event.id) != true
      content_tag(:div,
                  link_to('Cancel invitation', cancel_path(user_id: user.id, event_id: @event.id),
                          class: 'py-1 px-4 text-center rounded nav-link border border-danger text-danger'))
    else
      content_tag(:div,
                  link_to('Invite', invite_path(user_id: user.id, event_id: @event.id),
                          class: 'btn btn-primary text-center rounded nav-link py-1 px-4'))
    end
  end
end
