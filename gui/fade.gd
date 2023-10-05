extends ColorRect


func toggle_input(flag: bool) -> void:
	set_mouse_filter(Control.MOUSE_FILTER_IGNORE if flag else Control.MOUSE_FILTER_STOP)
