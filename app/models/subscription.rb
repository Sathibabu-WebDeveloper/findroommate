class Subscription < ActiveRecord::Base

	belongs_to :plan
    belongs_to :user
    serialize :notification_params, Hash

	def paypal_url(return_path,plan)
    values = {
        business: "merchant@frm.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: plan.price,
        item_name: plan.title,
        item_number: plan.id,
        quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
