RSpec.describe Quicken::Plugins::Git do
  context 'configuration' do
    let(:remote_url) { 'https://github.com/quicken-rb/quicken-git' }
    before { allow(Dir).to receive(:pwd).and_return 'test' }

    it 'creates an instance with the current dir as path' do
      subject = described_class.new(true)
      expect(subject.instance_variable_get(:@path)).to eq 'test'
    end

    it 'creates an instance from a simple repository path' do
      subject = described_class.new('test')
      expect(subject.instance_variable_get(:@path)).to eq 'test'
    end
    
    it 'creates an instance from a path and a remote URL' do
      config = { path: 'test', remote: remote_url }
      subject = described_class.new(config)
      expect(subject.instance_variable_get(:@path)).to eq 'test'
      origin = subject.instance_variable_get(:@remotes).first
      expect(origin.name).to eq :origin
      expect(origin.url).to eq remote_url
    end

    it 'creates an instance a remote URL' do
      config = { remote: remote_url }
      subject = described_class.new(config)
      expect(subject.instance_variable_get(:@path)).to eq 'test'
      origin = subject.instance_variable_get(:@remotes).first
      expect(origin.name).to eq :origin
      expect(origin.url).to eq remote_url
    end

    it 'creates an instance from a path and a list of remotes' do
      begin
        config = { path: 'test', remote: { origin: remote_url, test: remote_url } }
        subject = described_class.new(config)
        expect(subject.instance_variable_get(:@path)).to eq 'test'
        origin = subject.instance_variable_get(:@remotes).first
        remote = subject.instance_variable_get(:@remotes).last
        expect(origin.name).to eq :origin
        expect(remote.name).to eq :test
        [origin, remote].each { |r| expect(r.url).to eq remote_url }
      rescue SystemExit => e
        fail e.message
      end
    end
    
    VALIDATION_EXAMPLES = [
      {},
      { path: 'test', remote: [] },
      { path: 'test', remote: { test: [] } },
      { path: [] },
      { remote: [] }
    ]

    VALIDATION_EXAMPLES.each_with_index do |config, index|
      it "aborts if the configuration is malformed - n.#{index}" do
       expect{ described_class.new(config) }.to raise_error SystemExit
      end
    end
  end
end