extends Node

var global_parent = null
var player = null
var camera = null

var score = 0
var highscore = 0

func instance_node(node, location, parent = global_parent):
	var node_instance = node.instance()
	
	node_instance.global_position = location
	
	parent.add_child(node_instance)

	return node_instance

func stop_node(node) -> void:
	node.set_process(false)
	node.set_physics_process(false)
	node.set_process_input(false)
	node.set_process_internal(false)
	node.set_process_unhandled_input(false)
	node.set_process_unhandled_key_input(false)
