(* The wizard wars are raging. *)

(* The wizards combating in this war are of these races.  *)
type race = Orc | Hobbit | Human


(* There are spells of three schools of magic: firewall and blaze are fire
   spells, resurrect and cripple are of the necrotic school, and renounce and
   banish are angelic.

   Define a type to represent the schools, and a type of spells.
*)


type school = Fire | Necrotic | Angelic


type spell = Firewall | Blaze
			| Resurrect | Cripple
			| Renounce | Banish

(* The skills a wizard has mastered are the list of spells he can cast in one
   round. Define a type `skills'. *)
type skills = spell list

type mana = int
type health = int

(* A wizard has to be given a name, a number of hitpoints (hp), an ability
   level of mana, a race, and the skills he has mastered. Use a record to
   represent this. *)
type wizard = {name : string; hp : health; ability : mana;  race : race ; skills : skills;}


(* Write a function that indicates for each spell which school it belongs to. *)
let school_of_spell spell = 
 match spell with
  | Firewall | Blaze -> Fire
  | Resurrect | Cripple -> Necrotic
  | Renounce | Banish -> Angelic
  
(* Write a function that computes the mana each spell uses. The values are:
  blaze : 420
  firewall : 35
  renounce : 17
  banish : 103
  resurrect : 178
  cripple : 250

   Hint: use regex-replace in Notepad++
 *)
let mana_of_spell : spell -> mana = function
 | blaze -> 420
 | firewall -> 35
 | renounce -> 17
 | banish -> 103
 | resurrect -> 178
 | cripple -> 250

(* Use regex-replace in Notepad++ to build a few example wizards, like merlin *)
(*
name : "Frodo",      ability : 53,   hp : 1000,  skills : [Renounce],                      race : Hobbit
name : "Ajitam",     ability : 1337, hp : 7331,  skills : [Firewall; Resurrect; Firewall], race : Hobbit
name : "Mr Duck",    ability : 7,    hp : 90000, skills : [Cripple],                       race : Orc
name : "Kylo Ren",   ability : 589,  hp : 90,    skills : [Resurrect],                     race : Human
name : "Snoop Dogg", ability : 420,  hp : 4000,  skills : [Blaze],                         race : Orc
*)

(* let merlin = {name = "Merlin";   ability = 1832; hp = 9001; skills = [Renounce; Banish];  race = Human} *)
let frodo =  {name = "Frodo"; ability = 53; hp = 1000; skills = [Renounce]; race = Hobbit}
let ajitam = {name = "Ajitam"; ability = 1337; hp = 7331; skills = [Firewall; Resurrect; Firewall]; race = Hobbit}
let mrDuck = {name = "Mr Duck"; ability = 7; hp = 90000; skills = [Cripple]; race = Orc}
let kYloReN = {name = "Kylo Ren"; ability = 589; hp = 90; skills = [Resurrect]; race = Human}
let snoop_dogg = {name = "Snoop Dogg"; ability = 420; hp = 4000; skills = [Blaze]; race = Orc}

type 'a option = None | Some w

(* Write a function that computes the wizard with the most mana. *)
let rec strongest_wizard (wizards : wizard list) : wizard option =
  match wizards with
  | [] -> None
  | w :: ws -> 
    let strongest_ws = strongest_wizard ws in
	(match strongest_ws with
	 | None -> Some w
	 | Some v -> if w.ability > v.ability
	   then Some w
	   else Some v)

(* Generalise strongest_wizard to a function max_list that computes the max of
   an arbitrary lists of type 'a.

   It takes as additional argument a function
     max : 'a -> 'a -> 'a
   that is used for taking the maximum between two elements.
*)

let rec max_list (xs : 'a list) (max : 'a -> 'a -> 'a) : 'a option =
  match xs with
  | [] -> None
  | x :: xs ->
    ( match max_list xs max with
	  | None -> Some x
	  | Some y -> Some (max x y)
	)

(* Races have either high, normal, or low vulnerability to each school of
   magic. Represent these possibilities as a variant type. *)

type vulnerability = High | Normal | Low

(* Write a function that computes the following vulnerabilities:
   Low vulnerability for orcs:necrotic, hobbits:fire, humans:angelic,
   High vulnerability    hobbit:necrotic, human:fire, orc:angelic
   otherwise normal
  *)

let effectiveness (school : school) (race : race) : vulnerability =
  match (race, school) with
  | (Orc, Necrotic) | (Human, Angelic) | (Hobbit,Fire) -> Low
  | (Orc, Angelic) | (Human, Fire) | (Hobbit, Necrotic) -> High
  |  _ -> Normal
 

(* Write a function that computes how vulnerable a wizard is to a spell *)
let vulnerable wizard spell = effectiveness (school_of_spell spell) wizard.race


(* Write a function that computes a damage coefficient. High vulnerability
   incurs double damage, low vulnerability half damage. *)
   
let coefficient vulnerability = function
  | High -> Double
  | Low -> Half
  | Normal ->


(* Write a function that calculates how much damages a spell causes to a
   wizard, computed as the mana it uses times the vulnerability coefficient.
   Hint: float_of_int
*)


(* Write a function that calculates the stats of a wizard after getting
   attacked by a particular spell.  *)


(* Write a function cast_spells that casts each of the skills of a wizard, or
   as many as he has mana for. Return the updated caster and the list of
   spells he managed to cast *)
let cast_spells (caster : wizard) : wizard * spell list = failwith "todo"


(* Write a function that stands off two wizard in a duel. If the attacker is
   dead, the defender wins. The attacker, if he is still alive, casts his
   spells. If he cannot cast any spells, he loses. After the attacker casts
   his spells, the roles change and the defender takes his turn to attack. *)
let rec duel (attacker : wizard) (defender : wizard) : wizard =
  failwith "todo"

let _ = duel frodo snoop_dogg
