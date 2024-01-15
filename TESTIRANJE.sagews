︠4c02ab80-5bb8-40ab-a676-772c7bdb1754s︠
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
︡85dd798f-fc57-421f-bf47-43f6bf5b6e5d︡{"done":true}
︠06b61318-dbf6-4adb-92f9-86cd20c46fbfs︠

︡0bcb01b2-16ed-4613-9769-246848c1eba5︡{"done":true}
︠27eb0d5d-352c-4600-b3cd-b90959b94df7s︠
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
︡b3b65ded-7114-4d2b-84e8-baf665f5ff21︡{"done":true}
︠322a19cb-b7da-4071-a5a8-f0a473948b37s︠

︡9d8658c9-810a-48e8-b45a-64e1a0a6482a︡{"done":true}
︠6adfa60d-02fd-44cb-8648-2e7f552a885es︠
︡6589da9e-4c84-450b-8caa-c85b5d59d258︡{"done":true}
︠fc7374a2-e8bf-41cb-bcbe-55ae15601af1︠
#___________________________TESTIRANJE NA GRAFIH_____________________________________________________

# pomožne funkcije, da ne bo treba tolikokrat vstavljati številke v funkcije
def dimenzija_povezav(graf, k):
    s = []
    for i in range(1,k+1):
        s.append(weak_edge_k_metric_dimension_ILP(graf, i))
    return s

def dimenzija_vozljisca(graf, k):
    s = []
    for i in range(1,k+1):
        s.append(weak_vertex_k_metric_dimension_ILP(graf, i))
    return s

︡db93572d-0399-416e-86fa-234d55fa561d︡{"done":true}
︠8aaf8bbc-f22e-4cac-8233-4f2077310312s︠

#poti


a1 = graphs.PathGraph(3)
︡80b928da-893e-4038-bd0d-33cbbef1638d︡{"done":true}
︠f9973c6a-118d-42f7-97d0-49a93e2ee80cs︠
︡def2f3de-bcef-4bc6-995a-c7345c47551e︡{"done":true}
︠a741067f-8205-4ba4-abb8-cc41dbcd4cc9s︠
dimenzija_povezav(a1, 2)
︡9e5248e0-240b-444a-a0f8-dc916e73b3e2︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠188ddae9-da56-408f-a709-f57fb2b80005s︠
dimenzija_vozljisca(a1,2)

︡0fe7f2cd-df8e-456f-842f-ac025c2569ea︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠813d1252-cbf1-4916-9e01-77ffb117ffc7s︠


a2 = graphs.PathGraph(5)

dimenzija_povezav(a2, 4)
︡c779f1b6-5009-457c-b834-f57d4ab94d69︡{"stdout":"[1, 2, 3, 4]\n"}︡{"done":true}
︠8550b95d-c684-484c-91a5-eb27b4d8ec1ds︠
dimenzija_vozljisca(a2,4)

︡31dd4224-3344-422e-8373-52227e1e567e︡{"stdout":"[1, 2, 2, 2]\n"}︡{"done":true}
︠765bc2cf-6a5a-4239-bc46-35669df3dc1as︠

a3 = graphs.PathGraph(10)
dimenzija_povezav(a3, 9)
︡c2176e1c-3f98-49cc-a2a7-9fccc2829f2b︡{"stdout":"[1, 2, 3, 4, 5, 6, 7, 8, 9]\n"}︡{"done":true}
︠a9390e2a-bfaa-492e-8a02-0330721c96c7s︠
dimenzija_vozljisca(a3,9)

︡4d50ce43-6303-46a5-b19b-e80002c8d5c6︡{"stdout":"[1, 2, 2, 2, 2, 2, 2, 2, 2]"}︡{"stdout":"\n"}︡{"done":true}
︠fa081a8c-b8f7-4380-a7ec-d384cdca207e︠

#alternativa: sami definiramo graf tako
a1_ = Graph({0:[1], 1:[2], 2:[3]})


a2_ = Graph({0:[1], 1:[2], 2:[3], 3:[4]})


a3_ = Graph({0:[1], 1:[2], 2:[3], 3:[4], 4:[5], 5:[6]})

show(a1)


#cikli

#b1 = graphs.CycleGraph(3)


