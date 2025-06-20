extends Node2D

@export var target_dummy_scene: PackedScene  # 在 Inspector 拖入 TargetDummy.tscn

func _ready():
	spawn_target_dummy(Vector2(100, 0))

func spawn_target_dummy(spawn_position: Vector2):
	var dummy = target_dummy_scene.instantiate()
	dummy.global_position = spawn_position
	add_child(dummy)
