type loc = int
[@@deriving show]

type typ' =
  | TInt
  | TFloat
  | TBool
  | TString
  | TChar
  | TUnit
  | TFun of typ' * typ'
  | TTuple of typ' * typ'
  | TRecord of string
  | TList of typ'
  | TSecret of typ'
  | TPublic of typ'
  | TVar of int
[@@deriving show]

type expr =
  | L of loc * literal
  | C of loc * complex
  | Var of loc * string
  | LetIn of loc * string * typ' * expr * expr
  | LetRecIn of loc * string * typ' * expr * expr
  | Fun of loc * string * typ' * expr
  | Match of loc * expr * typ' * (match_branch * expr) list
  | App of loc * expr * (expr * typ')
  | Seq of loc * expr * expr

and literal =
  (* Simple literals *)
  | Unit
  | Int of int
  | Float of float
  | String of string
  | Char of char
  | Bool of bool

and complex =
  | Tuple of expr * expr
  | Record of string * expr list
  | Nil
  | Cons of expr * expr

and match_branch =
  | ML of loc * literal
  | MVar of loc * string
  | Blank of loc
  (* Simplify complex types for binding *)
  | MTuple of loc * match_branch * match_branch
  | MRecord of loc * string * match_branch list
  | MNil of loc
  | MCons of loc * match_branch * match_branch
[@@deriving show]

type stmt =
  | Let of loc * string * typ' * expr
  | LetRec of loc * string * typ' * expr
  | Type of loc * string * (string * typ' list option) list
[@@deriving show]

type program = stmt list
[@@deriving show]
