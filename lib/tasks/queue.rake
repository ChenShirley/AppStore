require 'aws-sdk'
require_relative '../../services/ChoiceSetService'

namespace :queue do
  task :setup do
    @sqs = Aws::SQS::Client.new(region: ENV['AWS_REGION'])
  end

  desc "Create the queue for ChoiceSet configurations"
  task create: [:environment, :setup] do

    begin
      queue = @sqs.create_queue(queue_name: 'AppStoreQueue')
      puts "Queue created"
    rescue => e
      puts "Error creating queue: #{e}"
    end
  end

  desc "Fill the ChoiceSet queue on SQS"
  task fill: [:environment, :setup] do
    ChoiceSetQueue.new.fill_queue((1..3),(1..144), should_buffer=true)
  end

  desc "Purge the ChoiceSet queue on SQS"
  task purge: [:environment, :setup] do
    ChoiceSetQueue.new.purge_queue
  end
end
