class ReputationJob < ApplicationJob
  queue_as :default

  def perform(object)
    Reputation.call(object)
  end
end
