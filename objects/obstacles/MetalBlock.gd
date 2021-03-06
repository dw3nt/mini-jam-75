extends RigidBody2D

const IMPULSE_FORCE = 50
const DAMP_FORCE = 5

var floatCharges = 0 setget setFloatCharges


func _input(event):
	if event.is_action_pressed("ui_accept"):
		self.floatCharges += 1
	elif event.is_action_pressed("ui_cancel"):
		resetGravity()
		
		
func setFloatCharges(val):
	floatCharges = val
	gravity_scale = 0
	linear_damp = DAMP_FORCE / val
	apply_central_impulse(Vector2.UP * IMPULSE_FORCE * val)
	
	
func resetGravity():
	floatCharges = 0	# don't want to trigger setter
	gravity_scale = 1.5
	linear_damp = -1
