extends CharacterBody2D

@export var speed := 100
@export var dash_distance := 100
@export var bullet_scene: PackedScene
@export var max_health := 100

var current_health := max_health
var direction := Vector2.ZERO
var facing_direction := Vector2.RIGHT
@onready var health_bar = $HealthBar


func _ready():
	update_health_bar()

func _physics_process(_delta):
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
	
	if Input.is_action_just_pressed("hurt"):
		take_damage(10)
		
	if Input.is_action_just_pressed("heal"):
		take_damage(-10)

func shoot_bullet():
	if bullet_scene == null:
		return

	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = facing_direction  # 发射方向由鼠标决定
	get_parent().add_child(bullet)

func update_health_bar():
	if health_bar:
		var fg = health_bar.get_node("Foreground")
		var ratio = float(current_health) / max_health
		fg.scale.x = clamp(ratio, 0.0, 1.0)
		
func take_damage(amount: int):
	current_health -= amount
	current_health = clamp(current_health, 0, max_health)
	update_health_bar()

	if current_health <= 0:
		die()
		
func die():
	queue_free()
