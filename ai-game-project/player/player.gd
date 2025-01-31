extends CharacterBody2D

# Movement speed (16 pixels per step)
var grid_size = 8

# Track whether the sprite is currently moving
var is_moving = false

# Reference to the AnimatedSprite2D node
@onready var animated_sprite = $AnimatedSprite2D

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
	# Mark the sprite as moving
	is_moving = true

	# Calculate the target position
	var target_position = position + direction * grid_size

	# Move the sprite to the target position
	position = target_position

	# Play the animation
	animated_sprite.play("move")  # Replace "move" with the name of your animation

	# Mark the sprite as no longer moving
	is_moving = false
