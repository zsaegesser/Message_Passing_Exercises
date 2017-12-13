-module(num5).
-compile(export_all).
-author("Zach Saegesser").

start() ->
  ID = spawn(num5, server, []),
  spawn(num5, client, [ID]),
  spawn(num5, client, [ID]).


client(Server_Pid) ->
  Server_Pid ! {start, self()},
  client2(Server_Pid).

client2(Server_Pid) ->
  Guess = rand:uniform(10),
  Server_Pid ! {Guess},
  receive
    {correct} ->
      io:fwrite("Success from Client ~w! Number was ~w\n", [self(), Guess]);
    {incorrect} ->
      io:fwrite("Client ~w, guessed ~w\n", [self(), Guess]),
      client2(Server_Pid)
    end.

server() ->
  Num = rand:uniform(10),
  receive
    {start, Client_Pid} ->
      server2(Client_Pid, Num)
  end.

server2(Client_Pid, Num) ->
  receive
    {Num} ->
      Client_Pid ! {correct},
      server();
    {OtherNum} ->
      Client_Pid ! {incorrect},
      server2(Client_Pid, Num)
    end.
