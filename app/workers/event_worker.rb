# frozen_string_literal: true

# Foo
class EventWorker
  include Sneakers::Worker
  from_queue 'customer_exchange', env: nil

  def work(raw_event)
    event_params = JSON.parse(raw_event)
    logger.info event_params
    ack!
  end
end
