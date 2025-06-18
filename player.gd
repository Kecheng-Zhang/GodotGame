extends CharacterBody2D

@export var speed := 200
@export var dash_distance := 100
@export var bullet_scene: PackedScene

var direction := Vector2.ZERO
var last_nonzero_direction := Vector2.RIGHT  # 默认方向向右

func _physics_process(delta):
	# 读取方向
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = direction.normalized()

	# 如果方向非零，保存为最近移动方向
	if direction != Vector2.ZERO:
		last_nonzero_direction = direction

	# 移动
	velocity = direction * speed
	move_and_slide()

	# Dash
	if Input.is_action_just_pressed("dash") and direction != Vector2.ZERO:
		global_position += direction * dash_distance

	# 手动射击（按下 shoot 键）
	if Input.is_action_just_pressed("shoot"):
		shoot_bullet()

func shoot_bullet():
	if bullet_scene == null:
		return

	var bullet = bullet_scene.instantiate()
	bullet.global_position = direction

	# 如果当前没有方向输入，就使用上次方向
	bullet.direction = direction if direction != Vector2.ZERO else last_nonzero_direction

	get_tree().current_scene.add_child(bullet)
