extends Control

signal room_ready
signal room_change_requested

const GAME_SCENE = "res://rooms/Game.tscn"
const CREDITS_SCENE = "res://menus/CreditsMenu.tscn"


func _ready():
	emit_signal('room_ready')


func _on_PlayButton_pressed():
	emit_signal("room_change_requested", GAME_SCENE)


func _on_CreditButton_pressed():
	emit_signal("room_change_requested", CREDITS_SCENE)


func _on_QuitButton_pressed():
	get_tree().quit()
