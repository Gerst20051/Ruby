#!/usr/bin/env ruby

# [$]> ./robotic_automation_factory.rb

require 'test/unit'

class InvalidInput < StandardError; end

class DispatchType
  STANDARD = :standard
  SPECIAL = :special
  REJECTED = :rejected
end

class AutomationFactory
  THRESHOLD_BULKY_CM = 1_000_000
  THRESHOLD_BULKY_DIMENSION_CM = 150
  THRESHOLD_HEAVY_KG = 20

  def sort(width, height, length, mass)
    raise InvalidInput if width.nil? || width.negative?
    raise InvalidInput if height.nil? || height.negative?
    raise InvalidInput if length.nil? || length.negative?
    raise InvalidInput if mass.nil? || mass.negative?

    is_bulky = bulky?(width, height, length)
    is_heavy = heavy?(mass)

    return DispatchType::REJECTED if is_bulky && is_heavy
    return DispatchType::SPECIAL if is_bulky || is_heavy
    DispatchType::STANDARD
  end

  private

  def bulky?(width_cm, height_cm, length_cm)
    return true if [width_cm, height_cm, length_cm].any? do |dimension|
      dimension >= THRESHOLD_BULKY_DIMENSION_CM
    end
    THRESHOLD_BULKY_CM <= width_cm * height_cm * length_cm
  end

  def heavy?(mass_kg)
    THRESHOLD_HEAVY_KG <= mass_kg
  end
end

class AutomationFactoryTest < Test::Unit::TestCase
  def setup
    @factory = AutomationFactory.new
  end

  def test_standard
    assert_equal @factory.sort(1, 1, 1, 1), DispatchType::STANDARD
    assert_equal @factory.sort(149, 1, 1, 1), DispatchType::STANDARD
    assert_equal @factory.sort(1, 149, 1, 1), DispatchType::STANDARD
    assert_equal @factory.sort(1, 1, 149, 1), DispatchType::STANDARD
    assert_equal @factory.sort(1, 1, 149, 19), DispatchType::STANDARD
    assert_equal @factory.sort(99, 100, 100, 19), DispatchType::STANDARD
    assert_equal @factory.sort(100, 99, 100, 19), DispatchType::STANDARD
    assert_equal @factory.sort(100, 100, 99, 19), DispatchType::STANDARD
  end

  def test_single_large_dimension
    assert_equal @factory.sort(150, 1, 1, 1), DispatchType::SPECIAL
    assert_equal @factory.sort(1, 150, 1, 1), DispatchType::SPECIAL
    assert_equal @factory.sort(1, 1, 150, 1), DispatchType::SPECIAL
  end

  def test_only_heavy
    assert_equal @factory.sort(10, 10, 10, 20), DispatchType::SPECIAL
  end

  def test_dimensions_equal_threshold
    assert_equal @factory.sort(100, 100, 100, 1), DispatchType::SPECIAL
  end

  def test_bulky_and_heavy_rejected
    assert_equal @factory.sort(100, 100, 100, 20), DispatchType::REJECTED
    assert_equal @factory.sort(1000, 1000, 1000, 2000), DispatchType::REJECTED
  end

  def test_invalid_inputs_nil
    assert_raises InvalidInput do
      @factory.sort(nil, 1, 1, 1)
    end

    assert_raises InvalidInput do
      @factory.sort(1, nil, 1, 1)
    end

    assert_raises InvalidInput do
      @factory.sort(1, 1, nil, 1)
    end

    assert_raises InvalidInput do
      @factory.sort(1, 1, 1, nil)
    end
  end

  def test_invalid_inputs_negative
    assert_raises InvalidInput do
      @factory.sort(-1, 1, 1, 1)
    end

    assert_raises InvalidInput do
      @factory.sort(1, -1, 1, 1)
    end

    assert_raises InvalidInput do
      @factory.sort(1, 1, -1, 1)
    end

    assert_raises InvalidInput do
      @factory.sort(1, 1, 1, -1)
    end
  end
end
