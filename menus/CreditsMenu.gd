extends Control

signal room_ready
signal room_change_requested

const MAIN_MENU_SCENE = "res://menus/MainMenu.tscn"


func _ready():
	emit_signal('room_ready')


func _on_MenuButton_pressed():
	emit_signal('room_change_requested', MAIN_MENU_SCENE)


func _on_ArtNameLink_pressed():
	OS.shell_open("https://kenney.nl/assets/platformer-art-pixel-redux")


func _on_ArtNameLink2_pressed():
	OS.shell_open("https://kenney.nl/assets/platformer-art-pixel-redux")


func _on_ArtistLink_pressed():
	OS.shell_open("https://kenney.nl/")


func _on_LicenseLink_pressed():
	OS.shell_open("https://creativecommons.org/publicdomain/zero/1.0/")


func _on_SongNameLink_pressed():
	OS.shell_open("https://freemusicarchive.org/music/jim-hall/synth-kid-elsewhere/wanderlust")


func _on_MusicArtistLink_pressed():
	OS.shell_open("https://freemusicarchive.org/music/jim-hall")


func _on_MusicLicenseLink_pressed():
	OS.shell_open("https://creativecommons.org/licenses/by/4.0/")


func _on_FontNameLink_pressed():
	OS.shell_open("https://www.dafont.com/biting-my-nails.font")


func _on_FontArtistLink_pressed():
	OS.shell_open("https://typodermicfonts.com/")


func _on_FontLicenseLink_pressed():
	OS.shell_open("https://creativecommons.org/publicdomain/zero/1.0/")