︡9f04039f-a3f7-4312-a2c0-880f39405d73︡
︠29720f03-599a-4aeb-835e-3514fa0c44ees︠
b2 = graphs.CycleGraph(5)

dimenzija_povezav(b2, 4)

dimenzija_vozljisca(b2, 4)
︡bcd42307-f59e-435b-9e2e-fabddcbcf15c︡{"stdout":"[2, 3, 4, 5]\n"}︡{"stdout":"[1, 2, 2, 2]\n"}︡{"done":true}
︠b4323c90-39bb-4a13-a21c-355c0e8f6761s︠
b3 = graphs.CycleGraph(6)

dimenzija_povezav(b3, 4)

dimenzija_vozljisca(b3, 4)
︡97207185-e6b5-4598-aa9e-1c430a7584f2︡{"stdout":"[1, 2, 3, 4]\n"}︡{"stdout":"[1, 2, 2, 2]\n"}︡{"done":true}
︠2c780fa8-6a30-4bdb-9fed-5947b36475a4s︠
b4 = graphs.CycleGraph(11)

dimenzija_povezav(b4, 10)

︡4e970c27-f3c9-489e-834e-393801501afd︡{"stdout":"[2, 3, 4, 5, 6, 7, 8, 9, 10, 11]\n"}︡{"done":true}
︠2ce09510-741d-49bc-90a2-a718c4b0106es︠
dimenzija_vozljisca(b4, 10)
︡d1690dd3-53d8-4209-9f0b-f3eae3e976b1︡{"stdout":"[1, 2, 2, 2, 2, 2, 2, 2, 2, 2]"}︡{"stdout":"\n"}︡{"done":true}
︠a4dbf587-715d-47ff-9ab6-c8209d05e3b0︠
︡545e3de3-8408-438b-9502-18c07c058e7f︡
︠64755fef-e17e-4625-83b6-d52f7b41b865s︠
b5 = graphs.CycleGraph(12)

dimenzija_povezav(b5, 10)

dimenzija_vozljisca(b5, 10)
︡99d62570-9eae-476a-bdb9-d08572ebe83f︡{"stdout":"[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]\n"}︡{"stdout":"[1, 2, 2, 2, 2, 2, 2, 2, 2, 2]"}︡{"stdout":"\n"}︡{"done":true}
︠7378ebf6-2e7e-46ca-8d2a-2445b5a3afd5︠

︡64e534e7-6ca1-47e0-b420-8b2126d3ce61︡
︠95130705-c4ad-4f4b-971c-10fc57f1fbad︠





#alternativa

b1_ = Graph({0:[1], 1:[2], 2:[3], 3:[0]})

b2_ = Graph({0:[1], 1:[2], 2:[3], 3:[4], 4:[0]})

b3_ = Graph({0:[1], 1:[2], 2:[3], 3:[4], 4:[5], 5:[6], 6:[0]})



#polni grafi (complete graphs)
︡26e5de28-2414-4905-b300-347660193b6c︡
︠f1e680ad-bed6-4a8e-a51f-a5efae5a329as︠
c1 = graphs.CompleteGraph(5)

dimenzija_povezav(c1, 2)

dimenzija_vozljisca(c1, 2)
︡11303398-58c8-414f-ada9-6f7f305eeae5︡{"stdout":"[4, 5]\n"}︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠be353ef2-51f9-41cb-8b39-7ed3c2ef4b4cs︠

︡5fee58c5-f444-4088-ad00-691fad3b35e1︡{"done":true}
︠88f79f35-221b-4d09-85da-29caa2073e06s︠
c2 = graphs.CompleteGraph(10)

dimenzija_povezav(c2, 2)

dimenzija_vozljisca(c2, 2)
︡627cfc23-09ff-42ad-a510-87e68d604d10︡{"stdout":"[9, 10]\n"}︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠84a4a795-de8e-4c9a-a332-75e59248c92cs︠

︡a0c680ee-a214-4793-a1b9-4b2dfef7232f︡{"done":true}
︠2b52a226-96f3-40fd-bc19-4a2ca321bd7ds︠
# polni dvodelni grafi

d1 = graphs.CompleteBipartiteGraph(3,3)
dimenzija_povezav(d1, 2)

dimenzija_vozljisca(d1, 2)

