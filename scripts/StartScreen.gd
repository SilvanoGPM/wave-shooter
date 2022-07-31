extends Control

func _on_start_button_pressed():
	get_tree().change_scene("res://scenes/Arena.tscn")

func _on_credit_button_pressed():
	get_tree().change_scene("res://scenes/CreditsScreen.tscn")
