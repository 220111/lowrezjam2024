class_name GameOver
extends Control

@onready var score_label: Label = $VBoxContainer/ScoreLabel
@onready var play_button: TextureButton = $VBoxContainer/PlayButton

func _ready() -> void:
	pass
	#play_button.pressed.connect(reset_game)

func set_score(score: int):
	score_label.text = str(score)

func reset_game():
	print("reset")
	get_tree().reload_current_scene()
