class_name Tool
extends Area2D

signal player_entered
signal player_exited

const SHINEMATERIAL = preload("res://shinematerial.tres")
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_entered)
	body_exited.connect(_exited)

func _entered(body: Node2D):
	if(body as CharacterBody2D):
		sprite_2d.material = SHINEMATERIAL
		player_entered.emit()

func _exited(body: Node2D):
	if(body as CharacterBody2D):
		sprite_2d.material = null
		player_exited.emit()
