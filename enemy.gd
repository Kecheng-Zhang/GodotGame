extends CharacterBody2D  # 或 Area2D

@export var max_health := 100
var current_health = max_health

func take_damage(amount):
	current_health -= amount
	print("Enemy took ", amount, " damage! Remaining: ", current_health)
	if current_health <= 0:
		die()

func die():
	queue_free()  # 删除节点
