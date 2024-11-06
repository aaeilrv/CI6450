class_name AStar extends Node

func heuristic(from_node: Vector2i, to_node: Vector2i) -> float:
	var dx = to_node.x - from_node.x
	var dy = to_node.y - from_node.y
	var distance: float
	
	# Euclidian Distance
	#distance = sqrt(dx ** 2 + dy ** 2)
	
	# Manhattan distance:
	distance = abs(dx) + abs(dy)
	
	return distance

func path_building(graph: Graph, start: Vector2i, goal: Vector2i) -> Array[Vector2i]:
	var parents = self.pathfinding(graph, start, goal)
	var current: Vector2i = goal
	var path: Array[Vector2i] = []
	
	if goal not in parents:
		return []
	while current != start:
		current = parents[current]
		path.append(current)
	path.reverse()
	return path
		

func pathfinding(graph: Graph, start: Vector2i, end: Vector2i):
	var open_list = PriorityQueue.new()
	open_list.insert(start, 0)
	
	var came_from = {} # stores the tile and the parent where it came frfom
	var cost_so_far = {} 
	
	came_from[start] = null
	cost_so_far[start] = 0
	
	while not open_list.empty():
		var current = open_list.extract()
		
		if current == end:
			break
		
		# get all the valid connections of the current node
		var neighbors = graph.get_connections(current)
		
		for neighbor in neighbors:
			var new_cost = cost_so_far[current] + neighbor.get_cost()
			# if we haven't seen this neighbor or if the new cost is < than the cost we knew
			if neighbor.to_node not in cost_so_far or new_cost < cost_so_far[neighbor.to_node]:
				cost_so_far[neighbor.to_node] = new_cost
				var priority = new_cost + self.heuristic(neighbor.to_node, end)
				open_list.insert(neighbor.to_node, priority)
				came_from[neighbor.to_node] = current
				
	return came_from
