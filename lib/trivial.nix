{ self, nixpkgs, ... }:

let
  inherit (nixpkgs.lib) foldAttrs optionalAttrs listToAttrs mapAttrsToList nameValuePair any all id foldl' getAttr;

in with self; {
  /* Concatenate strings.

     Type:
       concatStr :: String -> String -> String
  */
  concatStr = a: b: a + b;

  /* Concatenate lists.

     Type:
       concatList :: [a] -> [a] -> [a]
  */
  concatList = a: b: a ++ b;

  /* Merge attribute sets.

     Type:
       mergeAttrs :: AttrSet -> AttrSet -> AttrSet
  */
  mergeAttrs = a: b: a // b;

  /* Prepend a prefix to a list of strings.

     Type:
       prefixWith :: String -> [String] -> [String]
  */
  prefixWith = prefix: map (concatStr prefix);

  /* Merge a list of attribute sets.

     Type:
       mergeAttrs :: [AttrSet] -> AttrSet
  */
  mergeAttrs = foldl' mergeAttrs {};

  /* Like `mergeAttrs' but merge the first level instead of top level.

     Type:
       mergeAttrsFirstLevel :: [AttrSet] -> AttrSet
  */
  mergeAttrsFirstLevel = foldAttrs mergeAttrs {};

  /* Apply optionalAttrs on each attribute set from the list.
     Each element in the list is of the form as follow:
       { cond = expr; as = attrset; }

     Type:
       evalOptionalAttrsList :: [AttrSet] -> [AttrSet]
  */
  evalOptionalAttrsList = map (a: optionalAttrs a.cond a.as);

  /* Return the first non-null value between a and b.
     If both are null the result is null.

     Type:
       either :: a -> a -> a
  */
  either = a: b: if null != a then a else if null != b then b else null;

  /* Like `either' but a default return value can be specified.

     Type:
       either' :: a -> a -> a -> a
  */
  either' = a: b: r: let x = either a b; in if null != x then x else r;

  /* Return the first argument passed to this function.

     Type:
       pairName :: a -> a -> a
  */
  pairName = n: v: n;

  /* Return the second argument passed to this function.

     Type:
       pairName :: a -> a -> a
  */
  pairValue = n: v: v;

  /* Map a list to an attrs.

     `fn' and `fv' are used to map each element from the list to the name and
     value respectively.

     Type:
       mapListToAttrs :: (a -> String) -> (a -> a) -> [a] -> AttrSet
  */
  mapListToAttrs = fn: fv: list:
    listToAttrs (map (i: nameValuePair (fn i) (fv i)) list);

  /* Return true if the function pred returns true for at least one element of
     attrs, and false otherwise.

     Type:
       anyAttrs :: (String -> a -> Bool) -> AttrSet -> Bool

  */
  anyAttrs = pred: attrs: any id (mapAttrsToList pred attrs);

  /* Return true if the function pred returns true for all elements of attrs,
     and false otherwise.

     Type:
       anyAttrs :: (String -> a -> Bool) -> AttrSet -> Bool
  */
  allAttrs = pred: attrs: all id (mapAttrsToList pred attrs);

  /* Get attribute base on a list of names.
     This is useful for nested access.

     Type:
       getAttrs :: [String] -> AttrSet -> a
  */
  getAttrs = names: attrs: foldl' (a: n: getAttr n a) attrs names;

  /* Logic not.

     Type:
       not :: Bool -> Bool
  */
  not = a: !a;

  /* Logic and.

     Type:
       and :: Bool -> Bool -> Bool
  */
  and = a: b: a && b;

  /* logic or.

     Type:
       and :: Bool -> Bool -> Bool
  */
  or = a: b: a || b;

  /* Comparison equal to.

     Type:
       eq :: a -> a -> Bool
  */
  eq = a: b: a == b;

  /* Comparison not equal to.

     Type:
       ne :: a -> a -> Bool
  */
  ne = a: b: a != b;

  /* Comparison greater than.

     Type:
       gt :: a -> a -> Bool
  */
  gt = a: b: a > b;

  /* Comparison greater than or equal to.

     Type:
       ge :: a -> a -> Bool
  */
  ge = a: b: a >= b;

  /* Comparison less than.

     Type:
       lt :: a -> a -> Bool
  */
  lt = a: b: a < b;

  /* Comparison less than or equal to.

     Type:
       le :: a -> a -> Bool
  */
  le = a: b: a <= b;

  /* Increment by 1.

     Type:
       addOne :: a -> a
  */
  addOne = a: a + 1;

  /* Decrement by 1.

     Type:
       addOne :: a -> a
  */
  minusOne = a: a - 1;

  /* Apply a list of arguments to the function.

     Type:
       apply :: (a -> a) -> [a]
  */
  apply = foldl' (f: x: f x)

  /* Filter the return value of the original function.

     Note that n (the number of arguments) must be greater than 0 since a
     function should at least have one argument.  This is required because for
     curried functions the number of arguments can not be known beforehand.  The
     caller must tell this function where to end.

     Type:
       wrapReturn :: Int -> (a -> a) -> (a -> ... -> a)
  */
  wrapReturn = n: wf: f:
    let wrap = f: n: a: if n == 1 then wf (f a) else wrap (f a) (n - 1);
    in assert n > 0; wrap f n;

  /* Filter the arguments of the original function.

     Note that n (the number of arguments) must be greater than 0 since a
     function should at least have one argument.  This is required because for
     curried functions the number of arguments can not be known beforehand.  The
     caller must tell the wrapper function where to end.

     The wrapper function must have the same signature of the original function
     and return a list of altered arguments.

     Type:
       wrapArgs :: Int -> (a -> ... -> [a]) -> (a -> ... -> a)
  */
  wrapArgs = n: wf: f:
    let wrap = wf: n: a: if n == 1 then apply f (wf a) else wrap (wf a) (n - 1);
    in assert n > 0; wrap wf n;
}