extends Area2D

#@onready var level_1: Node2D = $".."
var number_of_keys = 1
@export var target_scene : PackedScene
@onready var label: Label = $"../Label"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _input(event):
	pass

func next_level():
	var ERR = get_tree().change_scene_to_packed(target_scene)
	
	if ERR != OK : 
		print("something failed in the door scene")


func _on_body_entered(body: Node2D) -> void:
	if number_of_keys == 1: 		
		label.visible = true
		label.text = "Congrats You Solve It All"
		
		if !target_scene : 
			print("no scene in this door")
			return
		if get_overlapping_bodies().size() > 0:
			next_level()
	else :
		label.visible = true
		label.text = "Not Enogh Keys"
		
