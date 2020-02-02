extends Spatial

export (PackedScene) var cannon_ball=null

var can_shoot = true

var mouse_is_down = false
var down_position = Vector2(0.0, 0.0)
var shoot_strength = 0.2

func rotate_cannon(mouse_position):
	var mouse_delta = mouse_position - down_position
	var direction = Vector3(0.0, mouse_delta.y, mouse_delta.x)
	$CSGSphere.look_at($CSGSphere.global_transform.origin + direction, Vector3(0.0, 1.0, 0.0))
	$Aim.get_surface_material(0).set_shader_param("velocity", direction * shoot_strength)

# Handle our mouse event
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed and can_shoot:
				# user pressed the mouse
				down_position = event.position
				mouse_is_down = true
				$Aim.visible = true
			elif mouse_is_down:
				# user released the mouse
				mouse_is_down = false
				$Aim.visible = false
				
				# also rotate our cannon here
				rotate_cannon(event.position)
				
				# shoot!
				var new_cannon_ball = cannon_ball.instance()
				$CannonBalls.add_child(new_cannon_ball)
				new_cannon_ball.global_transform.origin = $CSGSphere/CannonBallSpawnPoint.global_transform.origin
				
				var mouse_delta = event.position - down_position
				new_cannon_ball.linear_velocity = Vector3(0.0, mouse_delta.y, mouse_delta.x) * shoot_strength
				
				# put our shooting on a cooldown
				can_shoot = false
				$Cooldown.start()
	elif event is InputEventMouseMotion:
		# user moved the mouse
		if mouse_is_down:
			rotate_cannon(event.position)
			
			# make sure our aim is always positioned correctly
			$Aim.global_transform.origin = $CSGSphere/CannonBallSpawnPoint.global_transform.origin


# Called when the node enters the scene tree for the first time.
func _ready():
	$Aim.visible = false

func _on_Cooldown_timeout():
	can_shoot = true
