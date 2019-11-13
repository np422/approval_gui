b = Bunny.new(host: 'localhost')
b.start
ch = b.create_channel
queue = ch.queue('customer_queue', durable: true)

queue.subscribe(manual_ack: false, block: true) do |_delivery_info, _properties, payload|
  c = Customer.new
  c.from_json(payload)
  c.approved = false
  if c.save
    Rails.configuration.notifier.notify!(short_message: "Imported new user #{name}",
                                         full_message: c.to_json)
    ack!
  end
end
