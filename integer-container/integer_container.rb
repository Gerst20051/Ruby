require_relative 'integer_container_interface'

# [$]> rspec specs --color

class IntegerContainer
  include IntegerContainerInterface

  def initialize
    @integers = []
  end

  def add(value)
    @integers.append value
    @integers.length
  end

  def delete(value)
    first_matching_index = @integers.index(value)
    if first_matching_index
      @integers.delete_at(first_matching_index)
      return true
    end
    false
  end

  def get_median
    sorted_integers = @integers.sort
    center_index = @integers.length / 2
    return sorted_integers[center_index - 1] if @integers.length.even?
    sorted_integers[center_index]
  end
end