︡5a45e2e5-f40a-402e-98ac-2be2f62cd6db︡{"stdout":"[1, 2]\n"}︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠c33ceecf-3d81-484b-9a4f-01e6fbdf2448s︠



︡0e4d23e2-01c6-42ab-a0df-c12befe04eb2︡{"done":true}
︠6944d1e4-79ef-478d-af42-15bb7fdbf5d3s︠
d2 = graphs.CompleteBipartiteGraph(5,5)
dimenzija_povezav(d2, 2)

dimenzija_vozljisca(d2, 2)
︡662a1b62-17d0-417d-af79-b80a0c293083︡{"stdout":"[1, 2]\n"}︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠f966f755-a3cc-4937-a6ae-aff0bca76862s︠
d3 = graphs.CompleteBipartiteGraph(7,11)
dimenzija_povezav(d3, 2)

︡e16e72c9-e7eb-42b7-a31e-a93fbe76e432︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠e425bbfe-8b7f-4851-83bb-112683fd3c54s︠
dimenzija_vozljisca(d3, 2)
︡541af99b-29f1-4d86-905a-67dbef80f2e2︡{"stdout":"[1, 2]"}︡{"stdout":"\n"}︡{"done":true}
︠ddd35ce2-8c44-4db5-a1ae-984b0630420d︠

#hiperkocke

︡8b6dc731-a94c-4308-8596-500562ec9a7d︡
︠3364ef95-d0c1-45e9-b935-c704bb089830s︠
h1 = graphs.CubeConnectedCycle(2)
dimenzija_povezav(h1, 6)

dimenzija_vozljisca(h1, 6)



︡9bf1c6a3-7649-427c-8cda-c49d04a70f35︡{"stdout":"[1, 2, 3, 4, 5, 6]\n"}︡{"stdout":"[1, 2, 2, 2, 2, 2]\n"}︡{"done":true}
︠b982fcac-c916-4110-a205-cd4a103d7da5s︠
h2 = graphs.CubeConnectedCycle(3)
dimenzija_povezav(h2, 16)

dimenzija_vozljisca(h2, 16)
︡84ec84e8-0889-4b9d-8c5c-e025acfacae5︡{"stdout":"[2, 4, 6, 7, 8, 10, 11, 12, 14, 16, 18, 19, 20, 22, 23, 24]"}︡{"stdout":"\n"}︡{"stdout":"[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3]"}︡{"stdout":"\n"}︡{"done":true}
︠359de9cd-587e-430e-a93a-db7b95a78b15s︠


︡b8abcbec-7be6-4aa7-8763-be7cc0da7a32︡{"done":true}
︠b8fe331e-f449-4c5a-9150-859868ed4472︠
︡fef14e43-0c4d-4045-9f38-5d4b19104eba︡
︠f78f0e5e-68b2-4688-831c-5bff7018dce5s︠
h3 = graphs.CubeConnectedCycle(4)
dimenzija_povezav(h3, 24)

︡b8a6bbc9-3785-45b1-a6b5-35d6dfe8f8d7︡{"stdout":"[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]"}︡{"stdout":"\n"}︡{"done":true}
︠73de0a56-cda9-471a-8e97-30eccf4d5660︠

︡8cf00155-4394-4799-9c23-dff2a9a47c5e︡
︠74698ab4-5fd5-442d-838c-c9aa2f612655︠
dimenzija_vozljisca(h3, 24)

# traja predolgo

︡aef9b796-4581-43ef-99a7-d286b6fca3aa︡
︠73015a25-6a5c-4c33-b870-f5471bd3f9efs︠
#zvezdni grafi

z1 = graphs.StarGraph(5)
dimenzija_povezav(z1, 2)

dimenzija_vozljisca(z1, 2)
︡5f70c036-fa13-4c46-a887-9e7ab8808911︡{"stdout":"[1, 2]\n"}︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠360ab64c-30a5-4c85-ae9b-589fca94fd5bs︠

︡61f57629-be07-40e0-8860-d30521aec544︡{"done":true}
︠cd8db9fe-9f49-4013-b58d-7a829e44613ds︠
z2 = graphs.StarGraph(10)
dimenzija_povezav(z2, 2)

