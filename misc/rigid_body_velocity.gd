extends RigidBody

var last_velocity = Vector3(0.0, 0.0, 0.0)
var last_position = Vector3(0.0, 0.0, 0.0)
var first = true

func get_last_velocity():
	return last_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if first:
		first = false
	else:
		last_velocity = (global_transform.origin - last_position) / delta
	
	last_position = global_transform.origin
