require 'timeout'
require_relative '../integer_container'

=begin
The test class below includes 10 tests for Level 1.
=end

RSpec.describe 'Level1Tests' do
  before(:each) do
    @container = IntegerContainer.new()
  end

  it 'test level 1 case 01 add two numbers' do
    Timeout::timeout(0.4) do
      expect(@container.add(10)).to eq 1
      expect(@container.add(100)).to eq 2
    end
  end

  it 'test level 1 case 02 add many numbers' do
    Timeout::timeout(0.4) do
      expect(@container.add(10)).to eq 1
      expect(@container.add(9)).to eq 2
      expect(@container.add(8)).to eq 3
      expect(@container.add(7)).to eq 4
      expect(@container.add(6)).to eq 5
      expect(@container.add(5)).to eq 6
      expect(@container.add(4)).to eq 7
      expect(@container.add(3)).to eq 8
      expect(@container.add(2)).to eq 9
      expect(@container.add(1)).to eq 10
    end
  end

  it 'test level 1 case 03 delete number' do
    Timeout::timeout(0.4) do
      expect(@container.add(10)).to eq 1
      expect(@container.add(100)).to eq 2
      expect(@container.delete(10)).to eq true
    end
  end

  it 'test level 1 case 04 delete nonexisting number' do
    Timeout::timeout(0.4) do
      expect(@container.add(10)).to eq 1
      expect(@container.add(100)).to eq 2
      expect(@container.delete(20)).to eq false
      expect(@container.delete(10)).to eq true
      expect(@container.delete(10)).to eq false
    end
  end

  it 'test level 1 case 05 add and delete same numbers' do
    Timeout::timeout(0.4) do
      expect(@container.add(10)).to eq 1
      expect(@container.add(10)).to eq 2
      expect(@container.add(10)).to eq 3
      expect(@container.add(10)).to eq 4
      expect(@container.add(10)).to eq 5
      expect(@container.delete(10)).to eq true
      expect(@container.delete(10)).to eq true
      expect(@container.delete(10)).to eq true
      expect(@container.delete(10)).to eq true
      expect(@container.delete(10)).to eq true
      expect(@container.delete(10)).to eq false
      expect(@container.delete(10)).to eq false
    end
  end

  it 'test level 1 case 06 add delete several times' do
    Timeout::timeout(0.4) do
      expect(@container.add(555)).to eq 1
      expect(@container.delete(555)).to eq true
      expect(@container.delete(555)).to eq false
      expect(@container.add(555)).to eq 1
      expect(@container.delete(555)).to eq true
      expect(@container.delete(555)).to eq false
    end
  end

  it 'test level 1 case 07 delete in random order' do
    Timeout::timeout(0.4) do
      expect(@container.add(10)).to eq 1
      expect(@container.add(20)).to eq 2
      expect(@container.add(30)).to eq 3
      expect(@container.add(40)).to eq 4
      expect(@container.add(40)).to eq 5
      expect(@container.delete(30)).to eq true
      expect(@container.delete(30)).to eq false
      expect(@container.delete(10)).to eq true
      expect(@container.delete(10)).to eq false
      expect(@container.delete(40)).to eq true
      expect(@container.delete(40)).to eq true
      expect(@container.delete(40)).to eq false
      expect(@container.delete(20)).to eq true
      expect(@container.delete(20)).to eq false
    end
  end

  it 'test level 1 case 08 delete before add' do
    Timeout::timeout(0.4) do
      expect(@container.delete(1)).to eq false
      expect(@container.delete(2)).to eq false
      expect(@container.delete(3)).to eq false
      expect(@container.add(1)).to eq 1
      expect(@container.add(2)).to eq 2
      expect(@container.add(3)).to eq 3
      expect(@container.delete(3)).to eq true
      expect(@container.delete(2)).to eq true
      expect(@container.delete(1)).to eq true
      expect(@container.delete(3)).to eq false
      expect(@container.delete(2)).to eq false
      expect(@container.delete(1)).to eq false
    end
  end

  it 'test level 1 case 09 mixed operation 1' do
    Timeout::timeout(0.4) do
      expect(@container.add(10)).to eq 1
      expect(@container.add(15)).to eq 2
      expect(@container.add(20)).to eq 3
      expect(@container.add(10)).to eq 4
      expect(@container.add(5)).to eq 5
      expect(@container.delete(15)).to eq true
      expect(@container.delete(20)).to eq true
      expect(@container.delete(20)).to eq false
      expect(@container.delete(0)).to eq false
      expect(@container.add(7)).to eq 4
      expect(@container.add(9)).to eq 5
      expect(@container.delete(7)).to eq true
      expect(@container.delete(10)).to eq true
      expect(@container.delete(10)).to eq true
      expect(@container.delete(10)).to eq false
      expect(@container.delete(100)).to eq false
    end
  end

  it 'test level 1 case 10 mixed operation 2' do
    Timeout::timeout(0.4) do
      expect(@container.delete(6)).to eq false
      expect(@container.add(100)).to eq 1
      expect(@container.delete(200)).to eq false
      expect(@container.add(500)).to eq 2
      expect(@container.delete(0)).to eq false
      expect(@container.add(300)).to eq 3
      expect(@container.delete(1000)).to eq false
      expect(@container.add(400)).to eq 4
      expect(@container.delete(300)).to eq true
      expect(@container.delete(400)).to eq true
      expect(@container.delete(100)).to eq true
      expect(@container.delete(500)).to eq true
      expect(@container.add(1000)).to eq 1
      expect(@container.add(100)).to eq 2
      expect(@container.add(10)).to eq 3
      expect(@container.add(1)).to eq 4
      expect(@container.delete(100)).to eq true
      expect(@container.delete(500)).to eq false
      expect(@container.delete(300)).to eq false
      expect(@container.delete(400)).to eq false
    end
  end
end
