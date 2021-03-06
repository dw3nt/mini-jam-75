extends KinematicBody2D

const INERTIA = 10

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
	stateMachine.state.input(event)
