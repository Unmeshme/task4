#honestly define these inside globals
extends Node

#rect pos is also the (0,0) <- min value corner
var rect_pos: Vector2
var max_height: int
var max_width: int
var grid_width: int
var grid_height: int


const RECT_WIDTH: int = 100


func convert_grid_to_global(p_position: Vector2) -> Vector2:
	#TODO: put a check to see if its out of bond if so choose the first square or -1,-1
	return Globals.rect_pos + RECT_WIDTH * p_position
