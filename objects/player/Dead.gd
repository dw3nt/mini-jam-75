extends PlayerStateMachine

const KNOCK_UP_FORCE = -250
const KNOCK_BACK_FORCE = 40

var fsm
var facing = 0

onready var audio = $AudioStreamPlayer


func ready():
	pass
	
	
func enter_state():
	fsm.anim.play("Dead")
	audio.play()
	
	if fsm.sprite.flip_h:
		facing = 1
	else:
		facing = -1
		
	yield(get_tree().create_timer(0.1), "timeout")
		
	fsm.velocity.y = KNOCK_UP_FORCE
	fsm.velocity.x = KNOCK_BACK_FORCE * facing
	
	
func physics_process(delta):
	fsm.velocity.y += INITIAL_GRAVITY

	
func exit_state():
	pass
