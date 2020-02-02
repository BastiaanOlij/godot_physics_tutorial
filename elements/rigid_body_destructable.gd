extends "res://misc/rigid_body_velocity.gd"

signal scored(add_score, at)

export (PackedScene) var destructed_scene = null
export var half_damage_threshold = 1.0
export var full_damage_threshold = 5.0
export var score = 50.0

var total_damage = 0.0

var damage_threshold = 0.5
var damage_factor = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	if body.has_method("get_last_velocity"):
		var delta = last_velocity - body.get_last_velocity()
		var strength = delta.length()
		
		if strength > damage_threshold:
			var total_score = 0.0
			
			var was_damage = total_damage
			total_damage = total_damage + (strength - damage_threshold) * damage_factor
			
			if was_damage < half_damage_threshold and total_damage >= half_damage_threshold:
				total_score = total_score + score
			
			if total_damage > full_damage_threshold:
				total_score = total_score + score
				
				# we'll replace our scene with a destructed scene
				if destructed_scene:
					var new_scene = destructed_scene.instance()
					get_parent().add_child(new_scene)
					new_scene.global_transform = global_transform
					new_scene.copy_velocity(linear_velocity)
				
				# remove our current scene
				$CollisionShape.disabled = true
				queue_free()
			
			if total_score > 0:
				emit_signal("scored", total_score, global_transform.origin)
