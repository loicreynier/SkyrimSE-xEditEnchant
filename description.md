# SSEEdit Enchantment Script

[SSEEdit] script to generate enchanted versions of an armor/weapon
from enchantments listed in CSV file with the following format:

```
EDID Suffix;Enchantment Full Name;Item Suffix/Prefix;Charge Count
```

The third value is considered a prefix if it ends with a space,
otherwise it is considered a suffix.
The charge count value is only required for enchanting weapons.
As an example, running this script on `ArmorIronCuirass` from `Skyrim.esm`
using the CSV file

```
Alteration01;EnchArmorFortifyAlteration01 "Fortify Alteration" [ENCH:0007A107];of Minor Alteration
Alteration02;EnchArmorFortifyAlteration02 "Fortify Alteration" [ENCH:000AD49F];of Alteration
```

creates two new items/records:

```
EnchArmorIronCuirassAlteration01 "Iron Armor of Minor Alteration" [ARMO:0010CFB8]
EnchArmorIronCuirassAlteration02 "Iron Armor of Alteration" [ARMO:0010CFB9]
```

The new records are written into the plugin providing the base item record.
Thus, the script should not be run on `Skyrim.esm` as shown in the example.
Running the script on an entire plugin creates enchanted version of all the
armors/weapons inside the plugin.
Using the script on multiple records or on an entire plugin is ill-advised.

## Enchantments CSV Files

CSV files for vanilla enchantments are provided in the `enchantment` folder.
They correspond to the enchantments found in the level lists of the base game.
In Vanilla, (almost) all the enchantments have 6 different levels,
see the [Resist Fire enchantment] as an example.
Low level armors (iron) are only found with enchantments from level 1 to 3
while high level armors (daedric) are found with level 4 to 6 enchantments.
To generate enchantments for an armor from level 3 to 5,
one must the CSV file `armor-03-to-05.csv`.

### Weapons

Generation of enchantments for weapons is done in the same way for armors,
except that the CSV file must provide additional information, the charge
count. Example:

```
AbsorbHealth02;EnchWeaponAbsorbHealth02 "Absorb Health" [ENCH:000AA145];of Absorption;1000
```

## Installation

Copy the scripts from `Edit Scripts` to your installation of SSEEdit.

## Credits

- ElminsterAU and the xEdit team for [SSEEdit]
- [Koveich][Sovngarde] for the Sovngarde font used for the images.
- [Aurora555](https://www.nexusmods.com/skyrimspecialedition/users/3693122)
  for their help improving the script and fixing the CSVs

## My Skyrim mods

- Silver Hand Armored : [SE][SHA_SE] | [LE][SHA_LE]
- Creation Club Display Case Fix: [SE][CCDCF]

[resist fire enchantment]: https://en.uesp.net/wiki/Skyrim:Resist_Fire#Enchanting
[SSEEdit]: https://www.nexusmods.com/skyrimspecialedition/mods/164
[Sovngarde]: https://www.nexusmods.com/skyrimspecialedition/users/34763925
[SHA_SE]: https://www.nexusmods.com/skyrimspecialedition/mods/43033
[SHA_LE]: https://www.nexusmods.com/skyrim/mods/108152
[CCDCF]: https://www.nexusmods.com/skyrimspecialedition/mods/43485