dimenzija_vozljisca(z2, 2)
︡618fb981-bb09-476c-9cbf-6fe5bf616501︡{"stdout":"[1, 2]\n"}︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠956e45a6-af92-4386-944e-0e8fc40d1201s︠

︡0001d74b-58f5-4716-a753-44010f8b29fb︡{"done":true}
︠4da79df5-afa1-45c2-848b-faedd76bfe19︠
︡4461fe32-c875-48b7-a0e8-49a95d267c84︡
︠bfc75856-18ac-49b7-948a-b25feeab30bas︠
z3 = graphs.StarGraph(20)
dimenzija_povezav(z3, 2)

dimenzija_vozljisca(z3, 2)

︡885e104b-be5d-42c9-971e-e7c35b8da3b9︡{"stdout":"[1, 2]\n"}︡{"stdout":"[1, 2]"}︡{"stdout":"\n"}︡{"done":true}
︠23c62fe8-443c-405b-a271-85a869f11d78︠
show(z3)
︡6be76b91-5370-4678-afd8-10e7e15e054f︡
︠98ce6038-233b-4904-8f83-c951ff455790︠
#gem graph

︡71901c40-087f-4179-ba99-9f263e4afe6e︡
︠610616bb-dac8-4299-ac9b-096cf8e8164as︠
g1 = graphs.GemGraph()

dimenzija_povezav(g1, 3)

dimenzija_vozljisca(g1, 3)

︡a68d5c7a-b24d-4320-b6fa-bbbc651fec43︡{"stdout":"[2, 3, 5]\n"}︡{"stdout":"[1, 2, 2]\n"}︡{"done":true}
︠4fe745ae-6777-4376-aa42-6f83d047b982︠
show(g1)
︡90ba5331-d402-4c85-b145-5c9ce682bf1f︡
︠7b00c7f9-e8c7-4df5-803c-6741cc79846e︠
#dart graph

︡3e949d79-8999-4006-8b9a-88e3a328bff2︡
︠e7bcdee1-82c1-49e2-9d2e-8c78da3ae798s︠
da = graphs.DartGraph()
dimenzija_povezav(da, 2)

dimenzija_vozljisca(da, 2)



︡4c8133f3-872c-44ff-8f03-de7097f5afb6︡{"stdout":"[2, 3]\n"}︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠23166274-a2fe-4a47-a207-7b0ba5af2016︠
show(da)
︡284a2a77-d3c3-478b-80ef-95c060279e90︡
︠955fe593-2f32-49b7-8d44-e28ee65bab1as︠
#drevesa

T = graphs.BalancedTree(4,2)
#T.show()

dimenzija_povezav(T, 2)

dimenzija_vozljisca(T, 2)
︡434d3aa4-88ae-48ab-a830-8dffb9133473︡{"stdout":"[1, 2]\n"}︡{"stdout":"[1, 2]"}︡{"stdout":"\n"}︡{"done":true}
︠108ea1e5-5429-4b36-92ad-dd603d8b9fb1s︠


︡e86bb455-8222-48a5-9277-05fe667974f9︡{"done":true}
︠dd139f80-af3e-498c-b952-3e5a6f8a2fc8s︠
from sage.graphs.graph_plot import GraphPlot
G = graphs.HoffmanSingletonGraph()
T = Graph()
T.add_edges(G.min_spanning_tree(starting_vertex=0))
︡120eebbc-fe63-4713-a118-ca3e998a9864︡{"done":true}
︠cbadbcc9-b7ed-4d8e-9cb4-af2117416e9bs︠
T.show(layout='tree', tree_root=0)

︡e9ce51c4-9dcc-4735-a8ef-5c30229e9bf6︡{"file":{"filename":"/tmp/tmpl91wtzub/tmp_qkfxws2p.svg","show":true,"text":null,"uuid":"212a5f67-b86f-4d7a-a4b5-168358f7ab42"},"once":false}︡{"done":true}
︠53be172f-0ec5-41ba-b4ea-021be69660e1︠

︡95c90f37-6a74-47a5-8964-98db9c4da66b︡
︠6a46161f-7805-400c-b133-fd9f62fa9f68︠

︡1b917155-62ac-4897-932e-4dadc978e37b︡
︠e25ff610-0146-449f-aa09-cc4cbdc545e0︠
T = list(graphs.trees(7))
t2 = T[2]
#t2.show()

