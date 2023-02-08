# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Style/SafeNavigation

module EventsHelper
  def invitation_people
    accept = 'You have been invited. Accept Invitation'
    if current_user && current_user.events.exists?(@event.id)
      content_tag(:div,
                  link_to('Invite people', inviteUsers_path(@event), class: 'btn btn-primary p-2 text-center rounded'))
    elsif current_user && invited?(current_user, @event.id) && attended?(current_user, @event.id)
      content_tag(:div,
                  link_to('Withdraw', withdraw_path(user_id: current_user.id, event_id: @event.id),
                          class: 'btn btn-primary p-2 text-center rounded'))
    elsif current_user && invited?(current_user, @event.id) && attended?(current_user, @event.id) != true
      content_tag(:div,
                  link_to(accept.to_s, attend_path(user_id: current_user.id, event_id: @event.id),
                          class: 'btn btn-primary p-2 text-center rounded'))
    else
      content_tag(:p, 'You must be invited to attend this Event', class: 'text-danger')
    end
  end
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Style/SafeNavigation
