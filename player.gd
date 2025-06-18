extends CharacterBody2D

@export var speed := 100
@export var dash_distance := 100
@export var bullet_scene: PackedScene

var direction := Vector2.ZERO
var facing_direction := Vector2.RIGHT

func _physics_process(delta):
	# 读取方向
	direction = Input.get_vector("player_left", "player_right", "player_up", "player_down").normalized()
	
	# 移动
	velocity = direction * speed
	move_and_slide()
	
	# 鼠标朝向（每帧更新）
	facing_direction = (get_global_mouse_position() - global_position).normalized()
	
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
	bullet.global_position = global_position
	bullet.direction = facing_direction  # 发射方向由鼠标决定
	get_parent().add_child(bullet)
