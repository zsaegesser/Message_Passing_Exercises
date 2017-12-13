-module(num4).
-compile(export_all).
-author("Zach Saegesser").

start() ->
  Serv_id = spawn(num4, server, []),
  client(Serv_id).


client(Server_Pid) ->
  Num = rand:uniform(1000),
  Server_Pid ! {Num, self()},
  receive
    {Var} ->
      io:fwrite("Serve said ~w for num ~w.\n", [Var, Num]),
      timer:sleep(1000),
      client(Server_Pid)
  end.



server() ->
  receive
    {Num, Client_Pid} ->
      if
        ((Num rem 2) == 0) ->
          Client_Pid ! {true};
        true ->
          Client_Pid ! {false}
      end,
      server()
  end.
