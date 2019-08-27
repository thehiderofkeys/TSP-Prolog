% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

% Your program goes here

/** <examples> Your example queries go here, e.g.
?- member(X, [cat, mouse]).
*/
road(A,A,0,_).
road(A,B,Cost,Network) :-
	member((A,X),Network),
	member((B,Cost),X).
complete(Path,Network) :-
	not((member((_,Roads),Network),member((B,_Cost),Roads),
    not(member(B,Path)))),
	not((member((A,_),Network),
    not(member(A,Path)))).
nonrepeating(Path) :-
    is_set(Path).
cyclic(Path) :-
    append([First],End,Path),
    append(_,[First],End),
    nonrepeating(End).
solution(Path,RoadNetwork,SolutionCost,SolutionPath) :-
    recursiveDFS(Path,RoadNetwork,0,SolutionCost,SolutionPath).
recursiveDFS(Path,RoadNetwork,CurrentCost,CurrentCost,Path):-
    cyclic(Path),
    complete(Path,RoadNetwork).
recursiveDFS(Path,RoadNetwork,CurrentCost,SolutionCost,SolutionPath) :-
    append(_,[CurrentNode],Path),
    nonrepeating(Path),
    road(CurrentNode,NextNode,Cost,RoadNetwork),
    NextCost is CurrentCost+Cost,
    append(Path,[NextNode],NewPath),
    recursiveDFS(NewPath,RoadNetwork,NextCost,SolutionCost,SolutionPath).