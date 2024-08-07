class_name Player
extends CharacterBody2D

signal action_pressed

@export var speed = 35
const TEA = preload("res://scenes/tea.tscn")
const COFFEE = preload("res://scenes/coffee.tscn")

var action_mode := false

@onready var parent = self.get_parent()

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("action")):
		action_pressed.emit()
	elif (action_mode == false):
		if(Input.is_action_just_pressed("fireCoffee")):
			var coffee = COFFEE.instantiate()
			coffee.global_position = global_position
			coffee.global_position.y -= 5
			parent.add_child(coffee)
		elif(Input.is_action_just_pressed("fireTea")):
			var tea = TEA.instantiate()
			tea.global_position = global_position
			tea.global_position.y -= 5
			parent.add_child(tea)
	

func get_input():
	var input_direction = Input.get_axis("left", "right")
	velocity.x = input_direction * speed
	if(action_mode):
		velocity.x = 0;

func _physics_process(delta):
	get_input()
	move_and_slide()

func start_action_mode():
	action_mode = true

func end_action_mode():
	action_mode = false
