# frozen_string_literal: true

module Fineract
  # Self-service-adjacent APIs exposed by the 1.15.0 provider specification.
  class SelfService < Resource
    def profile = call(:fetch_authenticated_user_data)
    def notifications(**query) = call(:get_all_notifications, query: mapped_keys(query))

    def mark_notification_read(**attributes)
      call(:update_notification_read_status, body: mapped_keys(attributes), idempotent: false)
    end
  end
end
