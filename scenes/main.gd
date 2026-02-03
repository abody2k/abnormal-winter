extends Node3D


const WORM = preload("res://scenes/worm.tscn")
const TOUNGE = preload("res://scenes/tounge.tscn")
const FOOD = preload("res://scenes/bag.tscn")


var global_worms = 0 
var global_tounge = 0

const MAXIMUM_NO_OF_WORMS = 30
const MAXIMUM_NO_OF_TOUNGES = 30



func _ready():
	pass # Replace with function body.



func _process(delta):
	pass


func _on_timer_timeout():
	if global_worms < MAXIMUM_NO_OF_WORMS :
		var worm = WORM.instantiate()
		add_child(worm)
		#worm.position = $loc.position
		global_worms+=1
	
	if global_tounge < MAXIMUM_NO_OF_TOUNGES :
		var tounge = TOUNGE.instantiate()
		add_child(tounge)
		#tounge.position = $loc.position
		global_tounge+=1

func worm_died():
	global_worms-=1
	
func tounge_died():
	global_tounge-=1

func _on_materials_timeout():
	var bag = FOOD.instantiate()
	add_child(bag)
	
	bag.position = $land_001/house/drop.global_position
	pass # Replace with function body.


func _on_start_button_down():
	$CanvasLayer/Control/Panel.visible = false
	$AnimationPlayer.play("the story")
	#get_tree().call_group("farmer","start_game")


func _on_leave_button_down():
	get_tree().quit(0)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "the story":
		$AnimationPlayer.play("RESET")
		get_tree().call_group("farmer","start_game")
	pass # Replace with function body.
