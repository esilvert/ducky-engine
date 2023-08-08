# Feel free to change
class NODE_NAME < Ducky::Node2D
  def initialize(position: Vector2.zero, name: "NODE_NAME##{hash}")
    super

    # Add your custom initialization code here
  end

  def update(args)
    # Add your custom update code here
    # queue_free! if should_die?
  end
end
