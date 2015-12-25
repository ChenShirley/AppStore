
class ChoiceSet
  attr_reader :replication
  attr_reader :configuration
  attr_reader :receipt_handle

  def initialize(rep, configuration, receipt)
    @rep = rep
    @configuration = configuration
    @receipt_handle = receipt
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
#   # After user has finished experiment
#   ChoiceSetService.new.close_choiceset(receipt)
class ChoiceSetService
  TIMEOUT_MINUTES = 20

  ##
  # Gets configuration ticket
  # Returns: ChoiceSet object if valid choiceset still exists
  #          nil if no more choicesets found
  def start_choiceset()
    # ...
  end

  ##
  # Confirms close of configuration ticket
  # Parameters: ChoiceSet object
  def close_choiceset(choiceset)
    # ...
  end

  private
end
