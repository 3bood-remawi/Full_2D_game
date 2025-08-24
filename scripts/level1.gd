extends Node2D

@onready var key: Area2D = $Keys/key1
@onready var panel = $AIPart/QuestionPanel
@onready var question_label = $AIPart/QuestionPanel/VBoxContainer/QuestionLabel
@onready var answer_input = $AIPart/QuestionPanel/VBoxContainer/AnswerInput
@onready var check_button = $AIPart/QuestionPanel/VBoxContainer/CheckButton
@onready var score_label = $AIPart/QuestionPanel/VBoxContainer/ScoreLabel
@onready var chat = $AIPart/NobodyWhoChat
var current_question = ""
var current_answer = ""
var key_collected = false
var score = 0

func _ready():
	panel.visible = false
	score_label.text = "Score: " + str(score)
	key.body_entered.connect(_on_key_collected)
	check_button.pressed.connect(_on_check_pressed)
	chat.response_finished.connect(_on_nobody_who_chat_response_finished)
func _on_key_collected(body):
	if key_collected:
		return
	if body.name == "Player":
		key_collected = true
		key.queue_free()  # اخفاء المفتاح
		panel.visible = true
		question_label.text = "AI is thinking..."
		_request_ai_question()

func _request_ai_question():
	var prompt = """
Give me a simple math question with 3 multiple choice answers.
Format it like this:
Question: <the question>
1) <option1>
2) <option2>
3) <option3>
Correct: <number of correct option>
"""
	chat.say(prompt)
func _on_check_pressed():
	var player_answer = answer_input.text
	if current_answer == "":
		question_label.text = "[AI is still preparing the question...]"
		return
	if player_answer == current_answer:
		question_label.text = "Good !"
		score += 1
		score_label.text = "Score: " + str(score)
	else:
		question_label.text = "Wrong !"
	await get_tree().create_timer(2.0).timeout
	panel.visible = false
	answer_input.text = ""
func _on_nobody_who_chat_response_finished(response: String) -> void:
	current_question = ""
	current_answer = ""
	var lines = response.split("\n")
	for line in lines:
		if line.begins_with("Question:"):
			var parts = line.split(":", false)
			current_question = parts[1].strip() if parts.size() >= 2 else parts[0].strip()
		elif line.begins_with("1)") or line.begins_with("2)") or line.begins_with("3)"):
			current_question += "\n" + line
		elif line.begins_with("Correct:"):
			var parts = line.split(":", false)
			current_answer = parts[1].strip() if parts.size() >= 2 else parts[0].strip()
	if current_question.length() > 1000:
		current_question = current_question.substr(0, 1000) + "..."
	question_label.text = current_question
	answer_input.text = ""
