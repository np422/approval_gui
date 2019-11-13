# frozen_string_literal: true
require 'sneakers'
require 'sneakers/handlers/maxretry'

Sneakers.configure  daemonize: true,
  amqp: "amqp://localhost",
  log: "log/sneakers.log",
  pid_path: "tmp/pids/sneakers.pid",
  threads: 1,
  workers: 1,
  log_stdout: true
