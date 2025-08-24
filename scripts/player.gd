extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var can_move := true

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

var last_safe_position : Vector2
var last_safe_platform : Node2D = null 

func _physics_process(delta: float) -> void:
	
	if not can_move:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# to save the player position to respawn in it when he fall
		var collision = get_last_slide_collision()
		if collision:
			var collider = collision.get_collider()

			if collider.is_in_group("platforms"):
				# Save RELATIVE position to the moving platform
				last_safe_platform = collider
				last_safe_position = last_safe_platform.to_local(global_position)
			else:
				# Save GLOBAL position for static floor
				last_safe_platform = null
				last_safe_position = global_position

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	if direction < 0:
		animated_sprite.flip_h = true

	if is_on_floor() : 
		if direction == 0 :
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")
	else:
		animated_sprite.play("jump")
		
		
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func respawn():
	if last_safe_platform and is_instance_valid(last_safe_platform):
		# Convert back to global using stored relative position
		global_position = last_safe_platform.to_global(last_safe_position)
	else:
		global_position = last_safe_position

func disable_player():
	can_move = false
	animated_sprite.play("idle")
	velocity = Vector2.ZERO
