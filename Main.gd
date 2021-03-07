extends Node

const MIN_VOL_DB = -30.0
const MAX_VOL_DB = 0.0
const MUSIC_FADE_DURATION = 1.0

const ROOM_SIGNALS = {
	"room_ready": "_on_CurrentRoom_room_ready",
	"room_change_requested": "_on_CurrentRoom_room_change_requested"
}

const USER_SIGNALS = {
	"music_change_requested": "_on_CurrentRoom_music_change_requested"
}

onready var animation = $AnimationPlayer

onready var audioStream1 = $MusicManager/AudioStream1
onready var audioStream2 = $MusicManager/AudioStream2
onready var musicTween = $MusicManager/Tween

onready var roomWrap = $Room

var currentRoom
var currentMusicPath
var currentMusic
var nextMusic


func _ready():
	currentRoom = roomWrap.get_child(0)
	currentMusic = audioStream1
	nextMusic = audioStream2
	
	attachSignals(currentRoom)
	

func initRoom():
	attachSignals(currentRoom)
	roomWrap.add_child(currentRoom)
	
	
func attachSignals(room):
	for signalName in ROOM_SIGNALS.keys():
		if !room.is_connected(signalName, self, ROOM_SIGNALS[signalName]):
			room.connect(signalName, self, ROOM_SIGNALS[signalName])
		
	for signalName in USER_SIGNALS.keys():
		if room.has_user_signal(signalName):
			if !room.is_connected(signalName, self, USER_SIGNALS[signalName]):
				room.connect(signalName, self, USER_SIGNALS[signalName])


func _on_CurrentRoom_room_ready():
	animation.play("black_fade_out")
	
	
func _on_CurrentRoom_room_change_requested(scene):
	animation.play("black_fade_in")
	yield(animation, "animation_finished")
	
	roomWrap.remove_child(currentRoom)
	currentRoom.queue_free()
	currentRoom = null
	
	var inst = load(scene).instance()
	attachSignals(inst)
	currentRoom = inst
	
	call_deferred("initRoom")

	
func _on_CurrentRoom_music_change_requested(music):
	if music != currentMusicPath:
		currentMusicPath = music
		
		nextMusic.stream = load(music)
		nextMusic.play()
		
		musicTween.interpolate_property(currentMusic, "volume_db",
			currentMusic.volume_db, MIN_VOL_DB, MUSIC_FADE_DURATION
		)
			
		musicTween.interpolate_property(nextMusic, "volume_db",
			nextMusic.volume_db, MAX_VOL_DB, MUSIC_FADE_DURATION
		)
		
		musicTween.start()
	

func _on_Tween_tween_all_completed():
	currentMusic.stop()
	
	var temp = currentMusic
	currentMusic = nextMusic
	nextMusic = temp
