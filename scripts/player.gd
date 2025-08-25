extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var can_move := true

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

var last_safe_position : Vector2
var player_velocity : Vector2
var last_safe_platform : Node2D = null 

@export var climb_speed: float = 110.0
@export var climb_horizontal_factor: float = 0.5
@onready var ladder_tilemap: TileMapLayer = $"../tileMaps/Ladders"
var on_ladder: bool = false


func _physics_process(delta: float) -> void:
	
	# climping ladders
	var dir := Input.get_axis("ui_left", "ui_right")
	var up := Input.is_action_pressed("ui_up")
	var down := Input.is_action_pressed("ui_down")

	var in_ladder := is_in_ladder()

	if in_ladder and (up or down):
		on_ladder = true
	elif not in_ladder:
		on_ladder = false

	if on_ladder:
		velocity.y = 0.0
		if up:
			velocity.y = -climb_speed
		elif down:
			velocity.y = climb_speed

		velocity.x = dir * SPEED * climb_horizontal_factor

		if Input.is_action_just_pressed("ui_accept"):
			on_ladder = false
			velocity.y = JUMP_VELOCITY

		_play_climb_anim(up or down)

		if dir > 0.0:
			animated_sprite.flip_h = false
		elif dir < 0.0:
			animated_sprite.flip_h = true

		move_and_slide()
		return
	# defult movment
	if not can_move:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		player_velocity = get_gravity() * delta /5
		last_safe_position = Vector2(position.x,position.y-200)
		
		
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

func enable_player():
	can_move = true
	animated_sprite.play("walk")
	velocity += get_gravity() * 0.001
	
func is_in_ladder() -> bool:
	if ladder_tilemap == null:
		return false

	var sample_offsets := [Vector2.ZERO, Vector2(-6, 0), Vector2(6, 0)]
	for off in sample_offsets:
		var lp := ladder_tilemap.to_local(global_position + off)
		var cell: Vector2i = ladder_tilemap.local_to_map(lp)
		var td := ladder_tilemap.get_cell_tile_data(cell)  # <-- بدون رقم طبقة
		if td and td.get_custom_data("ladder") == true:
			return true
	return false


func _safe_play(anim: String) -> void:
	if animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation(anim):
		if animated_sprite.animation != anim:
			animated_sprite.play(anim)


func _play_climb_anim(moving: bool) -> void:
	if moving and animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("climb"):
		_safe_play("climb")
	elif animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("climb_idle"):
		_safe_play("climb_idle")
	else:
		_safe_play("idle")


func _on_pause_texture_button_pressed() -> void:
	GameManager.pause_game()
