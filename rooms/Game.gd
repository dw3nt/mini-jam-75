extends Node2D

signal room_ready
signal room_change_requested

const BULLET_SCENE = preload("res://objects/items/Bullet.tscn")

var currentLevel = null

onready var levelWrap = $Level
onready var bulletsWrap = $Bullets
onready var player = $Player
onready var levelGoal = $LevelGoal
onready var ammoLabel = $CanvasLayer/GameInterface/MarginContainer/HBoxContainer/Ammo


func _ready():
	currentLevel = levelWrap.get_child(0)
	var currentLevelScene = load(currentLevel.filename).instance()
	initLevel(currentLevelScene)
	
	player.connect("bullet_fired", self, "_on_Player_bullet_fired")
	
	emit_signal("room_ready")
	
	
func initLevel(newLevel):
	var oldLevel = currentLevel
	levelWrap.remove_child(oldLevel)
	levelWrap.add_child(newLevel)
	currentLevel = newLevel
	oldLevel.queue_free()
	
	player.global_position = currentLevel.playerSpawnPos.position
	levelGoal.global_position = currentLevel.goalSpawnPos.position
	ammoLabel.text = str(currentLevel.floatAmmo)
	
	
func _input(event):
	if event.is_action_pressed("reset_level"):
		var currentLevelScene = load(currentLevel.filename).instance()
		initLevel(currentLevelScene)
	
	
func _on_Player_bullet_fired(target, isResetCharge):
	if !isResetCharge && currentLevel.floatAmmo <= 0:
		return null
	
	if (target.x < player.global_position.x && player.sprite.flip_h) || (target.x > player.global_position.x && !player.sprite.flip_h):
		var inst = BULLET_SCENE.instance()
		inst.global_position = player.bulletSpawnPost.global_position
		inst.dir = target
		bulletsWrap.add_child(inst)
		
		if isResetCharge:
			inst.setAsReset()
		else:
			currentLevel.floatAmmo -= 1
			ammoLabel.text = str(currentLevel.floatAmmo)


func _on_LevelGoal_body_entered(body):
	if currentLevel.nextLevelScene:
		initLevel(currentLevel.nextLevelScene.instance())
