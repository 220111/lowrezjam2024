class_name pause
extends Control

@onready var resume: TextureButton = $Resume

func _ready() -> void:
	_hide_menu()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		mouse_filter = MOUSE_FILTER_STOP
		for x in get_children():
			x.show()
		get_tree().paused = true

func _hide_menu():
	for x in get_children():
		x.hide()
	mouse_filter = MOUSE_FILTER_IGNORE

func resume_pressed():
	_hide_menu()
	get_tree().paused = false;

func quit_pressed():
	get_tree().paused = false;
	get_tree().reload_current_scene()
