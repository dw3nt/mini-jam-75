extends Node2D

signal room_ready
signal room_change_requested

const CURSOR_AIMER = preload("res://assets/images/aimer.png")
const BULLET_SCENE = preload("res://objects/items/Bullet.tscn")

var currentLevel = null

onready var goalAudio = $LevelGoalAudio
onready var floatBulletAudio = $FloatBulletAudio
onready var resetFloatBulletAudio = $ResetFloatBulletAudio
onready var resetLevelAudio = $ResetLevelAudio
onready var levelWrap = $Level
onready var bulletsWrap = $Bullets
onready var ammoLabel = $CanvasLayer/GameInterface/MarginContainer/HBoxContainer/Ammo
onready var player = $Player
onready var levelGoal = $LevelGoal


func _ready():
	Input.set_custom_mouse_cursor(CURSOR_AIMER, 0, Vector2(5,5))
	currentLevel = levelWrap.get_child(0)
	var currentLevelScene = load(currentLevel.filename).instance()
	initLevel(currentLevelScene)
	
	player.connect("bullet_fired", self, "_on_Player_bullet_fired")
	
	emit_signal("room_ready")
	
	
func _exit_tree():
	Input.set_custom_mouse_cursor(null)
	
	
func initLevel(newLevel):
	var oldLevel = currentLevel
	levelWrap.remove_child(oldLevel)
	levelWrap.add_child(newLevel)
	currentLevel = newLevel
	oldLevel.queue_free()
	
	player.global_position = currentLevel.playerSpawnPos.position
	levelGoal.global_position = currentLevel.goalSpawnPos.position
	ammoLabel.text = str(currentLevel.floatAmmo)
	
	for bullet in bulletsWrap.get_children():
		bullet.queue_free()
	
	
func _input(event):
	if event.is_action_pressed("reset_level"):
		var currentLevelScene = load(currentLevel.filename).instance()
		initLevel(currentLevelScene)
		resetLevelAudio.play()
	
	
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
			resetFloatBulletAudio.play()
		else:
			currentLevel.floatAmmo -= 1
			ammoLabel.text = str(currentLevel.floatAmmo)
			floatBulletAudio.play()


func _on_LevelGoal_body_entered(body):
	goalAudio.play()
	if currentLevel.nextLevelScene:
		initLevel(currentLevel.nextLevelScene.instance())
