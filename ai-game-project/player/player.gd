extends CharacterBody2D

@export var grid_size: int = 8  # Movement step size
var is_moving = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D  # Reference to CollisionShape2D

func _process(delta):
	if not is_moving:
		var direction = Vector2.ZERO

		# Check for input and set direction
		if Input.is_action_just_pressed("ui_right"):
			direction.x += 1
		elif Input.is_action_just_pressed("ui_left"):
			direction.x -= 1
		elif Input.is_action_just_pressed("ui_down"):
			direction.y += 1
		elif Input.is_action_just_pressed("ui_up"):
			direction.y -= 1

		# Move the sprite if a direction is set
		if direction != Vector2.ZERO:
			move_sprite(direction)

func move_sprite(direction: Vector2):
	is_moving = true

	# Calculate the target position
	var target_position = position + direction * grid_size

	# Perform a collision check using the CollisionShape2D
	var motion = direction * grid_size
	var collision = move_and_collide(motion)

	if collision:
		is_moving = false  # Stop movement if there's a collision
		return

	# Move the sprite
	position = target_position

	# Play the animation
	animated_sprite.play("move")  # Replace "move" with your animation name

	# Mark as no longer moving after a short delay
	await get_tree().create_timer(0.1).timeout
	is_moving = false
