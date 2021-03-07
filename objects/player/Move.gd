extends PlayerStateMachine

var fsm

onready var audio = $AudioStreamPlayer


func ready():
	pass
	

func enter_state():
	fsm.anim.play("Move")
	audio.play()
	
	
func physics_process(delta):
	var runInput = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if !fsm.isOnFloor:
		fsm.change_state("Fall")
	elif Input.is_action_just_pressed("jump"):
		fsm.change_state("Jump")
	elif fsm.isOnFloor && runInput == 0:
		fsm.change_state("Idle")
	else:
		fsm.velocity.x = runInput * MOVE_SPEED
		fsm.setFacingDirection(runInput)
	
	
func exit_state():
	pass
