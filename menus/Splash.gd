extends Control

signal room_ready
signal room_change_requested

const MAIN_MENU_SCENE = "res://menus/MainMenu.tscn"


func _ready():
	emit_signal('room_ready')
	yield(get_tree().create_timer(1.0), "timeout")
	emit_signal("room_change_requested", MAIN_MENU_SCENE)
