require 'aws-sdk'

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

  def initialize
    @sqs ||= Aws::SQS::Client.new
    @q_url ||= @sqs.get_queue_url(queue_name: 'AppStoreQueue').queue_url
  end

  ##
  # Gets configuration ticket
  # Returns: ChoiceSet object if valid choiceset still exists
  #          nil if no more choicesets found (NOTE: could be temporary)
  def start_choiceset
    msg = @sqs.receive_message(queue_url: @q_url).messages.first
    rep, config = msg.body.split(':').map(&:to_i)
    set = ChoiceSet.new(rep, config, msg.receipt_handle)
  end

  ##
  # Confirms close of configuration ticket
  # Parameters: ChoiceSet object
  # Returns: true if success, Exception
  def close_choiceset(receipt)
    resp =  @sqs.delete_message({queue_url: @q_url, receipt_handle: receipt})
    true
  rescue Aws::SQS::Errors::ReceiptHandleIsInvalid
    raise ArgumentError, "Input receipt \"#{receipt}\" is not a valid receipt"
  rescue => e
    raise RuntimeError, "Could not send the delete request to SQS", e
  end

  private

  def fill_queue()
    reps = (1..3)
    combos = (1..144)

    reps.each do |r|
      combos.each do |c|
        msg = "#{r}:#{c}"
        print "#{msg}, "
        @sqs.send_message(queue_url: @q_url, message_body: msg)
      end
    end
  end
end

# q_attr =  @sqs.get_queue_attributes(
#               queue_url: @q_url,
#               attribute_names: ['ApproximateNumberOfMessages']
#             )
