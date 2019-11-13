b = Bunny.new(host: 'localhost')
b.start
ch = b.create_channel
queue = ch.queue('customer_queue', durable: true)

queue.subscribe(manual_ack: true, block: true) do |_delivery_info, properties, payload|
  c = Customer.new
  c.from_json(payload)
  c.approved = false
  c.save
end
