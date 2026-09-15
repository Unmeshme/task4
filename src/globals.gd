#honestly define these inside globals
extends Node

#rect pos is also the (0,0) <- min value corner
var rect_pos: Vector2
var grid_width: int
var grid_height: int


const RECT_WIDTH: int = 100


func convert_grid_to_global(p_position: Vector2) -> Vector2:
	return rect_pos + RECT_WIDTH * p_position

#func convert_global_to_grid(p_position: Vector2) -> Vector2:
#	return Vector2(-1,-1)
