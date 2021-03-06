extends PlayerStateMachine

var fsm


func ready():
	pass
	
	
func enter_state():
	fsm.anim.play("Jump")
	
	
func physics_process(delta):
	var runInput = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if fsm.isOnFloor && runInput != 0:
		fsm.change_state("Move")
	elif fsm.isOnFloor && runInput == 0:
		fsm.change_state("Idle")
	elif !fsm.isOnFloor:
		if runInput != 0:
			if abs(fsm.velocity.x) > AIR_MOVE_SPEED:
				fsm.velocity.x = lerp(fsm.velocity.x, AIR_MOVE_SPEED, AIR_SPEED_SLOW_BY)
			else:
				fsm.velocity.x = runInput * AIR_MOVE_SPEED
				
			fsm.setFacingDirection(runInput)
			
		else:
			fsm.velocity.x = lerp(fsm.velocity.x, 0, AIR_RESISTANCE)
			
		fsm.velocity.y += fsm.gravity
		
	else:
		print('you forgot something')
	
	
func exit_state():
	pass
