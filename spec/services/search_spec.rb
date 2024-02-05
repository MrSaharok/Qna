require 'rails_helper'

RSpec.describe Search do
  Search::SCOPES.each do |scope|
    it "calls search from #{scope}" do
      expect(scope.classify.constantize).to receive(:search).with('test')
      Search.call(query: 'test', scope: scope)
    end
  end

  it 'not exist scope' do
    expect(Search.call(query: 'test', scope: 'NotExist')).to be_nil
  end
end
