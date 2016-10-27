require 'rails_helper'

RSpec.describe RedisEndpoint do
  let(:namespace) { 'foobar' }
  describe '.options' do
    subject { described_class.new namespace: namespace }

    it 'uses the configured application settings' do
      expect(subject.options[:namespace]).to eq namespace
    end
  end

  describe '#ping' do
    it 'checks if the service is up' do
      allow(Sufia::RedisEventStore.instance).to receive(:ping).and_return('PONG')
      expect(subject.ping).to be_truthy
    end

    it 'is false if the service is down' do
      allow(Sufia::RedisEventStore.instance).to receive(:ping).and_raise(RuntimeError)
      expect(subject.ping).to eq false
    end
  end
end
