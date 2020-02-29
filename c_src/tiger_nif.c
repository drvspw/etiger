#include <string.h>
#include "erl_nif.h"
#include "tiger.h"

static ERL_NIF_TERM
mk_atom(ErlNifEnv* env, const char* atom)
{
    ERL_NIF_TERM ret;

    if(!enif_make_existing_atom(env, atom, &ret, ERL_NIF_LATIN1))
    {
        return enif_make_atom(env, atom);
    }

    return ret;
}

static ERL_NIF_TERM
mk_error(ErlNifEnv* env, const char* mesg)
{
    return enif_make_tuple2(env, mk_atom(env, "error"), mk_atom(env, mesg));
}

static ERL_NIF_TERM generate_tiger_hash(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[], void (*hash_fun)(char [], const void *, size_t)) {
  ErlNifBinary hash, data;
   
  // Validate the arguments
  if( (argc != 1) ||
      (!enif_inspect_binary(env, argv[0], &data)) ) {
    return enif_make_badarg(env);
  }

  // Allocate binary for return value
  if( !enif_alloc_binary(TIGER_BYTES*2, &hash) ) {
    return mk_error(env, "alloc_failed");
  }

  // Generate the hash
  char str[TIGER_STR_BYTES];
  hash_fun(str, data.data, data.size);

  // Generate the return term
  memcpy(hash.data, str, hash.size);
  ERL_NIF_TERM ok =  enif_make_atom(env, "ok");
  ERL_NIF_TERM ret = enif_make_binary(env, &hash);
    
  return enif_make_tuple2(env, ok, ret);
}

static ERL_NIF_TERM tiger_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  return generate_tiger_hash(env, argc, argv, tiger_str);
}

static ERL_NIF_TERM tiger2_nif(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  return generate_tiger_hash(env, argc, argv, tiger2_str);
}

static ErlNifFunc nif_funcs[] = {
  {"tiger", 1, tiger_nif},
  {"tiger2", 1, tiger2_nif},
};

ERL_NIF_INIT(etiger, nif_funcs, NULL, NULL, NULL, NULL);

