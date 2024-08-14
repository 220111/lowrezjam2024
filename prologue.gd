class_name Prologue
extends Control

signal finished

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var texture_button: TextureButton = $TextureButton

var total_frames: int

func _ready() -> void:
	texture_button.pressed.connect(_next_frame)
	total_frames = sprite.sprite_frames.get_frame_count("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("pause")):
		finished.emit()
	if(Input.is_action_just_pressed("right")):
		_next_frame()

func _next_frame():
	if (sprite.frame == total_frames-1):
		finished.emit()
	sprite.frame += 1
