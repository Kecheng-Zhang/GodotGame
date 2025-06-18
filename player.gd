extends CharacterBody2D

@export var speed := 200
@export var dash_distance := 100

var direction := Vector2.ZERO

func _physics_process(delta):
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()

	# Dash 逻辑：按下空格就瞬移
	if Input.is_action_just_pressed("dash") and direction != Vector2.ZERO:
		global_position += direction * dash_distance
