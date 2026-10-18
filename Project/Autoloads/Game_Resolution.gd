# extends the base class for the autoload.
extends Node

# runs on game start.
func _ready() -> void:
	update_resize()
	
	get_tree().root.size_changed.connect(update_resize)
	

func update_resize():
	## gets the screen size to calculate the pixel art size
	#var screen_size: Vector2i = get_window().size #DisplayServer.screen_get_size()
	#print(screen_size)
	#
	## hold the value of pixels for the pixel art.
	## each pixel should be 6 pixels on the screen.
	#@warning_ignore("integer_division")
	#var pixel_size: Vector2i = screen_size / Vector2i(6, 6)
	#print(pixel_size)
	#
	## sets the window size to match the pixel resolution
	#get_window().content_scale_size = pixel_size
	
	pass
