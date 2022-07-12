list(Op, Ref, List):-(
    Op='eq', findall([X, Y, Z], (pay(X, Y, Z), Z=:=Ref), List);
    Op='ne', findall([X, Y, Z], (pay(X, Y, Z), Z=\=Ref), List);
    Op='gt', findall([X, Y, Z], (pay(X, Y, Z), Z>Ref), List);
    Op='ge', findall([X, Y, Z], (pay(X, Y, Z), Z>=Ref), List);
    Op='lt', findall([X, Y, Z], (pay(X, Y, Z), Z<Ref), List);
    Op='le', findall([X, Y, Z], (pay(X, Y, Z), Z=<Ref), List)
    ). % check if the sublist is the same as List.
count(Op, Ref, Count):- (
    Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List),  length(List, Count);
    Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List),  length(List, Count);
    Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  length(List, Count);
    Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  length(List, Count);
    Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  length(List, Count);
    Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  length(List, Count)
    ).
% Check if Count is the number of employees in the sublist.
min(Op, Ref, Min):-(
    Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List),  min_list(List, Min);
    Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List),  min_list(List, Min);
    Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  min_list(List, Min);
    Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  min_list(List, Min);
    Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  min_list(List, Min);
    Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  min_list(List, Min)  
    ). % Check if Min is the minimum pay of the employees in the sublist.
max(Op, Ref, Max):-(
    Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List),  max_list(List, Max);
    Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List),  max_list(List, Max);
    Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  max_list(List, Max);
    Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  max_list(List, Max);
    Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  max_list(List, Max);
    Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  max_list(List, Max)  
    ). % Check if Max is the maximum pay of the employees in the sublist.
total(Op, Ref, Total):-(
    Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List),  sum_list(List, Total);
    Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List),  sum_list(List, Total);
    Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  sum_list(List, Total);
    Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  sum_list(List, Total);
    Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  sum_list(List, Total);
    Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  sum_list(List, Total)    
    ). % Check if Total is the total pay of the employees in the sublist.
avg(Op, Ref, Avg):-(
    Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List),  sum_list(List, Sum), length(List, Length), Length > 0, Avg is Sum / Length;
    Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  sum_list(List, Sum ), length(List, Length), Length > 0, Avg is Sum / Length;
    Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  sum_list(List, Sum ), length(List, Length), Length > 0, Avg is Sum / Length;
    Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  sum_list(List, Sum ), length(List, Length), Length > 0, Avg is Sum / Length;
    Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  sum_list(List, Sum ), length(List, Length), Length > 0, Avg is Sum / Length
    ). % Check if Avg is the average pay of the employees in the sublist.