extends Node2D

class_name PlayerStateMachine

const HISTORY_LIMIT = 10

const INITIAL_GRAVITY = 10
const FRICTION = 1
const MOVE_SPEED = 100
const AIR_MOVE_SPEED = 80
const AIR_RESISTANCE = 0.75
const AIR_SPEED_SLOW_BY = 0.005

export(NodePath) var animationPlayerPath
export(NodePath) var spritePath

var state
var isOnFloor = false
var isOnCeiling = false
var velocity = Vector2.ZERO
var gravity

var history = []

var anim
var sprite


func ready():
	gravity = INITIAL_GRAVITY
	
	if animationPlayerPath:
		anim = get_node(animationPlayerPath)
		
	if spritePath:
		sprite = get_node(spritePath)
	
	if anim:
		anim.connect("animation_finished", self, "_on_FSM_Anim_animation_finished")
	
	state = get_child(0)
	state.fsm = self
	state.enter_state()
	
	
func change_state(newStateName):
	update_history(newStateName)
	state.exit_state()
	state = get_node(newStateName)
	state.fsm = self
	state.enter_state()
	
	
func update_history(stateName):
	if history.size() > HISTORY_LIMIT:
		history.pop_front()
		
	history.append(state.name)
	
	
func enter_state():
	pass
	
	
func process(delta):
	pass
	
	
func physics_process(delta):
	pass
	
	
func input(event):
	pass
	
	
func animation_finished(anim_name):
	pass
	
	
func exit_state():
	pass
	
	
func _on_FSM_Anim_animation_finished(anim_name):
	state.animation_finished(anim_name)