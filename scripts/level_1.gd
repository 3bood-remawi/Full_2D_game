extends Node2D

@onready var keys_container := $Keys
@onready var panel = $AIPart/QuestionPanel
@onready var question_label = $AIPart/QuestionPanel/VBoxContainer/QuestionLabel
@onready var answer_input = $AIPart/QuestionPanel/VBoxContainer/AnswerInput
@onready var check_button = $AIPart/QuestionPanel/VBoxContainer/CheckButton
@onready var score_label = $AIPart/QuestionPanel/VBoxContainer/ScoreLabel
@onready var chat = $AIPart/NobodyWhoChat

var current_question = ""
var current_answer = ""
@export var score = 0

func _ready():
	panel.visible = false
	score_label.text = "Score: " + str(score)

	# connect all existing keys
	for k in keys_container.get_children():
		if k is Area2D:
			print("Connected key: ", k.name)
			k.body_entered.connect(_on_key_collected.bind(k))

	check_button.pressed.connect(_on_check_pressed)
	chat.response_finished.connect(_on_nobody_who_chat_response_finished)


func _on_key_collected(body: Node, key_node: Area2D) -> void:
	if body.name != "Player":
		return

	# حذف المفتاح
	key_node.queue_free()

	# تفعيل البانيل
	panel.visible = true
	question_label.text = "AI is thinking..."
	_request_ai_question()


func _request_ai_question():
	current_question = ""
	current_answer = ""
	question_label.text = "AI is thinking..."
	answer_input.text = ""
	chat.say("""
You are a friendly 1st grade math teacher.
Give me ONE simple math question (addition, subtraction, or multiplication with numbers 1–12).
Do NOT give the answer, only the question.
Format exactly:

Question: <the question in a kid-friendly way>
""")


func _compute_answer_from_question(q: String) -> String:
	# normalize
	var s := q.strip_edges().to_lower()

	# 1) try symbol form:  5 + 3, 9-4, 2 x 6, 3 × 7, 4*2
	var re1 := RegEx.new()
	re1.compile(r"(-?\d+)\s*([+\-x×*])\s*(-?\d+)")
	var m1 := re1.search(s)
	if m1:
		var a := int(m1.get_string(1))
		var op := m1.get_string(2)
		var b := int(m1.get_string(3))
		var res := 0
		match op:
			"+": res = a + b
			"-": res = a - b
			"x", "×", "*": res = a * b
		return str(res)

	# 2) try word form: "what is 3 plus 4?", "7 minus 2", "6 times 3", "multiply 4 by 2"
	var re2 := RegEx.new()
	re2.compile(r"(-?\d+)\s*(plus|add|minus|subtract|times|multiply|multiplied\s+by)\s*(-?\d+)")
	var m2 := re2.search(s)
	if m2:
		var a := int(m2.get_string(1))
		var word := m2.get_string(2)
		var b := int(m2.get_string(3))
		var res := 0
		match word:
			"plus", "add": res = a + b
			"minus", "subtract": res = a - b
			"times", "multiply", "multiplied by": res = a * b
		return str(res)

	return ""


func _on_check_pressed():
	var player_answer = answer_input.text.strip_edges()

	if current_answer == "":
		question_label.text = "[Please wait for the question, then answer]"
		return

	if player_answer == current_answer:
		question_label.text = "Good!"
		score += 1
		score_label.text = "Score: " + str(score)
	else:
		question_label.text = "Wrong!"

	await get_tree().create_timer(2.0).timeout
	panel.visible = false
	answer_input.text = ""


func _on_nobody_who_chat_response_finished(response: String) -> void:
	current_question = ""
	current_answer = ""

	var lines := response.split("\n")
	for line in lines:
		if line.begins_with("Question:"):
			var parts := line.split(":", false)
			current_question = parts[1].strip_edges() if (parts.size() >= 2) else parts[0].strip_edges()

	if current_question != "":
		current_answer = _compute_answer_from_question(current_question)

	if current_question.length() > 1000:
		current_question = current_question.substr(0, 1000) + "..."

	question_label.text = current_question
