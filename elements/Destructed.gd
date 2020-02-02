extends Spatial

func copy_velocity(velocity):
	for block in get_children():
		block.linear_velocity = velocity
