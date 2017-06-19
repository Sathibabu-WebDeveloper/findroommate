class AddSettingsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_visible, :boolean, default: false
    add_column :profiles, :email_notification, :boolean,default: false
    add_column :profiles, :message_notification, :boolean,default: false
  end
end
