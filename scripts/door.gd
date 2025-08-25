extends Area2D

@export var target_scene : PackedScene
@onready var door_label: Label = $"../door_label"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _input(event):
	pass

func next_level():
	var ERR = get_tree().change_scene_to_packed(target_scene)
	
	if ERR != OK : 
		print("something failed in the door scene")


func _on_body_entered(body: Node2D) -> void:
	var number_of_keys = GameManager.score
	if number_of_keys >= 10 :
		if !target_scene : 
			print("no scene in this door")
			return
		if get_overlapping_bodies().size() > 0:
			next_level()
	else :
		door_label.visible = true
		door_label.text = "Not Enogh Keys, should be 7 and more"
		
