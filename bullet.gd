extends Area2D

@export var speed := 400
@export var lifetime := 4.0
@export var damage := 10  # 伤害值

var direction := Vector2.ZERO

func _ready():
	# 延时销毁
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
