#!/usr/bin/env ruby

# [$]> ./cannabinoid_potential.rb

require 'csv'
require 'stringio'
require 'test/unit'

class CannabinoidPotential
  DECARBOXYLATION_FACTOR = 0.877

  def initialize
    @cannabinoids = {}
  end

  def add_cannabinoid(chemical, measurement)
    @cannabinoids[chemical] = measurement.to_f
  end

  def thc_potential
    (@cannabinoids.fetch('thc', 0) + DECARBOXYLATION_FACTOR * @cannabinoids.fetch('thca', 0)) * 100
  end

  def cbd_potential
    (@cannabinoids.fetch('cbd', 0) + DECARBOXYLATION_FACTOR * @cannabinoids.fetch('cbda', 0)) * 100
  end

  def terpene_content
    @cannabinoids.keys.select do |key|
      key.end_with?('ol') or key.end_with?('ene')
    end.map do |key|
      @cannabinoids[key]
    end.sum * 100
  end

  def output_summary
    puts "THC potential: #{'%.2f' % thc_potential.round(2)}%"
    puts "CBD potential: #{'%.2f' % cbd_potential.round(2)}%"
    puts "Terpene content: #{'%.2f' % terpene_content.round(2)}%"
  end
end

def read_stdout(&block)
  tmp = $stdout
  $stdout = tmp = StringIO.new
  block.call
  tmp.string
  ensure
  $stdout = tmp
end

class CannabinoidPotentialTest < Test::Unit::TestCase
  def test_matching_output
    cannabinoidPotential = CannabinoidPotential.new
    csvInput = <<~CSV
      chemical,measurement
      CBD,0.133
      CBDA,0.0
      PINENE,0.0591
      THC,0.141
      THCA,0.001
    CSV
    expectedOutput = <<~OUTPUT
      THC potential: 14.19%
      CBD potential: 13.30%
      Terpene content: 5.91%
    OUTPUT
    CSV.new(csvInput, headers: true).each do |row|
      cannabinoidPotential.add_cannabinoid(row['chemical'].downcase, row['measurement'])
    end
    output = read_stdout do
      cannabinoidPotential.output_summary
    end
    assert_equal output, expectedOutput
  end
end
