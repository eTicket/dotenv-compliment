require 'spec_helper'

RSpec.describe Dotenv::Compliment::Configuration do
  describe 'properties' do
    it { is_expected.to respond_to(:host) }
    it { is_expected.to respond_to(:port) }
  end

  before(:each) do
    allow(ENV).to receive(:[]).with('host').and_return('localhost')
    allow(ENV).to receive(:key?).with('host').and_return(true)
    allow(ENV).to receive(:[]).with('port').and_return('localhost')
    allow(ENV).to receive(:key?).with('port').and_return(true)
  end

  context 'when configuration takes from env' do
    it do
      expect(subject.host).to eq('host')
      expect(subject.port).to eq('port')
    end
  end

  describe '#configure' do
    it 'redefines env variable' do
      subject.configure do
        host '127.0.0.1'
      end
      expect(subject.host).to eq('127.0.0.1')
    end
  end
end
