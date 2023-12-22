#CODE FOR WEAK EDGE K-METRIC DIMENSION:

from sage.numerical.mip import MixedIntegerLinearProgram

def weak_edge_k_metric_dimension_ILP(graph, k):
    # Create an ILP instance
    p = MixedIntegerLinearProgram(maximization=False)

    # Define variables
    x = p.new_variable(binary=True)
    vertices = graph.vertices()

    # Objective function: Minimize the sum of xi variables
    p.set_objective(p.sum(x[vertex] for vertex in vertices))

    # Constraint:
    for ea, eb in graph.edges(labels=False):
        p.add_constraint(sum(abs(graph.distance(ea, vertex) - graph.distance(eb, vertex)) * x[vertex] for vertex in vertices) >= k)

    # Solve the ILP
    p.solve()

    # Extract the solution
    solution = p.get_values(x)

    # Return the cardinality of the selected set
    dimension = sum(1 for vertex in vertices if solution[vertex] == 1)
    return dimension



# CODE FOR WEAK K-METRIC DIMENSION ON VERTICES:

from sage.numerical.mip import MixedIntegerLinearProgram

def weak_vertex_k_metric_dimension_ILP(graph, k):
    # Create an ILP instance
    p = MixedIntegerLinearProgram(maximization=False)

    # Define variables
    x = p.new_variable(binary=True)
    vertices = graph.vertices()

    # Objective function: Minimize the sum of xi variables
    p.set_objective(p.sum(x[vertex] for vertex in vertices))

    # Constraints:
    for u in vertices:
        for v in vertices:
            if u != v:
                p.add_constraint(sum(abs(graph.distance(u, s) + graph.distance(v, s)) * x[s] for s in vertices) >= k)

    # Solve the ILP
    p.solve()

    # Extract the solution
    solution = p.get_values(x)

    # Return the cardinality of the selected set
    dimension = sum(1 for vertex in vertices if solution[vertex] == 1)
    return dimension




