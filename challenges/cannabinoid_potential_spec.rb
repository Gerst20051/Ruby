# [$]> rspec challenges
# [$]> rspec cannabinoid_potential_spec.rb

require 'csv'
require 'rspec'
require 'stringio'

require './cannabinoid_potential'

def read_stdout(&block)
  tmp = $stdout
  $stdout = tmp = StringIO.new
  block.call
  tmp.string
  ensure
  $stdout = tmp
end

RSpec.describe CannabinoidPotential do
  context 'test 1' do
    it 'matches output' do
      cannabinoidPotential = CannabinoidPotential.new
      csvInput = <<~CSV
        chemical,measurement
        CBD,0.133
        CBDA,0.0
        PINENE,0.0591
        THC,0.141
        THCA,0.001
      CSV
      CSV.new(csvInput, headers: true).each do |row|
        cannabinoidPotential.add_cannabinoid(row['chemical'].downcase, row['measurement'])
      end
      output = read_stdout do
        cannabinoidPotential.output_summary
      end
      expect(output).to eq <<~OUTPUT
        THC potential: 14.19%
        CBD potential: 13.30%
        Terpene content: 5.91%
      OUTPUT
    end
  end

  context 'test 2' do
    it 'matches output' do
      cannabinoidPotential = CannabinoidPotential.new
      csvInput = <<~CSV
        chemical,measurement
        cbda,0.002
        cbn,0.001
        geraniol,0.003
        limonene,0.01
        myrcene,0.002
        thc,0.02
        thca,0.234
        thcv,0.003
      CSV
      CSV.new(csvInput, headers: true).each do |row|
        cannabinoidPotential.add_cannabinoid(row['chemical'].downcase, row['measurement'])
      end
      output = read_stdout do
        cannabinoidPotential.output_summary
      end
      expect(output).to eq <<~OUTPUT
        THC potential: 22.52%
        CBD potential: 0.18%
        Terpene content: 1.50%
      OUTPUT
    end
  end

  context 'test 3' do
    it 'matches output' do
      cannabinoidPotential = CannabinoidPotential.new
      csvInput = <<~CSV
        chemical,measurement
        CBDa,0.054
        CBD,0.0002
        CBn,0.001
        Geraniol,0.003
        Limonene,0.01
        THC,0.02
        THCa,0.234
      CSV
      CSV.new(csvInput, headers: true).each do |row|
        cannabinoidPotential.add_cannabinoid(row['chemical'].downcase, row['measurement'])
      end
      output = read_stdout do
        cannabinoidPotential.output_summary
      end
      expect(output).to eq <<~OUTPUT
        THC potential: 22.52%
        CBD potential: 4.76%
        Terpene content: 1.30%
      OUTPUT
    end
  end

  context 'test 4' do
    it 'matches output' do
      cannabinoidPotential = CannabinoidPotential.new
      csvInput = <<~CSV
        chemical,measurement
        CBD,0.133
        CBDA,NULL
        PINENE,0.0591
        THC,0.141
        THCA,0.001
      CSV
      CSV.new(csvInput, headers: true).each do |row|
        cannabinoidPotential.add_cannabinoid(row['chemical'].downcase, row['measurement'])
      end
      output = read_stdout do
        cannabinoidPotential.output_summary
      end
      expect(output).to eq <<~OUTPUT
        THC potential: 14.19%
        CBD potential: 13.30%
        Terpene content: 5.91%
      OUTPUT
    end
  end
end
