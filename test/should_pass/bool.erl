-module(bool).

-export([b/2]).

-spec b(boolean(), bool()) -> bool().
b(B1, B2) ->
    B1 andalso B2.
