b = Bunny.new(host: 'localhost')
b.start
ch = b.create_channel
queue = ch.queue('customer_queue', durable: true)

queue.subscribe(manual_ack: false, block: true) do |_delivery_info, _properties, payload|
  Rails.logger.info('Queue event')
  c = Customer.new
  c.from_json(payload)
  c.approved = false
  if c.save
    Rails.logger.info(short_message: "Imported new user #{c.name}", full_message: c.to_json)
  end
end
