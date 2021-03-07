extends KinematicBody2D

signal bullet_fired(target, isResetCharge)

const INERTIA = 10
const MAX_FLOAT_CHARGES = 3
const FLOAT_CHARGE_AMOUNT = 3

var floatCharges = 0

onready var bulletSpawnPost = $GravityGun/BulletSpawnPoint
onready var sprite = $Sprite
onready var stateMachine = $PlayerStateMachine


func _ready():
	stateMachine.ready()
	
	
func _physics_process(delta):
	stateMachine.state.physics_process(delta)
	move_and_slide(stateMachine.velocity, Vector2.UP, false, 4, PI / 4, false)
	
	stateMachine.isOnFloor = is_on_floor()
	stateMachine.isOnCeiling = is_on_ceiling()
	if stateMachine.isOnFloor:
		stateMachine.velocity.y = stateMachine.gravity
		
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group('moveable_obstacle'):
			if collision.normal.round() == Vector2.DOWN:
				if stateMachine.state.name != "Dead":
					stateMachine.change_state("Dead")
			else:
				collision.collider.apply_central_impulse(-collision.normal * INERTIA)
				if collision.normal == Vector2.UP:
					collision.collider.resetGravity()
	
	
func _input(event):
	if event.is_action_pressed("shoot_float_charge"):
		emit_signal("bullet_fired", get_global_mouse_position(), false)
	elif event.is_action_pressed("shoot_reset_charge"):
		emit_signal("bullet_fired", get_global_mouse_position(), true)
	else:
		stateMachine.state.input(event)
		
		
func addFloatCharge():
	var val = floatCharges + 1
	floatCharges = min (MAX_FLOAT_CHARGES, val)
	if val <= MAX_FLOAT_CHARGES:
		stateMachine.gravity -= FLOAT_CHARGE_AMOUNT
		
		
func resetGravity():
	stateMachine.resetGravity()
