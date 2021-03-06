extends KinematicBody2D

onready var stateMachine = $PlayerStateMachine


func _ready():
	stateMachine.ready()
	
	
func _physics_process(delta):
	stateMachine.state.physics_process(delta)
	move_and_slide(stateMachine.velocity, Vector2.UP)
	
	stateMachine.isOnFloor = is_on_floor()
	stateMachine.isOnCeiling = is_on_ceiling()
	if stateMachine.isOnFloor:
		stateMachine.velocity.y = stateMachine.gravity
	
	
func _input(event):
	stateMachine.state.input(event)
