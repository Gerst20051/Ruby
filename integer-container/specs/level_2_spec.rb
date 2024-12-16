require 'timeout'
require_relative '../integer_container'

=begin
The test class below includes 10 tests for Level 2.
=end

RSpec.describe 'Level2Tests' do
  before(:each) do
    @container = IntegerContainer.new()
  end

  it 'test level 2 case 01 simple median odd length' do
    Timeout::timeout(0.4) do
      expect(@container.add(1)).to eq 1
      expect(@container.add(2)).to eq 2
      expect(@container.add(5)).to eq 3
      expect(@container.add(7)).to eq 4
      expect(@container.add(9)).to eq 5
      expect(@container.get_median()).to eq 5
      expect(@container.add(11)).to eq 6
      expect(@container.add(15)).to eq 7
      expect(@container.get_median()).to eq 7
    end
  end

  it 'test level 2 case 02 simple median even length' do
    Timeout::timeout(0.4) do
      expect(@container.add(10)).to eq 1
      expect(@container.add(20)).to eq 2
      expect(@container.get_median()).to eq 10
      expect(@container.add(30)).to eq 3
      expect(@container.add(40)).to eq 4
      expect(@container.get_median()).to eq 20
      expect(@container.get_median()).to eq 20
      expect(@container.add(50)).to eq 5
      expect(@container.add(60)).to eq 6
      expect(@container.add(70)).to eq 7
      expect(@container.add(80)).to eq 8
      expect(@container.get_median()).to eq 40
    end
  end

  it 'test level 2 case 03 median of empty container' do
    Timeout::timeout(0.4) do
      expect(@container.get_median()).to eq nil
      expect(@container.add(1)).to eq 1
      expect(@container.get_median()).to eq 1
    end
  end

  it 'test level 2 case 04 median of non sorted container' do
    Timeout::timeout(0.4) do
      expect(@container.add(3)).to eq 1
      expect(@container.add(2)).to eq 2
      expect(@container.add(5)).to eq 3
      expect(@container.add(4)).to eq 4
      expect(@container.add(1)).to eq 5
      expect(@container.get_median()).to eq 3
      expect(@container.add(8)).to eq 6
      expect(@container.add(6)).to eq 7
      expect(@container.add(7)).to eq 8
      expect(@container.get_median()).to eq 4
    end
  end

  it 'test level 2 case 05 median of container with duplicates' do
    Timeout::timeout(0.4) do
      expect(@container.add(5)).to eq 1
      expect(@container.add(3)).to eq 2
      expect(@container.add(5)).to eq 3
      expect(@container.add(5)).to eq 4
      expect(@container.add(10)).to eq 5
      expect(@container.add(3)).to eq 6
      expect(@container.get_median()).to eq 5
      expect(@container.add(3)).to eq 7
      expect(@container.add(3)).to eq 8
      expect(@container.add(3)).to eq 9
      expect(@container.get_median()).to eq 3
    end
  end

  it 'test level 2 case 06 median with deletions' do
    Timeout::timeout(0.4) do
      expect(@container.add(30)).to eq 1
      expect(@container.add(20)).to eq 2
      expect(@container.add(10)).to eq 3
      expect(@container.get_median()).to eq 20
      expect(@container.delete(30)).to eq true
      expect(@container.get_median()).to eq 10
      expect(@container.delete(10)).to eq true
      expect(@container.get_median()).to eq 20
      expect(@container.delete(20)).to eq true
      expect(@container.get_median()).to eq nil
    end
  end

  it 'test level 2 case 07 double median and deletions' do
    Timeout::timeout(0.4) do
      expect(@container.get_median()).to eq nil
      expect(@container.get_median()).to eq nil
      expect(@container.delete(239)).to eq false
      expect(@container.get_median()).to eq nil
      expect(@container.get_median()).to eq nil
      expect(@container.add(239)).to eq 1
      expect(@container.get_median()).to eq 239
      expect(@container.get_median()).to eq 239
      expect(@container.delete(239)).to eq true
      expect(@container.delete(239)).to eq false
      expect(@container.get_median()).to eq nil
      expect(@container.get_median()).to eq nil
    end
  end

  it 'test level 2 case 08 median of container with negative integers' do
    Timeout::timeout(0.4) do
      expect(@container.add(-20)).to eq 1
      expect(@container.add(-10)).to eq 2
      expect(@container.add(10)).to eq 3
      expect(@container.add(20)).to eq 4
      expect(@container.add(0)).to eq 5
      expect(@container.get_median()).to eq 0
      expect(@container.add(-30)).to eq 6
      expect(@container.get_median()).to eq -10
      expect(@container.add(30)).to eq 7
      expect(@container.get_median()).to eq 0
      expect(@container.add(40)).to eq 8
      expect(@container.add(50)).to eq 9
      expect(@container.get_median()).to eq 10
    end
  end

  it 'test level 2 case 09 mixed operations 1' do
    Timeout::timeout(0.4) do
      expect(@container.get_median()).to eq nil
      expect(@container.add(5)).to eq 1
      expect(@container.add(3)).to eq 2
      expect(@container.add(5)).to eq 3
      expect(@container.add(7)).to eq 4
      expect(@container.add(8)).to eq 5
      expect(@container.add(9)).to eq 6
      expect(@container.get_median()).to eq 5
      expect(@container.delete(5)).to eq true
      expect(@container.delete(8)).to eq true
      expect(@container.get_median()).to eq 5
      expect(@container.delete(5)).to eq true
      expect(@container.delete(5)).to eq false
      expect(@container.get_median()).to eq 7
      expect(@container.add(5)).to eq 4
      expect(@container.get_median()).to eq 5
      expect(@container.delete(5)).to eq true
      expect(@container.delete(5)).to eq false
      expect(@container.delete(7)).to eq true
      expect(@container.delete(3)).to eq true
      expect(@container.get_median()).to eq 9
      expect(@container.delete(9)).to eq true
      expect(@container.get_median()).to eq nil
      expect(@container.delete(9)).to eq false
      expect(@container.get_median()).to eq nil
    end
  end

  it 'test level 2 case 10 mixed operations 2' do
    Timeout::timeout(0.4) do
      expect(@container.get_median()).to eq nil
      expect(@container.add(1)).to eq 1
      expect(@container.add(1)).to eq 2
      expect(@container.add(2)).to eq 3
      expect(@container.add(2)).to eq 4
      expect(@container.add(3)).to eq 5
      expect(@container.add(3)).to eq 6
      expect(@container.add(4)).to eq 7
      expect(@container.add(4)).to eq 8
      expect(@container.add(5)).to eq 9
      expect(@container.add(5)).to eq 10
      expect(@container.get_median()).to eq 3
      expect(@container.delete(1)).to eq true
      expect(@container.delete(1)).to eq true
      expect(@container.delete(1)).to eq false
      expect(@container.get_median()).to eq 3
      expect(@container.delete(2)).to eq true
      expect(@container.delete(2)).to eq true
      expect(@container.delete(2)).to eq false
      expect(@container.get_median()).to eq 4
      expect(@container.delete(3)).to eq true
      expect(@container.delete(4)).to eq true
      expect(@container.delete(5)).to eq true
      expect(@container.get_median()).to eq 4
    end
  end
end
