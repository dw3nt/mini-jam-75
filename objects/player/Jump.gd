extends PlayerStateMachine

const JUMP_FORCE = -200

var fsm

onready var audio = $AudioStreamPlayer


func ready():
	pass
	
	
func enter_state():
	fsm.velocity.y = JUMP_FORCE
	fsm.anim.play("Jump")
	audio.play()


func physics_process(delta):
	var runInput = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	fsm.velocity.y += fsm.gravity
	
	if fsm.isOnFloor && runInput != 0:
		fsm.change_state("Move")
	elif fsm.isOnFloor && runInput == 0:
		fsm.change_state("Idle")
	elif fsm.velocity.y >= 0 || fsm.isOnCeiling:
		fsm.change_state("Fall")
	else:
		if runInput != 0:
			if abs(fsm.velocity.x) > AIR_MOVE_SPEED:
				fsm.velocity.x = lerp(fsm.velocity.x, AIR_MOVE_SPEED, AIR_SPEED_SLOW_BY)
			else:
				fsm.velocity.x = runInput * AIR_MOVE_SPEED
				
			fsm.setFacingDirection(runInput)
			
		else:
			fsm.velocity.x = lerp(fsm.velocity.x, 0, AIR_RESISTANCE)
	
	
func exit_state():
	pass
