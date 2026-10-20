# frozen_string_literal: true

# rubocop:disable all

module Fineract
  class SecurityAdministration < Resource
    class Users < Resource
      def list(**query) = call(:retrieve_all_users, query: wire_keys(query))
      def retrieve(user_id) = safe_call { call(:retrieve_one_user, path: { userId: id!(user_id, "user_id") }) }
      def create(**attributes) = call(:create_user, body: wire_keys(attributes))
      def update(user_id, **attributes) = safe_call { call(:update_user, path: { userId: id!(user_id, "user_id") }, body: wire_keys(attributes)) }
      def delete(user_id) = safe_call { call(:delete_user, path: { userId: id!(user_id, "user_id") }) }
      def change_password(user_id, password:, repeat_password:)
        safe_call do
          raise ValidationError, "passwords must match" unless password == repeat_password
          call(:change_password_user, path: { userId: id!(user_id, "user_id") }, body: { "password" => password, "repeatPassword" => repeat_password })
        end
      end
      def template = call(:retrieve_template_user)
      def download_template(**query) = call(:get_bulk_template_user, query: wire_keys(query))
      def upload_template(uploaded_input_stream:, locale: nil, date_format: nil)
        body = { "uploadedInputStream" => uploaded_input_stream }
        body["locale"] = locale unless locale.nil?
        body["dateFormat"] = date_format unless date_format.nil?
        call(:post_bulk_template_user, body: body, request_type: "multipart/form-data")
      end
    end
    class Roles < Resource
      def list(**query) = call(:retrieve_all_roles, query: wire_keys(query))
      def create(name:, description: nil) = call(:create_role, body: { "name" => name, "description" => description }.compact)
      def retrieve(role_id) = safe_call { call(:retrieve_one_role, path: { roleId: id!(role_id, "role_id") }) }
      def update(role_id, description:) = safe_call { call(:update_role, path: { roleId: id!(role_id, "role_id") }, body: { "description" => description }) }
      def delete(role_id) = safe_call { call(:delete_role, path: { roleId: id!(role_id, "role_id") }) }
      def command(role_id, command:) = safe_call { call(:handle_commands_role, path: { roleId: id!(role_id, "role_id") }, query: { "command" => command }, idempotent: false) }
      def permissions(role_id) = safe_call { call(:retrieve_role_permissions, path: { roleId: id!(role_id, "role_id") }) }
      def update_permissions(role_id, permissions:) = safe_call { call(:update_role_permissions, path: { roleId: id!(role_id, "role_id") }, body: { "permissions" => permissions }) }
    end
    class Permissions < Resource
      def list = call(:retrieve_all_permissions)
      def update(permissions:) = call(:update_permissions, body: { "permissions" => permissions })
    end
    class PasswordPreferences < Resource
      def list = call(:retrieve_all_password_preferences)
      def template = call(:retrieve_template_password_preferences)
      def update(validation_policy_id:) = call(:update_password_preferences, body: { "validationPolicyId" => validation_policy_id })
      def forgot(email:) = call(:forgot_password, body: { "email" => email })
    end
    class TwoFactor < Resource
      def delivery_methods = call(:get_otp_delivery_methods)
      def request_token(delivery_method: nil, extended_token: nil) = call(:request_token, query: { "deliveryMethod" => delivery_method, "extendedToken" => extended_token }.compact)
      def configuration = call(:retrieve_all_4)
      def configure(value) = call(:update_configuration_1, body: value, request_type: :json)
      def invalidate(value) = call(:update_configuration, body: value, request_type: :json)
      def validate(token:) = call(:validate, query: { "token" => token })
    end
    def initialize(client)
      super
      @users, @roles, @permissions = Users.new(client), Roles.new(client), Permissions.new(client)
      @password_preferences, @two_factor = PasswordPreferences.new(client), TwoFactor.new(client)
    end
    attr_reader :users, :roles, :permissions, :password_preferences, :two_factor
    def authenticated_user = call(:fetch_authenticated_user_data)
  end
end

# rubocop:enable all
