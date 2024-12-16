module IntegerContainerInterface
  # Should add the specified integer `value` to the container
  # and return the number of integers in the container after the
  # addition.
  #
  # @param {number} value
  # @returns {number}
  def add(value)
    # default implementation
    return 0
  end

  # Should attempt to remove the specified integer `value` from
  # the container.
  # If the `value` is present in the container, remove it and
  # return `true`, otherwise, return `false`.
  #
  # @param {number} value
  # @returns {boolean}
  def delete(value)
    # default implementation
    return false
  end

  # Should return the median integer - the integer in the middle
  # of the sequence after all integers stored in the container
  # are sorted in ascending order.
  # If the length of the sequence is even, the leftmost integer
  # from the two middle integers should be returned.
  # If the container is empty, this method should return `nil`.
  #
  # @returns {number | nil}
  def get_median()
    # default implementation
    return nil
  end
end
