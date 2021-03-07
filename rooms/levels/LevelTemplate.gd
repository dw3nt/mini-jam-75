extends Node2D

export(int) var floatAmmo = 3
export(PackedScene) var nextLevelScene = null

onready var playerSpawnPos = $PlayerSpawn
onready var goalSpawnPos = $GoalSpawn
