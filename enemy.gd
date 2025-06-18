extends CharacterBody2D

@export var speed := 80
var player: Node2D = null

func _physics_process(delta):
	if player == null:
		return

	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
