extends Node2D
const LEVEL_1 = preload("res://scenes/Level1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game():
	transition_to_scene(LEVEL_1.resource_path)
 
func exit_game():
	get_tree().quit()

func transition_to_scene (scene_path):
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(scene_path)
