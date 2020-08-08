extends Control

signal pressed()

export var title="Button" setget title_set
export var active=false setget active_set

func active_set(value):
	active=value
	$key.visible=value
	
func title_set(title_):
	title=title_
	$Button.text=title_


# Called when the node enters the scene tree for the first time.
func _ready():
	SIGNALS.connect("button_pressed",self,"on_button_general_pressed")
	pass # Replace with function body.

func _on_Button_mouse_entered():
	$AnimationPlayer.play("running")

func _on_Button_mouse_exited():
	$AnimationPlayer.play("stop")

func _on_Button_pressed():
	emit_signal("pressed")
	SIGNALS.emit_signal("button_pressed",self.title)

func on_button_general_pressed(title0):
	if title0 == "Back":
		get_tree().change_scene("res://Menus/StartMenu.tscn")






