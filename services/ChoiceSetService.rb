require 'aws-sdk'
require 'ostruct'

class ChoiceSet
  attr_reader :replication
  attr_reader :configuration
  attr_reader :receipt

  def initialize(replication, configuration, receipt)
    @replication = replication
    @configuration = configuration
    @receipt = receipt
  end
end

##
# Start and close experiment choiceset tickets
#
# Usage:
#   # To start choiceset for new user
#   choiceset = ChoiceSetService.new.start_choiceset
#   receipt = choiceset.receipt
#   puts choiceset.repetition
#   puts choiceset.configuration
#
#   # After user has finished experiment (IF their response is valid)
#   ChoiceSetService.new.close_choiceset(receipt)
class ChoiceSetService
  TIMEOUT_MINUTES = 20

  def initialize(fake: false)
    # Use a fake choiceset queue if requested, or AWS credentials not present
    if (!fake && ENV.has_key?('AWS_REGION'))
      @queue = ChoiceSetQueue.new
    else
      @queue = FakeSetQueue.new
    end
  end

  ##
  # Gets configuration ticket
  # Returns: ChoiceSet object if valid choiceset still exists
  #          nil if no more choicesets found (NOTE: could be temporary)
  def start_choiceset
    msg = @queue.fetch
    rep, config = msg.body.split(':').map(&:to_i)
    set = ChoiceSet.new(rep, config, msg.receipt_handle)
  end

  ##
  # Confirms close of configuration ticket
  # Parameters: ChoiceSet object
  # Returns: true if success, Exception
  def close_choiceset(receipt)
    @queue.done(receipt)
  end
end

class ChoiceSetQueue
  def initialize
    @sqs = Aws::SQS::Client.new
    @q_url = @sqs.get_queue_url(queue_name: 'AppStoreQueue').queue_url
  end

  def fetch
    msg = @sqs.receive_message( queue_url: @q_url,
                                wait_time_seconds: 2).messages.first
  end

  def done(receipt)
    @sqs.delete_message({queue_url: @q_url, receipt_handle: receipt})
    true
  rescue Aws::SQS::Errors::ReceiptHandleIsInvalid
    raise ArgumentError, "Input receipt \"#{receipt}\" is not a valid receipt"
  rescue => e
    raise RuntimeError, "Could not send the delete request to SQS", e
  end

  ##
  # Fill the queue wil repititions and combinations
  # Parameters: reps and combos, each as array or range
  # Ex.:  fill_queue(1..3, 1..144)
  #       fill_queue([1,3], 1..144)
  def fill_queue(reps, combos)
    reps.each do |r|
      combos.each do |c|
        msg = "#{r}:#{c}"
        print "#{msg}, "
        @sqs.send_message(queue_url: @q_url, message_body: msg)
      end
    end
    self
  end

  def purge_queue
    @sqs.purge_queue(queue_url: @q_url)
  end

  def sets_remaining
    @sqs.get_queue_attributes(
      queue_url: @q_url,
      attribute_names: ['ApproximateNumberOfMessages']
    ).attributes['ApproximateNumberOfMessages'].to_i
  end
end

class FakeSetQueue
  @@queue = Queue.new
  @@dead_queue = Array.new

  def initialize
    fill_queue(1..3, 1..144) if @@queue.size == 0
  end

  def fetch
    msg_body = @@queue.pop
    @@dead_queue.push(msg_body)
    OpenStruct.new(receipt_handle: msg_body, body: msg_body)
  end

  def done(receipt)
    if @@dead_queue.delete(receipt)
      true
    else
      raise ArgumentError, "Input receipt \"#{receipt}\" is not a valid receipt"
    end
  end

  ##
  # Fill the queue wil repititions and combinations
  # Parameters: reps and combos, each as array or range
  # Ex.:  fill_queue(1..3, 1..144)
  #       fill_queue([1,3], 1..144)
  def fill_queue(reps, combos)
    reps.each do |r|
      combos.each do |c|
        msg = "#{r}:#{c}"
        print "#{msg}, "
        @@queue.push(msg)
      end
    end
    self
  end

  def purge_queue
    @@queue.clear
  end

  def sets_remaining
    @@queue.size
  end
end
