class_name AStar extends Node

const heuristic = preload("res://scripts/heuristic.gd")

func pathfinding(graph: Graph, start: Vector2i, end: Vector2i) -> Array[Connection]:
	var start_record = NodeRecord.new()
	start_record.node = start
	start_record.connection = null
	start_record.cost_so_far = 0
	start_record.estimated_total_cost = heuristic.estimate(start, end)
	
	var open = PathFindingList.new()
	open.insert(start_record)
	var closed = PathFindingList.new()
	
	var current: NodeRecord
	
	# Iterate through processing each node
	while open.total_elements() > 0:

		current = open.smallest_element()
		
		if current.node == end:
			break
		
		var connections = graph.get_connections(current.node)
		
		# loop through each connection in turn
		for connection in connections:
			# get the estimated cost for the end node
			var end_node = connection.get_to_node()
			var end_node_cost = current.cost_so_far + connection.get_cost()
			
			var end_node_record: NodeRecord
			var end_node_heuristic: float
			
			if closed.contains(end_node):
				end_node_record = closed.find(end_node)
				
				if end_node_record.cost_so_far <= end_node_cost:
					continue
				
				closed.delete(end_node_record)
				
				end_node_heuristic = end_node_record.estimated_total_cost -\
				 end_node_record.cost_so_far
				
			elif open.contains(end_node):
				end_node_record = open.find(end_node)
				
				if end_node_record.cost_so_far <= end_node_cost:
					continue
					
				end_node_heuristic = end_node_record.estimated_total_cost -\
				 end_node_record.cost_so_far
				
			else:
				end_node_record = NodeRecord.new()
				end_node_record.node = end_node
				
				# we calculate the heuristic value
				end_node_heuristic = heuristic.estimate(end_node, end)
		
			# update the node: cost, estimate and connection if needed
			end_node_record.cost_so_far = end_node_cost
			end_node_record.connection = connection
			end_node_record.estimated_total_cost = end_node_cost + end_node_heuristic
			
			# add it to the open list
			if not open.contains(end_node):
				open.insert(end_node_record)
				
		# remove current node from the open list
		open.remove(current)
		closed.insert(current)
	
	# if we've found the goal or there are no more nodes to search
	if current.node != end:
		# we've round out of nodes, there is no solution
		return []
	
	else:
		# compile the list of connections in the path
		var path: Array[Connection] = []
			
		# work back along the path, accumulating connections
		while current.node != start:
			path.append(current.connection)
			var x = current.connection.get_from_node()
			var y = closed.find(x)
			current = y
			
		path.reverse()
		return path
