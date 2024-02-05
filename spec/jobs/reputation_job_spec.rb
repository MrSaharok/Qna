require 'rails_helper'

RSpec.describe ReputationJob, type: :job do
  let(:user) { create(:user) }
  let(:question) { build(:question, user: user) }

  it 'calls Reputation#call' do
    expect(Reputation).to receive(:call).with(question)
    ReputationJob.perform_now(question)
  end
end
