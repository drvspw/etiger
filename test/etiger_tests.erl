-module(etiger_tests).

-include_lib("eunit/include/eunit.hrl").

million_times_a() ->
    list_to_binary(lists:foldl( fun(_X, L) -> ["a"|L] end, [], lists:seq(1,1000000) )).

%%
%% http://www.cs.technion.ac.il/~biham/Reports/Tiger/test-vectors-nessie-format.dathttp://www.cs.technion.ac.il/~biham/Reports/Tiger/test-vectors-nessie-format.dat
%%
tiger_set_one_test_() ->
    [
     ?_assertMatch({ok, <<"3293AC630C13F0245F92BBB1766E16167A4E58492DDE73F3">>}, etiger:tiger(<<>>)),
     ?_assertMatch({ok, <<"3293AC630C13F0245F92BBB1766E16167A4E58492DDE73F3">>}, etiger:tiger(<<"">>)),

     ?_assertMatch({ok, <<"77BEFBEF2E7EF8AB2EC8F93BF587A7FC613E247F5F247809">>}, etiger:tiger(<<"a">>)),
     ?_assertMatch({ok, <<"2AAB1484E8C158F2BFB8C5FF41B57A525129131C957B5F93">>}, etiger:tiger(<<"abc">>)),
     ?_assertMatch({ok, <<"D981F8CB78201A950DCF3048751E441C517FCA1AA55A29F6">>}, etiger:tiger(<<"message digest">>)),
     ?_assertMatch({ok, <<"1714A472EEE57D30040412BFCC55032A0B11602FF37BEEE9">>}, etiger:tiger(<<"abcdefghijklmnopqrstuvwxyz">>)),
     ?_assertMatch({ok, <<"0F7BF9A19B9C58F2B7610DF7E84F0AC3A71C631E7B53F78E">>}, etiger:tiger(<<"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq">>)),
     ?_assertMatch({ok, <<"8DCEA680A17583EE502BA38A3C368651890FFBCCDC49A8CC">>}, etiger:tiger(<<"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789">>)),
     ?_assertMatch({ok, <<"1C14795529FD9F207A958F84C52F11E887FA0CABDFD91BFD">>}, etiger:tiger(<<"12345678901234567890123456789012345678901234567890123456789012345678901234567890">>)),
     ?_assertMatch({ok, <<"6DB0E2729CBEAD93D715C6A7D36302E9B3CEE0D2BC314B41">>}, etiger:tiger( million_times_a() ))
    ].

tiger_set_two_test_() ->
    [
     ?_assertMatch({ok, <<"3293AC630C13F0245F92BBB1766E16167A4E58492DDE73F3">>}, etiger:tiger(<<>>)),
     ?_assertMatch({ok, <<"AABBCCA084ACECD0511D1F6232A17BFAEFA441B2982E5548">>}, etiger:tiger(<<0:16>>))
    ].

tiger_set_four_test_() ->
    [
     ?_assertMatch({ok, <<"CDDDCACFEA7B70B485655BA3DC3F60DEE4F6B8F861069E33">>}, etiger:tiger(<<0:192>>))
    ].

%%
%% http://www.cs.technion.ac.il/~biham/Reports/Tiger/tiger2-test-vectors-nessie-format.dat
%%
tiger2_set_one_test_() ->
    [
     ?_assertMatch({ok, <<"4441BE75F6018773C206C22745374B924AA8313FEF919F41">>}, etiger:tiger2(<<>>)),
     ?_assertMatch({ok, <<"4441BE75F6018773C206C22745374B924AA8313FEF919F41">>}, etiger:tiger2(<<"">>)),
     
     ?_assertMatch({ok, <<"67E6AE8E9E968999F70A23E72AEAA9251CBC7C78A7916636">>}, etiger:tiger2(<<"a">>)),
     ?_assertMatch({ok, <<"F68D7BC5AF4B43A06E048D7829560D4A9415658BB0B1F3BF">>}, etiger:tiger2(<<"abc">>)),
     ?_assertMatch({ok, <<"E29419A1B5FA259DE8005E7DE75078EA81A542EF2552462D">>}, etiger:tiger2(<<"message digest">>)),
     ?_assertMatch({ok, <<"F5B6B6A78C405C8547E91CD8624CB8BE83FC804A474488FD">>}, etiger:tiger2(<<"abcdefghijklmnopqrstuvwxyz">>)),
     ?_assertMatch({ok, <<"A6737F3997E8FBB63D20D2DF88F86376B5FE2D5CE36646A9">>}, etiger:tiger2(<<"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq">>)),
     ?_assertMatch({ok, <<"EA9AB6228CEE7B51B77544FCA6066C8CBB5BBAE6319505CD">>}, etiger:tiger2(<<"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789">>)),
     ?_assertMatch({ok, <<"D85278115329EBAA0EEC85ECDC5396FDA8AA3A5820942FFF">>}, etiger:tiger2(<<"12345678901234567890123456789012345678901234567890123456789012345678901234567890">>)),
     ?_assertMatch({ok, <<"E068281F060F551628CC5715B9D0226796914D45F7717CF4">>}, etiger:tiger2( million_times_a() ))
    ].

tiger2_set_four_test_() ->
    [
     ?_assertMatch({ok, <<"1DE8974FA4CBE84A99FD35F7FAF6F12BA07BCD6E4D8E745B">>}, etiger:tiger2(<<0:192>>))
    ].
