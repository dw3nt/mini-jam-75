extends PlayerStateMachine

var fsm


func ready():
	pass
	
	
func enter_state():
	fsm.anim.play("Idle")
	
	
func physics_process(delta):
	var runInput = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if !fsm.isOnFloor:
		fsm.change_state("Fall")
	elif runInput != 0:
		fsm.change_state("Move")
	elif Input.is_action_just_pressed("jump"):
		fsm.change_state("Jump")
	else:
		fsm.velocity.x = lerp(fsm.velocity.x, 0, FRICTION)
		
		
func exit_state():
	pass
