require 'timeout'
require_relative '../integer_container'

=begin
The test class below can be considered as a playground - feel free to modify it as you need, e.g.:
- add your own custom tests
- delete existing tests
- modify test contents or expected output
=end

RSpec.describe 'SandboxTests' do
  before(:each) do
    @container = IntegerContainer.new()
  end

  it 'test sample' do
    Timeout::timeout(0.4) do
      expect(@container.add(5)).to eq 1
      expect(@container.add(10)).to eq 2
      expect(@container.add(5)).to eq 3
      expect(@container.delete(10)).to eq true
      expect(@container.delete(1)).to eq false
      expect(@container.add(1)).to eq 3
    end
  end
end
