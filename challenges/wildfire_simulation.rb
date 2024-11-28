#!/usr/bin/env ruby

# [$]> ./wildfire_simulation.rb

require 'terminal-table'
require 'test/unit'

=begin
The west coast has seen increasing number of wild fires lately. Imagine you are working on developing a wild fire
simulation application that shows how fire will spread when started on a particular spot of a map.
For simplicity, let's assume the map is represented by hexagons each having a terrain type (water, vegetation,
rocks etc...) Let's say for the minimal viable product a fire will spread to neighboring area only if it contains
code that given a fire's starting point in the map, it will return all of the areas that the fire would have
spread to if left unattended.
=end

class TerrainType
  ROCKS = :rocks
  VEGETATION = :vegetation
  WATER = :water
end

class TerrainHexagon
  attr_reader :is_on_fire

  def initialize(terrain_type)
    @terrain_type = terrain_type
    @is_on_fire = false
  end

  def can_burn?
    [TerrainType::VEGETATION].include? @terrain_type
  end

  def set_fire
    if can_burn?
      @is_on_fire = true
    end
  end

  def to_emoji
    case @terrain_type
      when TerrainType::ROCKS then '🪨'
      when TerrainType::VEGETATION
        if is_on_fire then '🔥' else '🎄'
      end
      when TerrainType::WATER then '💦'
    end
  end
end

class TerrainMap
  def initialize(grid_size)
    @grid_size = grid_size
    @visited_coordinates = []
    @hexagons = {}
  end

  def get_on_fire_blocks
    @hexagons.select { |coordinate, hexagon| hexagon.is_on_fire }
  end

  # NOTE: this could return all blocks that catch on fire
  def start_fire(coordinate)
    hexagon = @hexagons[coordinate.to_sym]
    return unless hexagon && hexagon.can_burn?
    hexagon.set_fire
    @visited_coordinates.append(coordinate)
    get_neighbors(coordinate).each do |neighbor_coordinate|
      hexagon = @hexagons[neighbor_coordinate.to_sym]
      if hexagon
        next if @visited_coordinates.include? neighbor_coordinate
        if hexagon.can_burn?
          hexagon.set_fire
          start_fire(neighbor_coordinate)
        end
      end
    end
  end

  def set_terrain(terrain)
    @hexagons = terrain
  end

  def get_random_coordinate
    "#{rand(0...@grid_size)},#{rand(0...@grid_size)}"
  end

  def get_random_terrain_type
    TerrainHexagon.new(TerrainType.const_get(TerrainType.constants.sample))
  end

  def build_terrain
    while @hexagons.keys.length < @grid_size * @grid_size do
      coordinate = get_random_coordinate.to_sym
      unless @hexagons.key?(coordinate)
        @hexagons[coordinate] = get_random_terrain_type
      end
    end
  end

  def transform_coordinate(coordinate, transform)
    [coordinate[0].to_i + transform[0], coordinate[1].to_i + transform[1]]
  end

  # input: '2,2'
  # output: ['2,3', '2,1', '3,2', '1,2']
  # returns an array of coordinate strings
  def get_neighbors(coordinate)
    directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    directions.map do |direction|
      transform_coordinate(coordinate.split(','), direction).join(',')
    end
  end

  def build_grid
    rows = []
    @grid_size.times { rows.append Array.new(@grid_size) }
    @hexagons.each do |coordinate, hexagon|
      coordinates = coordinate.to_s.split(',')
      rows[coordinates[1].to_i][coordinates[0].to_i] = hexagon.to_emoji
    end
    # Terminal::Table.new :rows => rows
    Terminal::Table.new do |v|
      v.style = { :border => :unicode_round }
      v.rows = rows
    end
  end
end

grid_size = 40
map = TerrainMap.new(grid_size)
map.build_terrain
map.start_fire(map.get_random_coordinate)
puts map.build_grid

class WildfireSimulationTest < Test::Unit::TestCase
  def test_get_on_fire_blocks
    map = TerrainMap.new(2)
    map.set_terrain({
      '0,0': TerrainHexagon.new(TerrainType::WATER),
      '0,1': TerrainHexagon.new(TerrainType::VEGETATION),
      '0,2': TerrainHexagon.new(TerrainType::WATER),
      '1,0': TerrainHexagon.new(TerrainType::WATER),
      '1,1': TerrainHexagon.new(TerrainType::VEGETATION),
      '1,2': TerrainHexagon.new(TerrainType::VEGETATION),
      '2,0': TerrainHexagon.new(TerrainType::ROCKS),
      '2,1': TerrainHexagon.new(TerrainType::ROCKS),
      '2,2': TerrainHexagon.new(TerrainType::ROCKS),
    })
    map.start_fire('1,1')
    assert_equal map.get_on_fire_blocks.keys, [:'0,1', :'1,1', :'1,2']
  end
end
