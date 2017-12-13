-module(num3).
-compile(export_all).
-author("Zach Saegesser").

server(Count) ->
  receive
    {counter} ->
      io:fwrite("Counter = ~w", [Count]),
      server(0);
    {continue} ->
      server(Count +1)
    end.

  server2(Count, Client_Pid) ->
    receive
      {counter} ->
        Client_Pid ! {Count},
        server2(0, Client_Pid);
      {continue} ->
        server2(Count +1, Client_Pid)
      end.
