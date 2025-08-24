extends Node2D
const LEVEL_1 = preload("res://scenes/Levels/Level1.tscn")
var pause_menu = preload("res://scenes/pause_menu.tscn")
var MEAN_MENU = preload("res://scenes/mean_menu.tscn")

func start_game():
	transition_to_scene(LEVEL_1.resource_path)
 
func exit_game():
	get_tree().quit()

func pause_game():
	get_tree().paused = true
	
	var pause_menu_instance =pause_menu.instantiate() 
	get_tree().get_root().add_child(pause_menu_instance)

func transition_to_scene (scene_path):
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(scene_path)

func continue_game():
	get_tree().paused = false
	
func main_menu():
	var MEAN_MENU_instance = MEAN_MENU.instantiate() 
	get_tree().get_root().add_child(MEAN_MENU_instance)
