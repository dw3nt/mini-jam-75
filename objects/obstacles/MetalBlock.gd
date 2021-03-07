extends RigidBody2D

const IMPULSE_FORCE = 500
const DAMP_FORCE = 5
const MAX_CHARGES = 3

export(int) var initialFloatCharges = 0

var floatCharges = 0 setget setFloatCharges

onready var floatAudio = $FloatAudio
onready var resetAudio = $ResetAudio


func _ready():
	if initialFloatCharges > 0:
		gravity_scale = 0
		floatCharges = initialFloatCharges
		
		
func setFloatCharges(val):
	floatCharges = min(val, MAX_CHARGES)
	if val <= MAX_CHARGES:
		gravity_scale = 0
		linear_damp = DAMP_FORCE / floatCharges
		apply_central_impulse(Vector2.UP * IMPULSE_FORCE * floatCharges)
		floatAudio.play()
	
	
func addFloatCharge():
	self.floatCharges += 1
	
	
func resetGravity():
	if floatCharges > 0:
		floatCharges = 0	# don't want to trigger setter
		gravity_scale = 1.5
		linear_damp = -1
		apply_central_impulse(Vector2.DOWN * 5)	# re apply an impulse to retrigger gravity changes
		resetAudio.play()
