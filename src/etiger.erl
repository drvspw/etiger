-module('etiger').

%% API exports
-export([
	 tiger/1,
	 tiger2/1
	]).

-on_load(init/0).

-define(APPNAME, etiger).
-define(LIBNAME, etiger).


%%====================================================================
%% API functions
%%====================================================================
tiger(_) ->
    not_loaded(?LINE).

tiger2(_) ->
    not_loaded(?LINE).


%%====================================================================
%% Internal functions
%%====================================================================
init() ->
    SoName = filename:join(
	       case code:priv_dir(?APPNAME) of
		   {error, bad_name} ->
		       filename:join(filename:dirname(filename:dirname(code:which(?MODULE))), "priv");
		   Dir ->
		       Dir
	       end, atom_to_list(?MODULE)),
    ok = erlang:load_nif(SoName, 0).

not_loaded(Line) ->
    exit({not_loaded, [{module, ?MODULE}, {line, Line}]}).
