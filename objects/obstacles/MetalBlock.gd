extends RigidBody2D

const IMPULSE_FORCE = 500
const DAMP_FORCE = 5

var floatCharges = 0 setget setFloatCharges
		
		
func setFloatCharges(val):
	floatCharges = val
	gravity_scale = 0
	linear_damp = DAMP_FORCE / val
	apply_central_impulse(Vector2.UP * IMPULSE_FORCE * val)
	
	
func addFloatCharge():
	self.floatCharges += 1
	
	
func resetGravity():
	if floatCharges > 0:
		floatCharges = 0	# don't want to trigger setter
		gravity_scale = 1.5
		linear_damp = -1
		apply_central_impulse(Vector2.DOWN * 5)	# re apply an impulse to retrigger gravity changes
