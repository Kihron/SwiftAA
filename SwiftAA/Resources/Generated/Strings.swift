// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Never
  internal static let never = L10n.tr("Localizable", "never", fallback: "Never")
  /// Overlay
  internal static let overlay = L10n.tr("Localizable", "overlay", fallback: "Overlay")
  /// Player
  internal static let player = L10n.tr("Localizable", "player", fallback: "Player")
  internal enum About {
    /// About SwiftAA
    internal static let button = L10n.tr("Localizable", "about.button", fallback: "About SwiftAA")
    /// Copyright © 2023 Kihron, Slackow.
    internal static let copyright = L10n.tr("Localizable", "about.copyright", fallback: "Copyright © 2023 Kihron, Slackow.")
    /// All Advancements Tracker for macOS
    internal static let description = L10n.tr("Localizable", "about.description", fallback: "All Advancements Tracker for macOS")
  }
  internal enum Advancement {
    internal enum Adventure {
      /// Arbalistic
      internal static let arbalistic = L10n.tr("Localizable", "advancement.adventure.arbalistic", fallback: "Arbalistic")
      /// Bullseye
      internal static let bullseye = L10n.tr("Localizable", "advancement.adventure.bullseye", fallback: "Bullseye")
      /// Adventure
      internal static let root = L10n.tr("Localizable", "advancement.adventure.root", fallback: "Adventure")
      /// What a Deal!
      internal static let trade = L10n.tr("Localizable", "advancement.adventure.trade", fallback: "What a Deal!")
      internal enum Adventuring {
        /// Adventuring Time
        internal static let time = L10n.tr("Localizable", "advancement.adventure.adventuring.time", fallback: "Adventuring Time")
      }
      internal enum Avoid {
        /// Sneak 100
        internal static let vibration = L10n.tr("Localizable", "advancement.adventure.avoid.vibration", fallback: "Sneak 100")
      }
      internal enum Biomes {
        internal enum Visited {
          /// Badlands
          internal static let badlands = L10n.tr("Localizable", "advancement.adventure.biomes.visited.badlands", fallback: "Badlands")
          /// Beach
          internal static let beach = L10n.tr("Localizable", "advancement.adventure.biomes.visited.beach", fallback: "Beach")
          /// Desert
          internal static let desert = L10n.tr("Localizable", "advancement.adventure.biomes.visited.desert", fallback: "Desert")
          /// Forest
          internal static let forest = L10n.tr("Localizable", "advancement.adventure.biomes.visited.forest", fallback: "Forest")
          /// Grove
          internal static let grove = L10n.tr("Localizable", "advancement.adventure.biomes.visited.grove", fallback: "Grove")
          /// Jungle
          internal static let jungle = L10n.tr("Localizable", "advancement.adventure.biomes.visited.jungle", fallback: "Jungle")
          /// Meadow
          internal static let meadow = L10n.tr("Localizable", "advancement.adventure.biomes.visited.meadow", fallback: "Meadow")
          /// Mountains
          internal static let mountains = L10n.tr("Localizable", "advancement.adventure.biomes.visited.mountains", fallback: "Mountains")
          /// Ocean
          internal static let ocean = L10n.tr("Localizable", "advancement.adventure.biomes.visited.ocean", fallback: "Ocean")
          /// Plains
          internal static let plains = L10n.tr("Localizable", "advancement.adventure.biomes.visited.plains", fallback: "Plains")
          /// River
          internal static let river = L10n.tr("Localizable", "advancement.adventure.biomes.visited.river", fallback: "River")
          /// Savanna
          internal static let savanna = L10n.tr("Localizable", "advancement.adventure.biomes.visited.savanna", fallback: "Savanna")
          /// Swamp
          internal static let swamp = L10n.tr("Localizable", "advancement.adventure.biomes.visited.swamp", fallback: "Swamp")
          /// Taiga
          internal static let taiga = L10n.tr("Localizable", "advancement.adventure.biomes.visited.taiga", fallback: "Taiga")
          internal enum Badlands {
            /// Badlands Plateau
            internal static let plateau = L10n.tr("Localizable", "advancement.adventure.biomes.visited.badlands.plateau", fallback: "Badlands Plateau")
          }
          internal enum Bamboo {
            /// Bamboo Jungle
            internal static let jungle = L10n.tr("Localizable", "advancement.adventure.biomes.visited.bamboo.jungle", fallback: "Bamboo Jungle")
            internal enum Jungle {
              /// Bamboo Hills
              internal static let hills = L10n.tr("Localizable", "advancement.adventure.biomes.visited.bamboo.jungle.hills", fallback: "Bamboo Hills")
            }
          }
          internal enum Birch {
            /// Birch Forest
            internal static let forest = L10n.tr("Localizable", "advancement.adventure.biomes.visited.birch.forest", fallback: "Birch Forest")
            internal enum Forest {
              /// Birch Hills
              internal static let hills = L10n.tr("Localizable", "advancement.adventure.biomes.visited.birch.forest.hills", fallback: "Birch Hills")
            }
          }
          internal enum Cold {
            /// Cold Ocean
            internal static let ocean = L10n.tr("Localizable", "advancement.adventure.biomes.visited.cold.ocean", fallback: "Cold Ocean")
          }
          internal enum Dark {
            /// Dark Forest
            internal static let forest = L10n.tr("Localizable", "advancement.adventure.biomes.visited.dark.forest", fallback: "Dark Forest")
          }
          internal enum Deep {
            /// Deep Dark
            internal static let dark = L10n.tr("Localizable", "advancement.adventure.biomes.visited.deep.dark", fallback: "Deep Dark")
            /// Deep Ocean
            internal static let ocean = L10n.tr("Localizable", "advancement.adventure.biomes.visited.deep.ocean", fallback: "Deep Ocean")
            internal enum Cold {
              /// Deep Cold Ocean
              internal static let ocean = L10n.tr("Localizable", "advancement.adventure.biomes.visited.deep.cold.ocean", fallback: "Deep Cold Ocean")
            }
            internal enum Frozen {
              /// Deep Frozen
              internal static let ocean = L10n.tr("Localizable", "advancement.adventure.biomes.visited.deep.frozen.ocean", fallback: "Deep Frozen")
            }
            internal enum Lukewarm {
              /// Deep Lukewarm
              internal static let ocean = L10n.tr("Localizable", "advancement.adventure.biomes.visited.deep.lukewarm.ocean", fallback: "Deep Lukewarm")
            }
          }
          internal enum Desert {
            /// Desert Hills
            internal static let hills = L10n.tr("Localizable", "advancement.adventure.biomes.visited.desert.hills", fallback: "Desert Hills")
          }
          internal enum Dripstone {
            /// Dripstone Caves
            internal static let caves = L10n.tr("Localizable", "advancement.adventure.biomes.visited.dripstone.caves", fallback: "Dripstone Caves")
          }
          internal enum Eroded {
            /// Eroded Badlands
            internal static let badlands = L10n.tr("Localizable", "advancement.adventure.biomes.visited.eroded.badlands", fallback: "Eroded Badlands")
          }
          internal enum Flower {
            /// Flower Forest
            internal static let forest = L10n.tr("Localizable", "advancement.adventure.biomes.visited.flower.forest", fallback: "Flower Forest")
          }
          internal enum Frozen {
            /// Frozen Ocean
            internal static let ocean = L10n.tr("Localizable", "advancement.adventure.biomes.visited.frozen.ocean", fallback: "Frozen Ocean")
            /// Frozen Peaks
            internal static let peaks = L10n.tr("Localizable", "advancement.adventure.biomes.visited.frozen.peaks", fallback: "Frozen Peaks")
            /// Frozen River
            internal static let river = L10n.tr("Localizable", "advancement.adventure.biomes.visited.frozen.river", fallback: "Frozen River")
          }
          internal enum Giant {
            internal enum Tree {
              /// Mega Taiga
              internal static let taiga = L10n.tr("Localizable", "advancement.adventure.biomes.visited.giant.tree.taiga", fallback: "Mega Taiga")
              internal enum Taiga {
                /// Mega Taiga Hill
                internal static let hills = L10n.tr("Localizable", "advancement.adventure.biomes.visited.giant.tree.taiga.hills", fallback: "Mega Taiga Hill")
              }
            }
          }
          internal enum Ice {
            /// Ice Spikes
            internal static let spikes = L10n.tr("Localizable", "advancement.adventure.biomes.visited.ice.spikes", fallback: "Ice Spikes")
          }
          internal enum Jagged {
            /// Jagged Peaks
            internal static let peaks = L10n.tr("Localizable", "advancement.adventure.biomes.visited.jagged.peaks", fallback: "Jagged Peaks")
          }
          internal enum Jungle {
            /// Jungle Edge
            internal static let edge = L10n.tr("Localizable", "advancement.adventure.biomes.visited.jungle.edge", fallback: "Jungle Edge")
            /// Jungle Hills
            internal static let hills = L10n.tr("Localizable", "advancement.adventure.biomes.visited.jungle.hills", fallback: "Jungle Hills")
          }
          internal enum Lukewarm {
            /// Lukewarm Ocean
            internal static let ocean = L10n.tr("Localizable", "advancement.adventure.biomes.visited.lukewarm.ocean", fallback: "Lukewarm Ocean")
          }
          internal enum Lush {
            /// Lush Caves
            internal static let caves = L10n.tr("Localizable", "advancement.adventure.biomes.visited.lush.caves", fallback: "Lush Caves")
          }
          internal enum Mangrove {
            /// Mangrove Swamp
            internal static let swamp = L10n.tr("Localizable", "advancement.adventure.biomes.visited.mangrove.swamp", fallback: "Mangrove Swamp")
          }
          internal enum Mushroom {
            /// Mushroom Fields
            internal static let fields = L10n.tr("Localizable", "advancement.adventure.biomes.visited.mushroom.fields", fallback: "Mushroom Fields")
            internal enum Field {
              /// Mushroom Shore
              internal static let shore = L10n.tr("Localizable", "advancement.adventure.biomes.visited.mushroom.field.shore", fallback: "Mushroom Shore")
            }
          }
          internal enum Old {
            internal enum Growth {
              internal enum Birch {
                /// Old Birch
                internal static let forest = L10n.tr("Localizable", "advancement.adventure.biomes.visited.old.growth.birch.forest", fallback: "Old Birch")
              }
              internal enum Pine {
                /// Old Pine
                internal static let taiga = L10n.tr("Localizable", "advancement.adventure.biomes.visited.old.growth.pine.taiga", fallback: "Old Pine")
              }
              internal enum Spruce {
                /// Old Spruce
                internal static let taiga = L10n.tr("Localizable", "advancement.adventure.biomes.visited.old.growth.spruce.taiga", fallback: "Old Spruce")
              }
            }
          }
          internal enum Savanna {
            /// Savanna Plat
            internal static let plateau = L10n.tr("Localizable", "advancement.adventure.biomes.visited.savanna.plateau", fallback: "Savanna Plat")
          }
          internal enum Snowy {
            /// Snowy Beach
            internal static let beach = L10n.tr("Localizable", "advancement.adventure.biomes.visited.snowy.beach", fallback: "Snowy Beach")
            /// Snowy Mountain
            internal static let mountains = L10n.tr("Localizable", "advancement.adventure.biomes.visited.snowy.mountains", fallback: "Snowy Mountain")
            /// Snowy Plains
            internal static let plains = L10n.tr("Localizable", "advancement.adventure.biomes.visited.snowy.plains", fallback: "Snowy Plains")
            /// Snowy Slopes
            internal static let slopes = L10n.tr("Localizable", "advancement.adventure.biomes.visited.snowy.slopes", fallback: "Snowy Slopes")
            /// Snowy Taiga
            internal static let taiga = L10n.tr("Localizable", "advancement.adventure.biomes.visited.snowy.taiga", fallback: "Snowy Taiga")
            /// Snowy Tundra
            internal static let tundra = L10n.tr("Localizable", "advancement.adventure.biomes.visited.snowy.tundra", fallback: "Snowy Tundra")
            internal enum Taiga {
              /// Snowy Taiga Hill
              internal static let hills = L10n.tr("Localizable", "advancement.adventure.biomes.visited.snowy.taiga.hills", fallback: "Snowy Taiga Hill")
            }
          }
          internal enum Sparse {
            /// Sparse Jungle
            internal static let jungle = L10n.tr("Localizable", "advancement.adventure.biomes.visited.sparse.jungle", fallback: "Sparse Jungle")
          }
          internal enum Stone {
            /// Stone Shore
            internal static let shore = L10n.tr("Localizable", "advancement.adventure.biomes.visited.stone.shore", fallback: "Stone Shore")
          }
          internal enum Stony {
            /// Stony Peaks
            internal static let peaks = L10n.tr("Localizable", "advancement.adventure.biomes.visited.stony.peaks", fallback: "Stony Peaks")
            /// Stony Shore
            internal static let shore = L10n.tr("Localizable", "advancement.adventure.biomes.visited.stony.shore", fallback: "Stony Shore")
          }
          internal enum Sunflower {
            /// Sunflowers
            internal static let plains = L10n.tr("Localizable", "advancement.adventure.biomes.visited.sunflower.plains", fallback: "Sunflowers")
          }
          internal enum Taiga {
            /// Taiga Hills
            internal static let hills = L10n.tr("Localizable", "advancement.adventure.biomes.visited.taiga.hills", fallback: "Taiga Hills")
          }
          internal enum Warm {
            /// Warm Ocean
            internal static let ocean = L10n.tr("Localizable", "advancement.adventure.biomes.visited.warm.ocean", fallback: "Warm Ocean")
          }
          internal enum Windswept {
            /// Windswept Forest
            internal static let forest = L10n.tr("Localizable", "advancement.adventure.biomes.visited.windswept.forest", fallback: "Windswept Forest")
            /// Windswept Hills
            internal static let hills = L10n.tr("Localizable", "advancement.adventure.biomes.visited.windswept.hills", fallback: "Windswept Hills")
            /// Windswept Savanna
            internal static let savanna = L10n.tr("Localizable", "advancement.adventure.biomes.visited.windswept.savanna", fallback: "Windswept Savanna")
            internal enum Gravelly {
              /// Windswept Gravel
              internal static let hills = L10n.tr("Localizable", "advancement.adventure.biomes.visited.windswept.gravelly.hills", fallback: "Windswept Gravel")
            }
          }
          internal enum Wooded {
            /// Wooded Badlands
            internal static let badlands = L10n.tr("Localizable", "advancement.adventure.biomes.visited.wooded.badlands", fallback: "Wooded Badlands")
            /// Wooded Hills
            internal static let hills = L10n.tr("Localizable", "advancement.adventure.biomes.visited.wooded.hills", fallback: "Wooded Hills")
            /// Wooded Mtn
            internal static let mountains = L10n.tr("Localizable", "advancement.adventure.biomes.visited.wooded.mountains", fallback: "Wooded Mtn")
            internal enum Badlands {
              /// Wooded Plateau
              internal static let plateau = L10n.tr("Localizable", "advancement.adventure.biomes.visited.wooded.badlands.plateau", fallback: "Wooded Plateau")
            }
          }
        }
      }
      internal enum Fall {
        internal enum From {
          internal enum World {
            /// Caves and Cliffs
            internal static let height = L10n.tr("Localizable", "advancement.adventure.fall.from.world.height", fallback: "Caves and Cliffs")
          }
        }
      }
      internal enum Hero {
        internal enum Of {
          internal enum The {
            /// Hero of the Village
            internal static let village = L10n.tr("Localizable", "advancement.adventure.hero.of.the.village", fallback: "Hero of the Village")
          }
        }
      }
      internal enum Honey {
        internal enum Block {
          /// Sticky Situation
          internal static let slide = L10n.tr("Localizable", "advancement.adventure.honey.block.slide", fallback: "Sticky Situation")
        }
      }
      internal enum Kill {
        internal enum A {
          /// Monster Hunter
          internal static let mob = L10n.tr("Localizable", "advancement.adventure.kill.a.mob", fallback: "Monster Hunter")
        }
        internal enum All {
          /// Monsters Hunted
          internal static let mobs = L10n.tr("Localizable", "advancement.adventure.kill.all.mobs", fallback: "Monsters Hunted")
        }
        internal enum Mob {
          internal enum Near {
            internal enum Sculk {
              /// It Spreads
              internal static let catalyst = L10n.tr("Localizable", "advancement.adventure.kill.mob.near.sculk.catalyst", fallback: "It Spreads")
            }
          }
        }
      }
      internal enum Lightning {
        internal enum Rod {
          internal enum With {
            internal enum Villager {
              internal enum No {
                /// Surge Protector
                internal static let fire = L10n.tr("Localizable", "advancement.adventure.lightning.rod.with.villager.no.fire", fallback: "Surge Protector")
              }
            }
          }
        }
      }
      internal enum Monsters {
        internal enum Killed {
          /// Blaze
          internal static let blaze = L10n.tr("Localizable", "advancement.adventure.monsters.killed.blaze", fallback: "Blaze")
          /// Creeper
          internal static let creeper = L10n.tr("Localizable", "advancement.adventure.monsters.killed.creeper", fallback: "Creeper")
          /// Drowned
          internal static let drowned = L10n.tr("Localizable", "advancement.adventure.monsters.killed.drowned", fallback: "Drowned")
          /// Enderman
          internal static let enderman = L10n.tr("Localizable", "advancement.adventure.monsters.killed.enderman", fallback: "Enderman")
          /// Endermite
          internal static let endermite = L10n.tr("Localizable", "advancement.adventure.monsters.killed.endermite", fallback: "Endermite")
          /// Evoker
          internal static let evoker = L10n.tr("Localizable", "advancement.adventure.monsters.killed.evoker", fallback: "Evoker")
          /// Ghast
          internal static let ghast = L10n.tr("Localizable", "advancement.adventure.monsters.killed.ghast", fallback: "Ghast")
          /// Guardian
          internal static let guardian = L10n.tr("Localizable", "advancement.adventure.monsters.killed.guardian", fallback: "Guardian")
          /// Hoglin
          internal static let hoglin = L10n.tr("Localizable", "advancement.adventure.monsters.killed.hoglin", fallback: "Hoglin")
          /// Husk
          internal static let husk = L10n.tr("Localizable", "advancement.adventure.monsters.killed.husk", fallback: "Husk")
          /// Phantom
          internal static let phantom = L10n.tr("Localizable", "advancement.adventure.monsters.killed.phantom", fallback: "Phantom")
          /// Piglin
          internal static let piglin = L10n.tr("Localizable", "advancement.adventure.monsters.killed.piglin", fallback: "Piglin")
          /// Pillager
          internal static let pillager = L10n.tr("Localizable", "advancement.adventure.monsters.killed.pillager", fallback: "Pillager")
          /// Ravager
          internal static let ravager = L10n.tr("Localizable", "advancement.adventure.monsters.killed.ravager", fallback: "Ravager")
          /// Shulker
          internal static let shulker = L10n.tr("Localizable", "advancement.adventure.monsters.killed.shulker", fallback: "Shulker")
          /// Silverfish
          internal static let silverfish = L10n.tr("Localizable", "advancement.adventure.monsters.killed.silverfish", fallback: "Silverfish")
          /// Skeleton
          internal static let skeleton = L10n.tr("Localizable", "advancement.adventure.monsters.killed.skeleton", fallback: "Skeleton")
          /// Slime
          internal static let slime = L10n.tr("Localizable", "advancement.adventure.monsters.killed.slime", fallback: "Slime")
          /// Spider
          internal static let spider = L10n.tr("Localizable", "advancement.adventure.monsters.killed.spider", fallback: "Spider")
          /// Stray
          internal static let stray = L10n.tr("Localizable", "advancement.adventure.monsters.killed.stray", fallback: "Stray")
          /// Vex
          internal static let vex = L10n.tr("Localizable", "advancement.adventure.monsters.killed.vex", fallback: "Vex")
          /// Vindicator
          internal static let vindicator = L10n.tr("Localizable", "advancement.adventure.monsters.killed.vindicator", fallback: "Vindicator")
          /// Witch
          internal static let witch = L10n.tr("Localizable", "advancement.adventure.monsters.killed.witch", fallback: "Witch")
          /// Wither
          internal static let wither = L10n.tr("Localizable", "advancement.adventure.monsters.killed.wither", fallback: "Wither")
          /// Zoglin
          internal static let zoglin = L10n.tr("Localizable", "advancement.adventure.monsters.killed.zoglin", fallback: "Zoglin")
          /// Zombie
          internal static let zombie = L10n.tr("Localizable", "advancement.adventure.monsters.killed.zombie", fallback: "Zombie")
          internal enum Cave {
            /// Cave Spider
            internal static let spider = L10n.tr("Localizable", "advancement.adventure.monsters.killed.cave.spider", fallback: "Cave Spider")
          }
          internal enum Elder {
            /// Elder Guardian
            internal static let guardian = L10n.tr("Localizable", "advancement.adventure.monsters.killed.elder.guardian", fallback: "Elder Guardian")
          }
          internal enum Ender {
            /// Ender Dragon
            internal static let dragon = L10n.tr("Localizable", "advancement.adventure.monsters.killed.ender.dragon", fallback: "Ender Dragon")
          }
          internal enum Magma {
            /// Magma Cube
            internal static let cube = L10n.tr("Localizable", "advancement.adventure.monsters.killed.magma.cube", fallback: "Magma Cube")
          }
          internal enum Piglin {
            /// Piglin Brute
            internal static let brute = L10n.tr("Localizable", "advancement.adventure.monsters.killed.piglin.brute", fallback: "Piglin Brute")
          }
          internal enum Wither {
            /// Wither Skeleton
            internal static let skeleton = L10n.tr("Localizable", "advancement.adventure.monsters.killed.wither.skeleton", fallback: "Wither Skeleton")
          }
          internal enum Zombie {
            /// Zombie Villager
            internal static let villager = L10n.tr("Localizable", "advancement.adventure.monsters.killed.zombie.villager", fallback: "Zombie Villager")
          }
          internal enum Zombified {
            /// Zombie Piglin
            internal static let piglin = L10n.tr("Localizable", "advancement.adventure.monsters.killed.zombified.piglin", fallback: "Zombie Piglin")
          }
        }
      }
      internal enum Ol {
        /// Ol' Betsy
        internal static let betsy = L10n.tr("Localizable", "advancement.adventure.ol.betsy", fallback: "Ol' Betsy")
      }
      internal enum Play {
        internal enum Jukebox {
          internal enum In {
            /// Sound of Music
            internal static let meadows = L10n.tr("Localizable", "advancement.adventure.play.jukebox.in.meadows", fallback: "Sound of Music")
          }
        }
      }
      internal enum Shoot {
        /// Take Aim
        internal static let arrow = L10n.tr("Localizable", "advancement.adventure.shoot.arrow", fallback: "Take Aim")
      }
      internal enum Sleep {
        internal enum In {
          /// Sweet
          /// Dreams
          internal static let bed = L10n.tr("Localizable", "advancement.adventure.sleep.in.bed", fallback: "Sweet\nDreams")
        }
      }
      internal enum Sniper {
        /// Sniper Duel
        internal static let duel = L10n.tr("Localizable", "advancement.adventure.sniper.duel", fallback: "Sniper Duel")
      }
      internal enum Spyglass {
        internal enum At {
          /// Is It a Plane?
          internal static let dragon = L10n.tr("Localizable", "advancement.adventure.spyglass.at.dragon", fallback: "Is It a Plane?")
          /// Is It a Balloon?
          internal static let ghast = L10n.tr("Localizable", "advancement.adventure.spyglass.at.ghast", fallback: "Is It a Balloon?")
          /// Is It a Bird?
          internal static let parrot = L10n.tr("Localizable", "advancement.adventure.spyglass.at.parrot", fallback: "Is It a Bird?")
        }
      }
      internal enum Summon {
        internal enum Iron {
          /// Hired Help
          internal static let golem = L10n.tr("Localizable", "advancement.adventure.summon.iron.golem", fallback: "Hired Help")
        }
      }
      internal enum Throw {
        /// A Throwaway Joke
        internal static let trident = L10n.tr("Localizable", "advancement.adventure.throw.trident", fallback: "A Throwaway Joke")
      }
      internal enum Totem {
        internal enum Of {
          /// Postmortal
          internal static let undying = L10n.tr("Localizable", "advancement.adventure.totem.of.undying", fallback: "Postmortal")
        }
      }
      internal enum Trade {
        internal enum At {
          internal enum World {
            /// Star Trader
            internal static let height = L10n.tr("Localizable", "advancement.adventure.trade.at.world.height", fallback: "Star Trader")
          }
        }
      }
      internal enum Two {
        internal enum Birds {
          internal enum One {
            /// Two Birds,
            /// One Arrow
            internal static let arrow = L10n.tr("Localizable", "advancement.adventure.two.birds.one.arrow", fallback: "Two Birds,\nOne Arrow")
          }
        }
      }
      internal enum Very {
        internal enum Very {
          /// Very Very Frightening
          internal static let frightening = L10n.tr("Localizable", "advancement.adventure.very.very.frightening", fallback: "Very Very Frightening")
        }
      }
      internal enum Voluntary {
        /// Voluntary Exile
        internal static let exile = L10n.tr("Localizable", "advancement.adventure.voluntary.exile", fallback: "Voluntary Exile")
      }
      internal enum Walk {
        internal enum On {
          internal enum Powder {
            internal enum Snow {
              internal enum With {
                internal enum Leather {
                  /// Light as a Rabbit
                  internal static let boots = L10n.tr("Localizable", "advancement.adventure.walk.on.powder.snow.with.leather.boots", fallback: "Light as a Rabbit")
                }
              }
            }
          }
        }
      }
      internal enum Whos {
        internal enum The {
          internal enum Pillager {
            /// Who's the Pillager Now?
            internal static let now = L10n.tr("Localizable", "advancement.adventure.whos.the.pillager.now", fallback: "Who's the Pillager Now?")
          }
        }
      }
    }
    internal enum End {
      /// Sky's the
      /// Limit
      internal static let elytra = L10n.tr("Localizable", "advancement.end.elytra", fallback: "Sky's the\nLimit")
      /// Great View From Here
      internal static let levitate = L10n.tr("Localizable", "advancement.end.levitate", fallback: "Great View From Here")
      /// The End
      internal static let root = L10n.tr("Localizable", "advancement.end.root", fallback: "The End")
      internal enum Dragon {
        /// You Need a Mint
        internal static let breath = L10n.tr("Localizable", "advancement.end.dragon.breath", fallback: "You Need a Mint")
        /// The Next Generation
        internal static let egg = L10n.tr("Localizable", "advancement.end.dragon.egg", fallback: "The Next Generation")
      }
      internal enum Enter {
        internal enum End {
          /// Remote
          /// Getaway
          internal static let gateway = L10n.tr("Localizable", "advancement.end.enter.end.gateway", fallback: "Remote\nGetaway")
        }
      }
      internal enum Find {
        internal enum End {
          /// City at the End of the Game
          internal static let city = L10n.tr("Localizable", "advancement.end.find.end.city", fallback: "City at the End of the Game")
          internal enum City {
            /// City at End
            /// of the Game
            internal static let _19 = L10n.tr("Localizable", "advancement.end.find.end.city.19", fallback: "City at End\nof the Game")
          }
        }
      }
      internal enum Kill {
        ///  Free the
        /// End
        internal static let dragon = L10n.tr("Localizable", "advancement.end.kill.dragon", fallback: " Free the\nEnd")
      }
      internal enum Respawn {
        /// The End... Again...
        internal static let dragon = L10n.tr("Localizable", "advancement.end.respawn.dragon", fallback: "The End... Again...")
      }
    }
    internal enum Husbandry {
      /// Our Powers Combined!
      internal static let froglights = L10n.tr("Localizable", "advancement.husbandry.froglights", fallback: "Our Powers Combined!")
      /// Husbandry
      internal static let root = L10n.tr("Localizable", "advancement.husbandry.root", fallback: "Husbandry")
      internal enum Allay {
        internal enum Deliver {
          internal enum Cake {
            internal enum To {
              internal enum Note {
                /// Birthday
                /// Song
                internal static let block = L10n.tr("Localizable", "advancement.husbandry.allay.deliver.cake.to.note.block", fallback: "Birthday\nSong")
              }
            }
          }
          internal enum Item {
            internal enum To {
              /// You've Got a Friend in Me
              internal static let player = L10n.tr("Localizable", "advancement.husbandry.allay.deliver.item.to.player", fallback: "You've Got a Friend in Me")
            }
          }
        }
      }
      internal enum Animals {
        internal enum Bred {
          /// Axolotl
          internal static let axolotl = L10n.tr("Localizable", "advancement.husbandry.animals.bred.axolotl", fallback: "Axolotl")
          /// Bee
          internal static let bee = L10n.tr("Localizable", "advancement.husbandry.animals.bred.bee", fallback: "Bee")
          /// Cat
          internal static let cat = L10n.tr("Localizable", "advancement.husbandry.animals.bred.cat", fallback: "Cat")
          /// Chicken
          internal static let chicken = L10n.tr("Localizable", "advancement.husbandry.animals.bred.chicken", fallback: "Chicken")
          /// Cow
          internal static let cow = L10n.tr("Localizable", "advancement.husbandry.animals.bred.cow", fallback: "Cow")
          /// Donkey
          internal static let donkey = L10n.tr("Localizable", "advancement.husbandry.animals.bred.donkey", fallback: "Donkey")
          /// Fox
          internal static let fox = L10n.tr("Localizable", "advancement.husbandry.animals.bred.fox", fallback: "Fox")
          /// Frog
          internal static let frog = L10n.tr("Localizable", "advancement.husbandry.animals.bred.frog", fallback: "Frog")
          /// Goat
          internal static let goat = L10n.tr("Localizable", "advancement.husbandry.animals.bred.goat", fallback: "Goat")
          /// Hoglin
          internal static let hoglin = L10n.tr("Localizable", "advancement.husbandry.animals.bred.hoglin", fallback: "Hoglin")
          /// Horse
          internal static let horse = L10n.tr("Localizable", "advancement.husbandry.animals.bred.horse", fallback: "Horse")
          /// Llama
          internal static let llama = L10n.tr("Localizable", "advancement.husbandry.animals.bred.llama", fallback: "Llama")
          /// Mooshroom
          internal static let mooshroom = L10n.tr("Localizable", "advancement.husbandry.animals.bred.mooshroom", fallback: "Mooshroom")
          /// Mule
          internal static let mule = L10n.tr("Localizable", "advancement.husbandry.animals.bred.mule", fallback: "Mule")
          /// Ocelot
          internal static let ocelot = L10n.tr("Localizable", "advancement.husbandry.animals.bred.ocelot", fallback: "Ocelot")
          /// Panda
          internal static let panda = L10n.tr("Localizable", "advancement.husbandry.animals.bred.panda", fallback: "Panda")
          /// Pig
          internal static let pig = L10n.tr("Localizable", "advancement.husbandry.animals.bred.pig", fallback: "Pig")
          /// Rabbit
          internal static let rabbit = L10n.tr("Localizable", "advancement.husbandry.animals.bred.rabbit", fallback: "Rabbit")
          /// Sheep
          internal static let sheep = L10n.tr("Localizable", "advancement.husbandry.animals.bred.sheep", fallback: "Sheep")
          /// Strider
          internal static let strider = L10n.tr("Localizable", "advancement.husbandry.animals.bred.strider", fallback: "Strider")
          /// Turtle
          internal static let turtle = L10n.tr("Localizable", "advancement.husbandry.animals.bred.turtle", fallback: "Turtle")
          /// Wolf
          internal static let wolf = L10n.tr("Localizable", "advancement.husbandry.animals.bred.wolf", fallback: "Wolf")
        }
      }
      internal enum Axolotl {
        internal enum In {
          internal enum A {
            /// The Cutest Predator
            internal static let bucket = L10n.tr("Localizable", "advancement.husbandry.axolotl.in.a.bucket", fallback: "The Cutest Predator")
          }
        }
      }
      internal enum Balanced {
        /// A Balanced Diet
        internal static let diet = L10n.tr("Localizable", "advancement.husbandry.balanced.diet", fallback: "A Balanced Diet")
      }
      internal enum Bred {
        internal enum All {
          /// Two by Two
          internal static let animals = L10n.tr("Localizable", "advancement.husbandry.bred.all.animals", fallback: "Two by Two")
        }
      }
      internal enum Breed {
        internal enum An {
          /// The Parrots
          /// and the Bats
          internal static let animal = L10n.tr("Localizable", "advancement.husbandry.breed.an.animal", fallback: "The Parrots\nand the Bats")
        }
      }
      internal enum Cats {
        /// Tuxedo
        internal static let black = L10n.tr("Localizable", "advancement.husbandry.cats.black", fallback: "Tuxedo")
        /// Calico
        internal static let calico = L10n.tr("Localizable", "advancement.husbandry.cats.calico", fallback: "Calico")
        /// Jellie
        internal static let jellie = L10n.tr("Localizable", "advancement.husbandry.cats.jellie", fallback: "Jellie")
        /// Persian
        internal static let persian = L10n.tr("Localizable", "advancement.husbandry.cats.persian", fallback: "Persian")
        /// Ragdoll
        internal static let ragdoll = L10n.tr("Localizable", "advancement.husbandry.cats.ragdoll", fallback: "Ragdoll")
        /// Red
        internal static let red = L10n.tr("Localizable", "advancement.husbandry.cats.red", fallback: "Red")
        /// Siamese
        internal static let siamese = L10n.tr("Localizable", "advancement.husbandry.cats.siamese", fallback: "Siamese")
        /// Tabby
        internal static let tabby = L10n.tr("Localizable", "advancement.husbandry.cats.tabby", fallback: "Tabby")
        /// White
        internal static let white = L10n.tr("Localizable", "advancement.husbandry.cats.white", fallback: "White")
        internal enum All {
          /// Black
          internal static let black = L10n.tr("Localizable", "advancement.husbandry.cats.all.black", fallback: "Black")
        }
        internal enum British {
          /// British
          internal static let shorthair = L10n.tr("Localizable", "advancement.husbandry.cats.british.shorthair", fallback: "British")
        }
      }
      internal enum Complete {
        /// A Complete Catalogue
        internal static let catalogue = L10n.tr("Localizable", "advancement.husbandry.complete.catalogue", fallback: "A Complete Catalogue")
      }
      internal enum Fishy {
        /// Fishy
        /// Business
        internal static let business = L10n.tr("Localizable", "advancement.husbandry.fishy.business", fallback: "Fishy\nBusiness")
      }
      internal enum Foods {
        internal enum Eaten {
          /// Apple
          internal static let apple = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.apple", fallback: "Apple")
          /// Raw Beef
          internal static let beef = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.beef", fallback: "Raw Beef")
          /// Beetroot
          internal static let beetroot = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.beetroot", fallback: "Beetroot")
          /// Bread
          internal static let bread = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.bread", fallback: "Bread")
          /// Carrot
          internal static let carrot = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.carrot", fallback: "Carrot")
          /// Raw Chicken
          internal static let chicken = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.chicken", fallback: "Raw Chicken")
          /// Raw Cod
          internal static let cod = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.cod", fallback: "Raw Cod")
          /// Cookie
          internal static let cookie = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.cookie", fallback: "Cookie")
          /// Raw Mutton
          internal static let mutton = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.mutton", fallback: "Raw Mutton")
          /// Raw Porkchop
          internal static let porkchop = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.porkchop", fallback: "Raw Porkchop")
          /// Potato
          internal static let potato = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.potato", fallback: "Potato")
          /// Pufferfish
          internal static let pufferfish = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.pufferfish", fallback: "Pufferfish")
          /// Raw Rabbit
          internal static let rabbit = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.rabbit", fallback: "Raw Rabbit")
          /// Raw Salmon
          internal static let salmon = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.salmon", fallback: "Raw Salmon")
          internal enum Baked {
            /// Baked Potato
            internal static let potato = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.baked.potato", fallback: "Baked Potato")
          }
          internal enum Beetroot {
            /// Beet Soup
            internal static let soup = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.beetroot.soup", fallback: "Beet Soup")
          }
          internal enum Chorus {
            /// Chorus Fruit
            internal static let fruit = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.chorus.fruit", fallback: "Chorus Fruit")
          }
          internal enum Cooked {
            /// Beef
            internal static let beef = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.cooked.beef", fallback: "Beef")
            /// Chicken
            internal static let chicken = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.cooked.chicken", fallback: "Chicken")
            /// Cod
            internal static let cod = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.cooked.cod", fallback: "Cod")
            /// Mutton
            internal static let mutton = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.cooked.mutton", fallback: "Mutton")
            /// Porkchop
            internal static let porkchop = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.cooked.porkchop", fallback: "Porkchop")
            /// Rabbit
            internal static let rabbit = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.cooked.rabbit", fallback: "Rabbit")
            /// Salmon
            internal static let salmon = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.cooked.salmon", fallback: "Salmon")
          }
          internal enum Dried {
            /// Dried Kelp
            internal static let kelp = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.dried.kelp", fallback: "Dried Kelp")
          }
          internal enum Enchanted {
            internal enum Golden {
              /// God Apple
              internal static let apple = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.enchanted.golden.apple", fallback: "God Apple")
            }
          }
          internal enum Glow {
            /// Glow Berries
            internal static let berries = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.glow.berries", fallback: "Glow Berries")
          }
          internal enum Golden {
            /// Golden Apple
            internal static let apple = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.golden.apple", fallback: "Golden Apple")
            /// Golden Carrot
            internal static let carrot = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.golden.carrot", fallback: "Golden Carrot")
          }
          internal enum Honey {
            /// Honey Bottle
            internal static let bottle = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.honey.bottle", fallback: "Honey Bottle")
          }
          internal enum Melon {
            /// Melon Slice
            internal static let slice = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.melon.slice", fallback: "Melon Slice")
          }
          internal enum Mushroom {
            /// Shroom Stew
            internal static let stew = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.mushroom.stew", fallback: "Shroom Stew")
          }
          internal enum Poisonous {
            /// Poison Potato
            internal static let potato = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.poisonous.potato", fallback: "Poison Potato")
          }
          internal enum Pumpkin {
            /// Pumpkin Pie
            internal static let pie = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.pumpkin.pie", fallback: "Pumpkin Pie")
          }
          internal enum Rabbit {
            /// Rabbit Stew
            internal static let stew = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.rabbit.stew", fallback: "Rabbit Stew")
          }
          internal enum Rotten {
            /// Rotten Flesh
            internal static let flesh = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.rotten.flesh", fallback: "Rotten Flesh")
          }
          internal enum Spider {
            /// Spider Eye
            internal static let eye = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.spider.eye", fallback: "Spider Eye")
          }
          internal enum Suspicious {
            /// Sus Stew
            internal static let stew = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.suspicious.stew", fallback: "Sus Stew")
          }
          internal enum Sweet {
            /// Sweet Berries
            internal static let berries = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.sweet.berries", fallback: "Sweet Berries")
          }
          internal enum Tropical {
            /// Tropical Fish
            internal static let fish = L10n.tr("Localizable", "advancement.husbandry.foods.eaten.tropical.fish", fallback: "Tropical Fish")
          }
        }
      }
      internal enum Kill {
        internal enum Axolotl {
          /// Healing Power of Friendship
          internal static let target = L10n.tr("Localizable", "advancement.husbandry.kill.axolotl.target", fallback: "Healing Power of Friendship")
        }
      }
      internal enum Leash {
        internal enum All {
          internal enum Frog {
            /// Squad Hops Into Town
            internal static let variants = L10n.tr("Localizable", "advancement.husbandry.leash.all.frog.variants", fallback: "Squad Hops Into Town")
          }
        }
      }
      internal enum Make {
        internal enum A {
          internal enum Sign {
            /// Glow and Behold!
            internal static let glow = L10n.tr("Localizable", "advancement.husbandry.make.a.sign.glow", fallback: "Glow and Behold!")
          }
        }
      }
      internal enum Obtain {
        internal enum Netherite {
          /// Serious Dedication
          internal static let hoe = L10n.tr("Localizable", "advancement.husbandry.obtain.netherite.hoe", fallback: "Serious Dedication")
        }
      }
      internal enum Plant {
        /// A Seedy
        /// Place
        internal static let seed = L10n.tr("Localizable", "advancement.husbandry.plant.seed", fallback: "A Seedy\nPlace")
      }
      internal enum Ride {
        internal enum A {
          internal enum Boat {
            internal enum With {
              internal enum A {
                /// Whatever Floats Your Goat!
                internal static let goat = L10n.tr("Localizable", "advancement.husbandry.ride.a.boat.with.a.goat", fallback: "Whatever Floats Your Goat!")
              }
            }
          }
        }
      }
      internal enum Safely {
        internal enum Harvest {
          /// Bee Our
          /// Guest
          internal static let honey = L10n.tr("Localizable", "advancement.husbandry.safely.harvest.honey", fallback: "Bee Our\nGuest")
        }
      }
      internal enum Silk {
        internal enum Touch {
          /// Total Beelocation
          internal static let nest = L10n.tr("Localizable", "advancement.husbandry.silk.touch.nest", fallback: "Total Beelocation")
        }
      }
      internal enum Tactical {
        /// Tactical Fishing
        internal static let fishing = L10n.tr("Localizable", "advancement.husbandry.tactical.fishing", fallback: "Tactical Fishing")
      }
      internal enum Tadpole {
        internal enum In {
          internal enum A {
            /// Bukkit Bukkit
            internal static let bucket = L10n.tr("Localizable", "advancement.husbandry.tadpole.in.a.bucket", fallback: "Bukkit Bukkit")
          }
        }
      }
      internal enum Tame {
        internal enum An {
          /// Best Friends Forever
          internal static let animal = L10n.tr("Localizable", "advancement.husbandry.tame.an.animal", fallback: "Best Friends Forever")
        }
      }
      internal enum Wax {
        /// Wax Off
        internal static let off = L10n.tr("Localizable", "advancement.husbandry.wax.off", fallback: "Wax Off")
        /// Wax On
        internal static let on = L10n.tr("Localizable", "advancement.husbandry.wax.on", fallback: "Wax On")
      }
    }
    internal enum Minecraft {
      /// Minecraft
      internal static let root = L10n.tr("Localizable", "advancement.minecraft.root", fallback: "Minecraft")
      internal enum Cure {
        internal enum Zombie {
          /// Zombie
          /// Doctor
          internal static let villager = L10n.tr("Localizable", "advancement.minecraft.cure.zombie.villager", fallback: "Zombie\nDoctor")
        }
      }
      internal enum Deflect {
        /// Not Today, Thank You
        internal static let arrow = L10n.tr("Localizable", "advancement.minecraft.deflect.arrow", fallback: "Not Today, Thank You")
      }
      internal enum Enchant {
        /// Enchanter
        internal static let item = L10n.tr("Localizable", "advancement.minecraft.enchant.item", fallback: "Enchanter")
      }
      internal enum Enter {
        internal enum The {
          /// The End?
          internal static let end = L10n.tr("Localizable", "advancement.minecraft.enter.the.end", fallback: "The End?")
          /// We Need to Go Deeper
          internal static let nether = L10n.tr("Localizable", "advancement.minecraft.enter.the.nether", fallback: "We Need to Go Deeper")
        }
      }
      internal enum Follow {
        internal enum Ender {
          /// Eye Spy
          internal static let eye = L10n.tr("Localizable", "advancement.minecraft.follow.ender.eye", fallback: "Eye Spy")
        }
      }
      internal enum Form {
        /// Ice Bucket Challenge
        internal static let obsidian = L10n.tr("Localizable", "advancement.minecraft.form.obsidian", fallback: "Ice Bucket Challenge")
      }
      internal enum Iron {
        /// Isn't It Iron Pick
        internal static let tools = L10n.tr("Localizable", "advancement.minecraft.iron.tools", fallback: "Isn't It Iron Pick")
      }
      internal enum Lava {
        /// Hot Stuff
        internal static let bucket = L10n.tr("Localizable", "advancement.minecraft.lava.bucket", fallback: "Hot Stuff")
      }
      internal enum Mine {
        /// Diamonds!
        internal static let diamond = L10n.tr("Localizable", "advancement.minecraft.mine.diamond", fallback: "Diamonds!")
        /// Stone Age
        internal static let stone = L10n.tr("Localizable", "advancement.minecraft.mine.stone", fallback: "Stone Age")
      }
      internal enum Obtain {
        /// Suit Up
        internal static let armor = L10n.tr("Localizable", "advancement.minecraft.obtain.armor", fallback: "Suit Up")
      }
      internal enum Shiny {
        /// Cover Me With Diamonds
        internal static let gear = L10n.tr("Localizable", "advancement.minecraft.shiny.gear", fallback: "Cover Me With Diamonds")
      }
      internal enum Smelt {
        /// Acquire Hardware
        internal static let iron = L10n.tr("Localizable", "advancement.minecraft.smelt.iron", fallback: "Acquire Hardware")
      }
      internal enum Upgrade {
        /// Getting an Upgrade
        internal static let tools = L10n.tr("Localizable", "advancement.minecraft.upgrade.tools", fallback: "Getting an Upgrade")
      }
    }
    internal enum Nether {
      /// Nether
      internal static let root = L10n.tr("Localizable", "advancement.nether.root", fallback: "Nether")
      internal enum All {
        /// How Did We Get Here?
        internal static let effects = L10n.tr("Localizable", "advancement.nether.all.effects", fallback: "How Did We Get Here?")
        /// A Furious Cocktail
        internal static let potions = L10n.tr("Localizable", "advancement.nether.all.potions", fallback: "A Furious Cocktail")
      }
      internal enum Brew {
        /// Local Brewery
        internal static let potion = L10n.tr("Localizable", "advancement.nether.brew.potion", fallback: "Local Brewery")
      }
      internal enum Charge {
        internal enum Respawn {
          /// Not Quite "9" Lives
          internal static let anchor = L10n.tr("Localizable", "advancement.nether.charge.respawn.anchor", fallback: "Not Quite \"9\" Lives")
        }
      }
      internal enum Create {
        /// Bring Home the Beacon
        internal static let beacon = L10n.tr("Localizable", "advancement.nether.create.beacon", fallback: "Bring Home the Beacon")
        internal enum Full {
          /// Beaconator
          internal static let beacon = L10n.tr("Localizable", "advancement.nether.create.full.beacon", fallback: "Beaconator")
        }
      }
      internal enum Distract {
        /// Oh Shiny
        internal static let piglin = L10n.tr("Localizable", "advancement.nether.distract.piglin", fallback: "Oh Shiny")
      }
      internal enum Explore {
        /// Hot Tourist Destinations
        internal static let nether = L10n.tr("Localizable", "advancement.nether.explore.nether", fallback: "Hot Tourist Destinations")
      }
      internal enum Fast {
        /// Subspace Bubble
        internal static let travel = L10n.tr("Localizable", "advancement.nether.fast.travel", fallback: "Subspace Bubble")
      }
      internal enum Find {
        /// Those Were the Days
        internal static let bastion = L10n.tr("Localizable", "advancement.nether.find.bastion", fallback: "Those Were the Days")
        /// A Terrible Fortress
        internal static let fortress = L10n.tr("Localizable", "advancement.nether.find.fortress", fallback: "A Terrible Fortress")
      }
      internal enum Get {
        internal enum Wither {
          /// Spooky Scary Skeleton
          internal static let skull = L10n.tr("Localizable", "advancement.nether.get.wither.skull", fallback: "Spooky Scary Skeleton")
        }
      }
      internal enum Loot {
        /// War Pigs
        internal static let bastion = L10n.tr("Localizable", "advancement.nether.loot.bastion", fallback: "War Pigs")
      }
      internal enum Netherite {
        /// Cover Me in Debris
        internal static let armor = L10n.tr("Localizable", "advancement.nether.netherite.armor", fallback: "Cover Me in Debris")
      }
      internal enum Obtain {
        internal enum Ancient {
          /// Hidden in the Depths
          internal static let debris = L10n.tr("Localizable", "advancement.nether.obtain.ancient.debris", fallback: "Hidden in the Depths")
        }
        internal enum Blaze {
          /// Into Fire
          internal static let rod = L10n.tr("Localizable", "advancement.nether.obtain.blaze.rod", fallback: "Into Fire")
        }
        internal enum Crying {
          /// Who's Cutting Onions?
          internal static let obsidian = L10n.tr("Localizable", "advancement.nether.obtain.crying.obsidian", fallback: "Who's Cutting Onions?")
        }
      }
      internal enum Return {
        internal enum To {
          /// Return to Sender
          internal static let sender = L10n.tr("Localizable", "advancement.nether.return.to.sender", fallback: "Return to Sender")
        }
      }
      internal enum Ride {
        /// This Boat Has Legs
        internal static let strider = L10n.tr("Localizable", "advancement.nether.ride.strider", fallback: "This Boat Has Legs")
        internal enum Strider {
          internal enum In {
            internal enum Overworld {
              /// Feels Like Home
              internal static let lava = L10n.tr("Localizable", "advancement.nether.ride.strider.in.overworld.lava", fallback: "Feels Like Home")
            }
          }
        }
      }
      internal enum Summon {
        /// Withering Heights
        internal static let wither = L10n.tr("Localizable", "advancement.nether.summon.wither", fallback: "Withering Heights")
      }
      internal enum Uneasy {
        /// Uneasy Alliance
        internal static let alliance = L10n.tr("Localizable", "advancement.nether.uneasy.alliance", fallback: "Uneasy Alliance")
      }
      internal enum Use {
        /// Country Lode, Take Me Home
        internal static let lodestone = L10n.tr("Localizable", "advancement.nether.use.lodestone", fallback: "Country Lode, Take Me Home")
      }
      internal enum Visited {
        internal enum Basalt {
          /// Basalt Deltas
          internal static let deltas = L10n.tr("Localizable", "advancement.nether.visited.basalt.deltas", fallback: "Basalt Deltas")
        }
        internal enum Crimson {
          /// Crimson Forest
          internal static let forest = L10n.tr("Localizable", "advancement.nether.visited.crimson.forest", fallback: "Crimson Forest")
        }
        internal enum Nether {
          /// Nether Wastes
          internal static let wastes = L10n.tr("Localizable", "advancement.nether.visited.nether.wastes", fallback: "Nether Wastes")
        }
        internal enum Soul {
          internal enum Sand {
            /// Soul Sand Valley
            internal static let valley = L10n.tr("Localizable", "advancement.nether.visited.soul.sand.valley", fallback: "Soul Sand Valley")
          }
        }
        internal enum Warped {
          /// Warped Forest
          internal static let forest = L10n.tr("Localizable", "advancement.nether.visited.warped.forest", fallback: "Warped Forest")
        }
      }
    }
  }
  internal enum Alert {
    /// Directory not found
    internal static let directoryNotFound = L10n.tr("Localizable", "alert.directory_not_found", fallback: "Directory not found")
    /// Open Minecraft to start tracking
    internal static let enterMinecraft = L10n.tr("Localizable", "alert.enter_minecraft", fallback: "Open Minecraft to start tracking")
    /// Invalid directory
    internal static let invalidDirectory = L10n.tr("Localizable", "alert.invalid_directory", fallback: "Invalid directory")
    /// No directory selected
    internal static let noDirectory = L10n.tr("Localizable", "alert.no_directory", fallback: "No directory selected")
    /// No worlds found
    internal static let noWorlds = L10n.tr("Localizable", "alert.no_worlds", fallback: "No worlds found")
  }
  internal enum App {
    /// SwiftAA
    internal static let title = L10n.tr("Localizable", "app.title", fallback: "SwiftAA")
  }
  internal enum Donate {
    /// Support us on Ko-Fi
    internal static let message = L10n.tr("Localizable", "donate.message", fallback: "Support us on Ko-Fi")
  }
  internal enum Goal {
    /// Advancements
    internal static let advancements = L10n.tr("Localizable", "goal.advancements", fallback: "Advancements")
    /// Cats
    internal static let cats = L10n.tr("Localizable", "goal.cats", fallback: "Cats")
    /// Visited
    internal static let nether = L10n.tr("Localizable", "goal.nether", fallback: "Visited")
    internal enum Animals {
      /// Animals Bred
      internal static let bred = L10n.tr("Localizable", "goal.animals.bred", fallback: "Animals Bred")
    }
    internal enum Biomes {
      /// Biomes Visited
      internal static let visited = L10n.tr("Localizable", "goal.biomes.visited", fallback: "Biomes Visited")
    }
    internal enum Foods {
      /// Foods Eaten
      internal static let eaten = L10n.tr("Localizable", "goal.foods.eaten", fallback: "Foods Eaten")
    }
    internal enum Monsters {
      /// Monsters Killed
      internal static let killed = L10n.tr("Localizable", "goal.monsters.killed", fallback: "Monsters Killed")
    }
  }
  internal enum Info {
    /// Kill **five unique mobs** with one crossbow shot.
    internal static let arbalistic = L10n.tr("Localizable", "info.arbalistic", fallback: "Kill **five unique mobs** with one crossbow shot.")
    /// Be at least **30 blocks** away horizontally when the center of a target is shot with a projectile by the player.
    internal static let bullseye = L10n.tr("Localizable", "info.bullseye", fallback: "Be at least **30 blocks** away horizontally when the center of a target is shot with a projectile by the player.")
    /// While riding a strider, travel **50 blocks** on lava in the Overworld. Only horizontal displacement is counted. 
    /// 
    /// *Traveling in a circle for more than 50 blocks doesn't count.*
    internal static let feelsLikeHome = L10n.tr("Localizable", "info.feels_like_home", fallback: "While riding a strider, travel **50 blocks** on lava in the Overworld. Only horizontal displacement is counted. \n\n*Traveling in a circle for more than 50 blocks doesn't count.*")
    /// Move a distance of **50 blocks** vertically with the Levitation effect applied, regardless of direction or whether it is caused by the effect.
    internal static let greatView = L10n.tr("Localizable", "info.great_view", fallback: "Move a distance of **50 blocks** vertically with the Levitation effect applied, regardless of direction or whether it is caused by the effect.")
    /// Be at least **50 blocks** away horizontally when a skeleton is killed by an arrow after the player has attacked it once.
    internal static let sniperDuel = L10n.tr("Localizable", "info.sniper_duel", fallback: "Be at least **50 blocks** away horizontally when a skeleton is killed by an arrow after the player has attacked it once.")
    /// Use the Nether to travel between 2 points in the Overworld with a distance of **7000 blocks** between each other, which is **875 blocks** in the Nether.
    internal static let subspaceBubble = L10n.tr("Localizable", "info.subspace_bubble", fallback: "Use the Nether to travel between 2 points in the Overworld with a distance of **7000 blocks** between each other, which is **875 blocks** in the Nether.")
    /// Be within **30 blocks** of a lightning strike that doesn't set any blocks on fire, while an unharmed villager is within or up to six blocks above a **30×30×30** volume centered on the lightning strike.
    internal static let surgeProtector = L10n.tr("Localizable", "info.surge_protector", fallback: "Be within **30 blocks** of a lightning strike that doesn't set any blocks on fire, while an unharmed villager is within or up to six blocks above a **30×30×30** volume centered on the lightning strike.")
  }
  internal enum Leaderboard {
    /// Awaiting
    internal static let awaitingVerification = L10n.tr("Localizable", "leaderboard.awaiting_verification", fallback: "Awaiting")
    /// Not Submitted
    internal static let notSubmitted = L10n.tr("Localizable", "leaderboard.not_submitted", fallback: "Not Submitted")
    /// ???
    internal static let unknown = L10n.tr("Localizable", "leaderboard.unknown", fallback: "???")
    /// Verified
    internal static let verified = L10n.tr("Localizable", "leaderboard.verified", fallback: "Verified")
  }
  internal enum Modular {
    /// Leaderboard
    internal static let leaderboard = L10n.tr("Localizable", "modular.leaderboard", fallback: "Leaderboard")
    /// Potion Panel
    internal static let potionPanel = L10n.tr("Localizable", "modular.potion_panel", fallback: "Potion Panel")
  }
  internal enum Notes {
    /// No Notes Recorded
    internal static let `none` = L10n.tr("Localizable", "notes.none", fallback: "No Notes Recorded")
    internal enum Clear {
      /// Clear All
      internal static let all = L10n.tr("Localizable", "notes.clear.all", fallback: "Clear All")
    }
    internal enum Panel {
      internal enum View {
        internal enum Bottom {
          /// Notes
          internal static let title = L10n.tr("Localizable", "notes.panel.view.bottom.title", fallback: "Notes")
        }
        internal enum Top {
          /// Waypoints
          internal static let title = L10n.tr("Localizable", "notes.panel.view.top.title", fallback: "Waypoints")
        }
      }
    }
    internal enum Select {
      /// Select a world to see its notes...
      internal static let world = L10n.tr("Localizable", "notes.select.world", fallback: "Select a world to see its notes...")
    }
  }
  internal enum Overlay {
    /// Show Page Bar
    internal static let bar = L10n.tr("Localizable", "overlay.bar", fallback: "Show Page Bar")
    /// Multi-Page
    internal static let multipage = L10n.tr("Localizable", "overlay.multipage", fallback: "Multi-Page")
    /// Show Statistics
    internal static let showstats = L10n.tr("Localizable", "overlay.showstats", fallback: "Show Statistics")
    /// Ticker Tape
    internal static let tickertape = L10n.tr("Localizable", "overlay.tickertape", fallback: "Ticker Tape")
    /// Toggle Overlay
    internal static let toggle = L10n.tr("Localizable", "overlay.toggle", fallback: "Toggle Overlay")
    internal enum Complete {
      /// %@ has completed
      /// Minecraft: Java Edition (%@)
      /// All Advancements
      internal static func message(_ p1: Any, _ p2: Any) -> String {
        return L10n.tr("Localizable", "overlay.complete.message", String(describing: p1), String(describing: p2), fallback: "%@ has completed\nMinecraft: Java Edition (%@)\nAll Advancements")
      }
      /// Run Stats
      internal static let stats = L10n.tr("Localizable", "overlay.complete.stats", fallback: "Run Stats")
      /// %@
      /// Approximate IGT
      internal static func time(_ p1: Any) -> String {
        return L10n.tr("Localizable", "overlay.complete.time", String(describing: p1), fallback: "%@\nApproximate IGT")
      }
      /// All %d Advancements Complete!
      internal static func title(_ p1: Int) -> String {
        return L10n.tr("Localizable", "overlay.complete.title", p1, fallback: "All %d Advancements Complete!")
      }
      internal enum Stat {
        /// Eaten
        internal static let bread = L10n.tr("Localizable", "overlay.complete.stat.bread", fallback: "Eaten")
        /// KM
        internal static let elytra = L10n.tr("Localizable", "overlay.complete.stat.elytra", fallback: "KM")
        /// Ench'ed
        internal static let enchant = L10n.tr("Localizable", "overlay.complete.stat.enchant", fallback: "Ench'ed")
        /// Thrown
        internal static let pearl = L10n.tr("Localizable", "overlay.complete.stat.pearl", fallback: "Thrown")
        /// Temples
        internal static let temples = L10n.tr("Localizable", "overlay.complete.stat.temples", fallback: "Temples")
      }
    }
    internal enum Style {
      /// Ticker Tape creates an infinite scrolling list of advancements and criteria. Multi-Page separates them into a static set of pages.
      internal static let description = L10n.tr("Localizable", "overlay.style.description", fallback: "Ticker Tape creates an infinite scrolling list of advancements and criteria. Multi-Page separates them into a static set of pages.")
      /// Overlay Style
      internal static let title = L10n.tr("Localizable", "overlay.style.title", fallback: "Overlay Style")
    }
  }
  internal enum Potion {
    /// Potion of Invisibility
    internal static let invisibility = L10n.tr("Localizable", "potion.invisibility", fallback: "Potion of Invisibility")
    /// Potion of Leaping
    internal static let leaping = L10n.tr("Localizable", "potion.leaping", fallback: "Potion of Leaping")
    /// Potion of Night Vision
    internal static let nightVision = L10n.tr("Localizable", "potion.night_vision", fallback: "Potion of Night Vision")
    /// Potion of Slow Falling
    internal static let slowFalling = L10n.tr("Localizable", "potion.slow_falling", fallback: "Potion of Slow Falling")
    /// Potion of Slowness
    internal static let slowness = L10n.tr("Localizable", "potion.slowness", fallback: "Potion of Slowness")
    /// Potion of Strength
    internal static let strength = L10n.tr("Localizable", "potion.strength", fallback: "Potion of Strength")
    /// Potion of Swiftness
    internal static let swiftness = L10n.tr("Localizable", "potion.swiftness", fallback: "Potion of Swiftness")
    /// Potion of Water Breathing
    internal static let waterBreathing = L10n.tr("Localizable", "potion.water_breathing", fallback: "Potion of Water Breathing")
    /// Potion of Weakness
    internal static let weakness = L10n.tr("Localizable", "potion.weakness", fallback: "Potion of Weakness")
  }
  internal enum Settings {
    /// Layout
    internal static let layout = L10n.tr("Localizable", "settings.layout", fallback: "Layout")
    /// Notes
    internal static let notes = L10n.tr("Localizable", "settings.notes", fallback: "Notes")
    /// Overlay
    internal static let overlay = L10n.tr("Localizable", "settings.overlay", fallback: "Overlay")
    /// Theme
    internal static let theme = L10n.tr("Localizable", "settings.theme", fallback: "Theme")
    /// Tracking
    internal static let tracking = L10n.tr("Localizable", "settings.tracking", fallback: "Tracking")
    /// Updates
    internal static let updater = L10n.tr("Localizable", "settings.updater", fallback: "Updates")
    internal enum Alignment {
      /// Center
      internal static let center = L10n.tr("Localizable", "settings.alignment.center", fallback: "Center")
      /// Left
      internal static let leading = L10n.tr("Localizable", "settings.alignment.leading", fallback: "Left")
      /// Alignment
      internal static let title = L10n.tr("Localizable", "settings.alignment.title", fallback: "Alignment")
      /// Right
      internal static let trailing = L10n.tr("Localizable", "settings.alignment.trailing", fallback: "Right")
    }
    internal enum Updater {
      /// Check For Updates
      internal static let check = L10n.tr("Localizable", "settings.updater.check", fallback: "Check For Updates")
      internal enum Auto {
        /// Check for Updates Automatically
        internal static let check = L10n.tr("Localizable", "settings.updater.auto.check", fallback: "Check for Updates Automatically")
      }
      internal enum Last {
        /// Last Checked:
        internal static let checked = L10n.tr("Localizable", "settings.updater.last.checked", fallback: "Last Checked:")
      }
    }
  }
  internal enum Statistic {
    /// Debris: %d
    /// TNT: %d
    internal static func ancientDebris(_ p1: Int, _ p2: Int) -> String {
      return L10n.tr("Localizable", "statistic.ancient_debris", p1, p2, fallback: "Debris: %d\nTNT: %d")
    }
    /// Hives: %d
    internal static func beehives(_ p1: Int) -> String {
      return L10n.tr("Localizable", "statistic.beehives", p1, fallback: "Hives: %d")
    }
    /// Shells
    /// %d / 8
    internal static func shells(_ p1: Int) -> String {
      return L10n.tr("Localizable", "statistic.shells", p1, fallback: "Shells\n%d / 8")
    }
    internal enum AncientDebris {
      /// Done With Netherite
      internal static let done = L10n.tr("Localizable", "statistic.ancient_debris.done", fallback: "Done With Netherite")
    }
    internal enum Beehives {
      /// Done With Bees
      internal static let done = L10n.tr("Localizable", "statistic.beehives.done", fallback: "Done With Bees")
    }
    internal enum GodApple {
      /// Obtain God Apple
      internal static let obtain = L10n.tr("Localizable", "statistic.god_apple.obtain", fallback: "Obtain God Apple")
      /// Obtained God Apple
      internal static let obtained = L10n.tr("Localizable", "statistic.god_apple.obtained", fallback: "Obtained God Apple")
    }
    internal enum Shells {
      /// Conduit Crafted
      internal static let crafted = L10n.tr("Localizable", "statistic.shells.crafted", fallback: "Conduit Crafted")
    }
    internal enum Trident {
      /// Awaiting
      /// Thunder
      internal static let awaiting = L10n.tr("Localizable", "statistic.trident.awaiting", fallback: "Awaiting\nThunder")
      /// Obtain
      /// Trident
      internal static let obtain = L10n.tr("Localizable", "statistic.trident.obtain", fallback: "Obtain\nTrident")
      /// Done With Thunder
      internal static let thunder = L10n.tr("Localizable", "statistic.trident.thunder", fallback: "Done With Thunder")
    }
    internal enum Wither {
      /// Wither Has Been Killed
      internal static let killed = L10n.tr("Localizable", "statistic.wither.killed", fallback: "Wither Has Been Killed")
      /// Skulls
      /// %d / 3
      internal static func skulls(_ p1: Int) -> String {
        return L10n.tr("Localizable", "statistic.wither.skulls", p1, fallback: "Skulls\n%d / 3")
      }
    }
  }
  internal enum Theme {
    /// Copy to Custom
    internal static let copy = L10n.tr("Localizable", "theme.copy", fallback: "Copy to Custom")
    /// Custom
    internal static let custom = L10n.tr("Localizable", "theme.custom", fallback: "Custom")
    /// Presets
    internal static let presets = L10n.tr("Localizable", "theme.presets", fallback: "Presets")
    internal enum Background {
      /// Background Color
      internal static let color = L10n.tr("Localizable", "theme.background.color", fallback: "Background Color")
    }
    internal enum Foreground {
      /// Foreground Color
      internal static let color = L10n.tr("Localizable", "theme.foreground.color", fallback: "Foreground Color")
    }
    internal enum Presets {
      /// Berry
      internal static let berry = L10n.tr("Localizable", "theme.presets.berry", fallback: "Berry")
      /// Blazed
      internal static let blazed = L10n.tr("Localizable", "theme.presets.blazed", fallback: "Blazed")
      /// Brick
      internal static let brick = L10n.tr("Localizable", "theme.presets.brick", fallback: "Brick")
      /// Dark
      internal static let dark = L10n.tr("Localizable", "theme.presets.dark", fallback: "Dark")
      /// Light
      internal static let light = L10n.tr("Localizable", "theme.presets.light", fallback: "Light")
      internal enum Ender {
        /// Ender Pearl
        internal static let pearl = L10n.tr("Localizable", "theme.presets.ender.pearl", fallback: "Ender Pearl")
      }
      internal enum Github {
        /// GitHub Dark
        internal static let dark = L10n.tr("Localizable", "theme.presets.github.dark", fallback: "GitHub Dark")
      }
      internal enum High {
        /// High Contrast
        internal static let contrast = L10n.tr("Localizable", "theme.presets.high.contrast", fallback: "High Contrast")
      }
    }
    internal enum Text {
      /// Text Color
      internal static let color = L10n.tr("Localizable", "theme.text.color", fallback: "Text Color")
    }
  }
  internal enum Tracking {
    /// This application was heavily inspired by and utilizes assets from CTM's AATool for Windows.
    internal static let attribution = L10n.tr("Localizable", "tracking.attribution", fallback: "This application was heavily inspired by and utilizes assets from CTM's AATool for Windows.")
    /// ...
    internal static let browse = L10n.tr("Localizable", "tracking.browse", fallback: "...")
    /// Minimalistic
    internal static let minimalistic = L10n.tr("Localizable", "tracking.minimalistic", fallback: "Minimalistic")
    /// Seamless Tracking
    internal static let seamless = L10n.tr("Localizable", "tracking.seamless", fallback: "Seamless Tracking")
    /// Standard
    internal static let standard = L10n.tr("Localizable", "tracking.standard", fallback: "Standard")
    /// Vertical
    internal static let vertical = L10n.tr("Localizable", "tracking.vertical", fallback: "Vertical")
    internal enum Custom {
      /// Custom Saves Folder
      internal static let saves = L10n.tr("Localizable", "tracking.custom.saves", fallback: "Custom Saves Folder")
    }
    internal enum Enter {
      /// Enter Directory
      internal static let directory = L10n.tr("Localizable", "tracking.enter.directory", fallback: "Enter Directory")
    }
    internal enum Game {
      /// Game Version
      internal static let version = L10n.tr("Localizable", "tracking.game.version", fallback: "Game Version")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
