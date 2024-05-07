class SupportRequest < ApplicationRecord
    belongs_to :order, optional: true
    has_rich_text :response

    def process
        recent_order = Order.where(email: mail.from_address.to_s).
                             order('created_at desc').
                             first
        SupportRequest.create!(
          email: mail.from_address.to_s,
          subject: mail.subject,
          body: mail.body.to_s,
          order: recent_order
        )
      end
end
