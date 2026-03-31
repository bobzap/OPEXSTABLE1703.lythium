# CLAUDE.md

Ce fichier fournit des instructions à Claude Code (claude.ai/code) pour travailler avec le code de ce dépôt.

## Présentation du projet

OPEX (Opérations Extérieures) est un framework de mission coopérative Arma 3 (1-50 joueurs) par GEMINI. Version 2.061. Le code est entièrement en **SQF** (langage de script d'Arma 3), accompagné de fichiers de config HPP, de données de mission SQM et de localisation XML.

Les commentaires et logs sont principalement en **français**, les noms de variables et fonctions en anglais.

## Exécution et test

- **Lancer** : Charger le dossier mission dans l'éditeur Eden d'Arma 3, cliquer sur Jouer
- **Multijoueur** : Héberger un serveur dédié avec cette mission
- **Mode debug** : Mettre `OPEX_debug = true` dans `init.sqf:17`
- **Passer l'intro** : Mettre `OPEX_intro = false` dans `init.sqf:18`
- **Debug territoire** : Mettre `OPEX_territory_debug = true` et `OPEX_territory_verboseLogging = true` dans `scripts/Territory/init.sqf`
- **Console debug** : Activée pour les admins via `description.ext:29` (`enableDebugConsole = 1`)
- Aucun système de build, linter ou framework de test — les tests se font en jeu

## Architecture

### Flux d'initialisation

1. **`init.sqf`** (s'exécute sur TOUTES les machines) — compile les fonctions BIS, charge les settings, initialise les tâches, lance tous les modules ambiants (civils, patrouilles, IED, garnisons, etc.), charge les scripts tiers, démarre le moniteur du système territorial, configure la simulation dynamique
2. **`initServer.sqf`** (serveur uniquement) — charge/crée les sauvegardes persistantes, initialise l'état des tâches et la réanimation, compile le système territorial via `scripts/Territory/init.sqf`, configure les supports/heure/renseignement depuis les paramètres, nomme les véhicules et l'IA
3. **`initPlayerLocal.sqf`** (par client) — vérifie les mods, charge la persistance joueur ou lance le menu de configuration initial, affiche le journal/briefing, ajoute les actions joueur, lance la séquence d'intro, gère la synchronisation JIP (Join In Progress)

### Système de fonctions

Toutes les fonctions custom utilisent l'espace de noms `Gemini_fnc_*`, enregistrées dans `CfgFunctions` via `scripts/Gemini/hpp_functions.hpp`. Il y a plus de 179 fonctions dans `scripts/Gemini/`. Les fonctions marquées `preInit = 1` sont compilées avant le démarrage de la mission.

### Sous-systèmes principaux

- **Settings** (`settings/`) : Configuration modulaire chargée via `settings/init.sqf`. Configs par carte, par faction (ennemis/amis/civils), coûts, gameplay — chacune avec plusieurs presets de mods (vanilla, CUP, CFP, LOP, 3CB, RHS)
- **Tâches** (`tasks/`) : Générateur dynamique de tâches avec plusieurs types. Liste dans `tasks/taskList.sqf`, fonctions dans `Gemini_fnc_taskFunctions`
- **Persistance** : Utilise `profileNamespace` pour sauvegarder/charger l'état. Persistance serveur via les fonctions `Gemini_fnc_persistence_*`. Données serveur et client séparées
- **Supports** (`supports/`) : Actions de soutien achetables par les joueurs (frappes aériennes, ravitaillement, transport). Contrôlés par les variables `OPEX_support_*` et l'économie de renseignement
- **Système territorial** (`scripts/Territory/`) : Sous-système récent pour le contrôle territorial avec chefs de village, communications radio, réputation/pénalités et missions modulaires. Fonctions compilées manuellement via `preprocessFileLineNumbers` dans `scripts/Territory/init.sqf` (pas via CfgFunctions)

### Scripts tiers (`scripts/`)

Scripts communautaires intégrés : R3F logistique (`R3F/LOG/`), R3F ciblage IA (`R3F/AiComTarget/`), Duda remorquage/élingage, BangaBob traîner les corps, Code34 météo dynamique, TPW HUD/mobilier, Psychobastard AIS, AFAR radio, ShackTac gestes carte, Viperidae immersion. Beaucoup sont chargés conditionnellement selon les mods installés (ACE, bcombat, ASR AI, TFR).

### Synchronisation multijoueur

L'état est synchronisé via `publicVariable` pour les variables clés : `OPEX_assignedTask`, `OPEX_stats_faction`, `OPEX_support_*`, `OPEX_playingPlayers`, `OPEX_entities`. Exécution distante via `remoteExec`/`remoteExecCall` pour les appels inter-machines.

### Compatibilité mods

La mission détecte et s'adapte automatiquement aux mods optionnels en vérifiant `configFile >> "CfgPatches"` :
- ACE : Désactive les alternatives intégrées (immersion Viperidae, gestes ShackTac)
- TFR/ACRE : Configuration radio
- CUP/RHS/3CB/CFP/LOP : Factions, véhicules, armes supplémentaires via les fichiers settings
- VCOM AI : Désactivé de force à cause de problèmes connus

## Fichiers de configuration clés

- `description.ext` — Config principale de la mission : CfgFunctions, respawn, réanimation, dialogues (includes HPP)
- `settings/init.sqf` — Charge tous les settings carte/faction/mod dans l'ordre
- `scripts/Gemini/hpp_defines.hpp` — Constantes et macros utilisées partout
- `stringtable.xml` — Toutes les chaînes localisées (multi-langues)

## Conventions

- Fichiers de fonctions : `scripts/Gemini/fnc_<nom>.sqf` correspondant au nom de classe CfgFunctions
- Fichiers territoire : `scripts/Territory/fnc_<nom>.sqf` ou dans les sous-dossiers (`Communications/`, `Detection/`, `Missions/`)
- Variables globales : préfixe `OPEX_` pour l'état de la mission, `OPEX_param_` pour les paramètres, `OPEX_stats_` pour les statistiques
- Modules ambiants : pattern `Gemini_fnc_ambient<Type><SousType>` (ex: `ambientEnemyPatrols`, `ambientCivilianLife`)
- Les compositions dans `composition/` définissent des agencements d'objets prédéfinis (positions AA, nids MG, etc.)
- Les loadouts dans `loadouts/` définissent l'équipement des unités par faction
