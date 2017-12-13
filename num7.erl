-module(num7).
-compile(export_all).
-author("Zach Saegesser").

start() ->
  Id1 = spawn(num7, client, []),
  Id2 = spawn(num7, client, []),
  Id3 = spawn(num7, client, []),
  Id4 = spawn(num7, client, []),
  spawn(num7, timer, [1000,[Id1, Id2, Id3, Id4]]).

client() ->
  receive
    {tick} ->
      io:fwrite("Tick recieved from pid ~w\n", [self()]),
      client()
  end.

timer(Freq, Pids) ->
  timer:sleep(Freq),
  Fun = fun(P) -> P ! {tick} end,
  lists:map(Fun, Pids),
  timer(Freq, Pids).
