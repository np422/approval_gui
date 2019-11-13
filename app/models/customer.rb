# Foo
class Customer < ApplicationRecord
  before_save :logg_changed_approved_status, if: :will_save_change_to_approved?

  def logg_changed_approved_status
    if changed_attributes['approved'].zero?
      Rails.logger.info(short_message: "Customer #{name} approved",
                        full_message: to_json)
    else
      Rails.logger.info(short_message: "Customer #{name} not approved",
                        full_message: to_json)
    end
  end
end