dimenzija_povezav(t2, 3)
dimenzija_vozljisca(t2, 3)

︡45043caf-3b19-4256-b1ab-612a80352e3b︡{"stdout":"[1, 2, 3]\n"}︡{"stdout":"[1, 2, 2]\n"}︡{"done":true}
︠08abb218-9ee9-425f-a289-93b59ac60026︠
︡43ca6e18-9483-4ae8-990a-a1dff2c3b42e︡
︠a7ec52b1-2c22-47e2-a49f-78c8efe7d3cas︠
t2.show()
︡2cb1f48c-f2a5-4565-8adc-b1f0b3318b5f︡{"file":{"filename":"/tmp/tmpl91wtzub/tmp_gk4azzlb.svg","show":true,"text":null,"uuid":"97c7798f-bbdb-4e2c-83eb-8e4fb2d36c80"},"once":false}︡{"done":true}
︠21f1717c-f1fd-4798-ab36-ea9a8db3ff87︠

︡825d8501-e774-4907-b8ce-614ac6dacd1b︡
︠c69b0ccb-46dc-452a-a17f-db51f2259c33︠
︡d63e19d3-3130-4d23-b1d2-e7645a5ef4f7︡
︠540ee2c0-3e82-4925-b498-7d08c9c4c12ds︠
T = list(graphs.trees(7))
t3 = T[3]
t3.show()
︡55e73ee2-8bbd-48ab-974c-c40a6e978c55︡{"file":{"filename":"/tmp/tmpl91wtzub/tmp__zam8gzp.svg","show":true,"text":null,"uuid":"c132dfe8-009c-4601-9a9f-3d02b62a9ad9"},"once":false}︡{"done":true}
︠73ca2d42-cbb9-4bdf-a423-6d76664d1823s︠
dimenzija_povezav(t3, 2)
dimenzija_vozljisca(t3, 2)

︡9c31b0f5-a3ba-4d00-afcb-bc1ccc5584f8︡{"stdout":"[1, 2]\n"}︡{"stdout":"[1, 2]\n"}︡{"done":true}
︠0342c1c9-e825-4d1c-974b-40482130869as︠

︡6ec0b7b7-e103-49ce-9de8-777339f4c3f6︡{"done":true}
︠75920730-6c9f-4c84-af16-a0bdb967321bs︠
#finbonaccijeva drevesa

f1 = graphs.FibonacciTree(3)
dimenzija_povezav(f1, 3)
dimenzija_vozljisca(f1, 3)

︡63dd38ad-8485-4e85-9b66-ecf655a91ce4︡{"stdout":"[1, 2, 3]\n"}︡{"stdout":"[1, 2, 2]\n"}︡{"done":true}
︠9d4fa5cb-f521-4aa2-b68a-3aa51f976d2es︠

︡51f7f3e3-3c4d-45a2-9c93-776477d284f1︡{"done":true}
︠ffa0edf6-cb94-4280-93b7-ade122700c46s︠
f2 = graphs.FibonacciTree(5)
dimenzija_povezav(f2, 3)
dimenzija_vozljisca(f2, 3)

︡48c041c3-a8d7-47e2-abf0-08825707aa3f︡{"stdout":"[1, 2, 3]\n"}︡{"stdout":"[1, 2, 2]"}︡{"stdout":"\n"}︡{"done":true}
︠4d8934dd-ed90-44bc-89d8-555e65475c82s︠

︡b8f4667c-5b36-468e-9206-baca9d2affc7︡{"done":true}
︠cf4b5af0-e853-428e-a9e2-940d0df22a8e︠
︡f29b64cb-a967-49f4-be59-03887a2a370c︡
︠9f19e5f5-f1a1-4890-a91c-6fd82a0b80bcs︠
f3 = graphs.FibonacciTree(10)
dimenzija_povezav(f3, 3)


︡474571f4-88e0-452d-b586-fa2dcd91d827︡{"stdout":"[1, 2, 3]"}︡{"stdout":"\n"}︡{"done":true}

dimenzija_vozljisca(f3, 3)
#traja predolgo
︠4fbd91eb-4349-430f-ab3e-fadbebff3193︠



























