extends CharacterBody2D

@export var speed := 50
var direction := Vector2.ZERO

var enemy_scene = preload("res://Enemy.tscn")

func _ready():
	var enemy = enemy_scene.instantiate()
	enemy.global_position = Vector2(400, 200)
	add_child(enemy)

func _physics_process(delta):
	# 简单追踪玩家
	var player = get_tree().get_root().get_node("Main/Player")  # 路径根据你的实际结构调整
	if player:
		direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
