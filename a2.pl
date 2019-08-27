% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

% Your program goes here

/** <examples> Your example queries go here, e.g.
?- member(X, [cat, mouse]).
*/
road(A,B,Cost,Network) :-
    A == B,
    Cost = 0,
    Network = Network.
road(A,B,Cost,Network) :-
	member((A,X),Network),
	member((B,Cost),X).
complete(Path,Network) :-
	not((member((A,_),Network),
    not(member(A,Path)))).
nonrepeating(Path) :-
    is_set(Path).
middle(Middle,Path) :-
    Path = [_|End],
    append(Middle,[_],End).
cyclic(Path) :-
    middle(Middle,Path),
    nonrepeating(Middle).
solution([StartCity],RoadNetwork,SolutionCost,SolutionPath) :-
    complete(SolutionPath,RoadNetwork),
    cyclic(SolutionPath),
    recursiveDFS(StartCity,RoadNetwork,SolutionCost,SolutionPath).
recursiveDFS(StartCity,RoadNetwork,0,[StartCity]).
recursiveDFS(StartCity,RoadNetwork,SolutionCost,SolutionPath) :-
    append(PrevSolutionPath,[CurrentNode],SolutionPath),
    append(_,[PreviousNode],PrevSolutionPath),
    road(PreviousNode,CurrentNode,Cost,RoadNetwork),
    PreviousSolutionCost = SolutionCost,
    recursiveDFS(StartCity,RoadNetwork,PreviousSolutionCost,PrevSolutionPath).
