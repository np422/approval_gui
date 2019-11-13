b = Bunny.new(host: 'localhost')
b.start
ch = b.create_channel
queue = ch.queue('customer_queue', durable: true)

queue.subscribe(manual_ack: true, block: true) do |_delivery_info, properties, payload|
  c = Customer.new
  c.from_json(payload)
  c.approved = false
  if c.save
    n = GELF::Notifier.new('zaklog1', 12_201)
    n.notify!(short_message: "Imported new user #{name}", full_message: c.to_json)
  end
end
