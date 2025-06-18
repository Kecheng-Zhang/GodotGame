extends Area2D

@export var speed := 400
@export var lifetime := 4.0
var direction := Vector2.ZERO

func _ready():
	# 延时销毁
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _process(delta):
	position += direction * speed * delta
