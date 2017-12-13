-module(num2).
-compile(export_all).
-author("Zach Saegesser").

server() ->
  receive
    {start} ->
      io:fwrite("Server ~w is ready to concatonate some strings", [self()]),
      server2("")
    end.

server2(Stng) ->
  receive
    {add, Var} ->
      io:fwrite("recived ~w", [Var]),
      server2(Stng ++ Var);
    {done} ->
      io:fwrite("Concatonate result is ~w", [Stng])
    end.
