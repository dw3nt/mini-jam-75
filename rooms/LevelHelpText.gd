extends Control

export(String, MULTILINE) var helpText = "Help text"

onready var helpLabel = $MarginContainer/Label


func _ready():
	helpLabel.text = helpText
