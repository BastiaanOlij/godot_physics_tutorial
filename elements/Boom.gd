extends RigidBody

var is_triggered = false
var impulse_strength = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Trigger_body_entered(hit_body):
	if hit_body == self:
		return
	
	if !is_triggered:
		is_triggered = true
		
		for body in $EffectRange.get_overlapping_bodies():
			if body == self:
				pass
			elif body is RigidBody:
				var delta = body.global_transform.origin - global_transform.origin
				body.apply_impulse(body.global_transform.origin, delta.normalized() * impulse_strength)
		
		# Hide our object and start our particle system
		$MeshInstance.visible = false
		$CollisionShape.disabled = true
		$Particles.emitting = true
		$Lifetime.start()

func _on_Lifetime_timeout():
	queue_free()
