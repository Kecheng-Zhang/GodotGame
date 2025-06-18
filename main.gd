extends Node2D

@export var enemy_scene: PackedScene
@onready var player = $Player

func _ready():
	spawn_enemy()

func spawn_enemy():
	if enemy_scene == null:
		print("No enemy scene assigned")
		return

	var enemy = enemy_scene.instantiate()
	enemy.global_position = Vector2(100, 100)
	enemy.player = player
	add_child(enemy)
